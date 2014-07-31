library view_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/template_match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[view-contest-ctrl]',
    publishAs: 'ctrl'
)
class ViewContestCtrl implements DetachAware {

  ScreenDetectorService scrDet;
  dynamic mainPlayer;
  dynamic selectedOpponent;
  bool initialized;

  DateTime updatedDate;

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;

  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  ViewContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._myContestsService, this._profileService, this._flashMessage) {

    _contestId = routeProvider.route.parameters['contestId'];
    initialized = false;

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshContest(_contestId)
      .then((jsonObject) {
        mainPlayer = getContestEntryWithUser(_profileService.user.userId);

        updatedDate = new DateTime.now();

        // Únicamente actualizamos los contests que estén en "live"
        if (_myContestsService.lastContest.templateContest.isLive) {
          _updateLive();

          // Comenzamos a actualizar la información
          _timer = new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateLive());
        }

        initialized = true;
      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  ContestEntry getContestEntryWithUser(String userId) {
    return contestEntries.firstWhere( (entry) => entry.user.userId == userId, orElse: () => null );
  }

  SoccerPlayer getSoccerPlayer(String soccerPlayerId) {
    return _myContestsService.lastContest.templateContest.findSoccerPlayer(soccerPlayerId);
  }

  int getUserPosition(ContestEntry contestEntry) {
    List<ContestEntry> contestsEntries = contestEntriesOrderByPoints;
    for (int i=0; i<contestsEntries.length; i++) {
      if (contestsEntries[i].contestEntryId == contestEntry.contestEntryId)
        return i+1;
    }
    return -1;
  }

  String getUserRemainingTime(ContestEntry contestEntry) {
    return "1";
  }

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