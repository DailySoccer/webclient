library view_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:intl/intl.dart';
import 'package:webclient/models/match_event.dart';
import 'dart:html';

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

  List<String> matchesInvolved = [];

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;


  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  ViewContestCtrl(RouteProvider routeProvider, this.scrDet, this._myContestsService, this._profileService, this._dateTimeService, this._flashMessage) {

    _contestId = routeProvider.route.parameters['contestId'];
    initialized = false;

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshContest(_contestId)
      .then((jsonObject) {
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
        _prizes = contest.templateContest.getPrizes();

        updatedDate = _dateTimeService.now;

        // generamos los partidos para el filtro de partidos
        matchesInvolved.clear();
        List<MatchEvent> matchEventsSorted = new List<MatchEvent>.from(contest.templateContest.matchEvents)
            .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
            .. forEach( (match) {
              matchesInvolved.add(match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + _timeDisplayFormat.format(match.startDate) + "h.");
            });

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

  int getPercentOfUsersThatOwn(SoccerPlayer soccerPlayer) {
    int numOwners = contestEntries.fold(0, (prev, contestEntry) => contestEntry.contains(soccerPlayer) ? (prev + 1) : prev );
    return (numOwners * 100 / contestEntries.length).truncate();
  }

  String getPrize(int index) {
    String prizeText = "-";
    if (index < _prizes.length) {
      prizeText = "${_prizes[index]}€";
    }
    return prizeText;
  }

  void detach() {
    if (_timer != null)
      _timer.cancel();
  }

  void _updateLive() {
    // Actualizamos únicamente la lista de live MatchEvents
    _myContestsService.refreshLiveMatchEvents(_myContestsService.lastContest.templateContest.templateContestId)
        .then( (jsonObject) {
          updatedDate = _dateTimeService.now;
        })
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void setTabNameAndShowIt(String name)
  {
    Element anchor = querySelector("#opponentTab");
    anchor.text = name;
    tabChange("opponentFantasyTeam");

    // Tenemos que cambiar a mano tb la clase del tab para que aparezca con el estilo seleccionado.
    List<Element> lis = querySelectorAll("#liveContestTab li");
    lis.forEach( (element) => element.classes.remove('active'));
    anchor.parent.classes.add("active");
  }

  Timer _timer;
  List<int> _prizes = [];

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  MyContestsService _myContestsService;
  DateTimeService _dateTimeService;
  DateFormat _timeDisplayFormat= new DateFormat("E, HH:mm", "es_ES");

  String _contestId;
}