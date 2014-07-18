library live_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[live-contest-ctrl]',
    publishAs: 'ctrl'
)
class LiveContestCtrl implements DetachAware {

  ScreenDetectorService scrDet;
  var mainPlayer;
  var selectedOpponent;
  var initialized;

  var updatedDate;

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : new List<ContestEntry>();


  LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._myContestsService, this._profileService, this._flashMessage) {

    _contestId = routeProvider.route.parameters['contestId'];
    mainPlayer = _profileService.user.userId;
    initialized = false;

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshContest(_contestId)
      .then((jsonObject) {
        updatedDate = new DateTime.now();
        _updateLive();

        // Comenzamos a actualizar la información
        const refreshSeconds = const Duration(seconds:3);
        _timer = new Timer.periodic(refreshSeconds, (Timer t) => _updateLive());

        initialized = true;
      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
 }

  ContestEntry getContestEntryWithUser(String userId) {
    return contestEntries.firstWhere( (entry) => entry.user.userId == userId, orElse: () => null );
  }

  SoccerPlayer getSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;

    // Buscar en la lista de partidos del contest
    for (MatchEvent match in _myContestsService.lastContest.templateContest.templateMatchEvents) {
      soccerPlayer = match.soccerTeamA.findSoccerPlayer(soccerPlayerId);
      if (soccerPlayer == null) {
        soccerPlayer = match.soccerTeamB.findSoccerPlayer(soccerPlayerId);
      }

      // Lo hemos encontrado?
      if (soccerPlayer != null)
        break;
    }

    return soccerPlayer;
  }

  int getUserPosition(ContestEntry contestEntry) {
    List<ContestEntry> contestsEntries = contestEntries;
    for (int i=0; i<contestsEntries.length; i++) {
      if (contestsEntries[i].contestEntryId == contestEntry.contestEntryId)
        return i+1;
    }
    return -1;
  }

  String getUserName(ContestEntry contestEntry) {
    return contestEntry.user.fullName;
  }

  String getUserNickname(ContestEntry contestEntry) {
    return contestEntry.user.nickName;
  }

  String getUserRemainingTime(ContestEntry contestEntry) {
    return "1";
  }

  int getSoccerPlayerScore(String soccerPlayerId) => _myContestsService.getSoccerPlayerScore(soccerPlayerId);
  int getUserScore(ContestEntry contestEntry) => _myContestsService.getUserScore(contestEntry);

  String getPrize(int index) {
    String prize = "-";
    switch(index) {
      case 0: prize = "€100,00"; break;
      case 1: prize = "€50,00"; break;
      case 2: prize = "€30,00"; break;
    }
    return prize;
  }

  void detach() {
    if (_timer != null)
      _timer.cancel();
  }

  void _updateLive() {
    // Actualizamos únicamente la lista de live MatchEvents
    _myContestsService.refreshLiveMatchEvents(_myContestsService.lastContest.templateContest.templateContestId)
        .then( (jsonObject) {
          updatedDate = new DateTime.now();
        })
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
  }

  Timer _timer;

  Scope _scope;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  MyContestsService _myContestsService;

  String _contestId;
}