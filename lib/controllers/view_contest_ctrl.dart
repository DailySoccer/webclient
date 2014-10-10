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
import 'package:webclient/models/match_event.dart';
import 'dart:html';

@Controller(
    selector: '[view-contest-ctrl]',
    publishAs: 'ctrl'
)
class ViewContestCtrl implements DetachAware {

  ScreenDetectorService scrDet;
  ContestEntry mainPlayer;
  ContestEntry selectedOpponent;

  DateTime updatedDate;
  String lastOpponentSelected = "Adversario";
  bool isOpponentSelected = false;

  List<String> matchesInvolved = [];

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  ViewContestCtrl(this._routeProvider, this.scrDet, this._myContestsService, this._profileService, this._flashMessage) {

    _contestId = _routeProvider.route.parameters['contestId'];

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshContest(_contestId)
      .then((jsonObject) {
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

        updatedDate = DateTimeService.now;

        // generamos los partidos para el filtro de partidos
        matchesInvolved.clear();
        List<MatchEvent> matchEventsSorted = new List<MatchEvent>.from(contest.matchEvents)
            .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
            .. forEach( (match) {
              matchesInvolved.add(match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate));
            });

        // Únicamente actualizamos los contests que estén en "live"
        if (_myContestsService.lastContest.isLive) {
          _updateLive();

          // Comenzamos a actualizar la información
          _timer = new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateLive());
        }

      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
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
    _myContestsService.refreshLiveMatchEvents(_myContestsService.lastContest.templateContestId)
        .then((jsonObject) {
          updatedDate = DateTimeService.now;
        })
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
  }

  void onUserClick(ContestEntry contestEntry) {
    if (contestEntry.contestEntryId == mainPlayer.contestEntryId) {
      tabChange('userFantasyTeam');
    }
    else {
      switch (_routeProvider.route.name)
      {
        case "live_contest":
        case "history_contest":
          selectedOpponent = contestEntry;
          isOpponentSelected = true;
          setTabNameAndShowIt(contestEntry.user.nickName);
        break;
      }
    }
  }

  void tabChange(String tab) {
    if (tab == "opponentFantasyTeam" && !isOpponentSelected) {
      return;
    }
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

    List<dynamic> allTabButtons = document.querySelectorAll("#liveContestTab li");
    allTabButtons.forEach((element) => element.classes.remove('active'));

    // activamos el tab button
    Element tabButton = document.querySelector("#" + tab + "Tab");
    if (tabButton != null) {
      tabButton.parent.classes.add("active");
    }

  }

  void setTabNameAndShowIt(String name)
  {
    lastOpponentSelected = name;
    Element anchor = querySelector("#opponentFantasyTeamTab");

    if (anchor != null) {
      anchor.text = lastOpponentSelected;
      tabChange("opponentFantasyTeam");

      // Tenemos que cambiar a mano tb la clase del tab para que aparezca con el estilo seleccionado.
      List<Element> lis = querySelectorAll("#liveContestTab li");
      lis.forEach( (element) => element.classes.remove('active'));
      anchor.parent.classes.add("active");
    }
  }

  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  MyContestsService _myContestsService;

  Timer _timer;
  List<int> get _prizes => (contest != null) ? contest.prizes : [];
  String _contestId;
}