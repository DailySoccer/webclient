library view_contest_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:html';

@Component(
    selector: 'view-contest',
    templateUrl: 'packages/webclient/components/view_contest/view_contest_comp.html',
    useShadowDom: false)
class ViewContestComp implements DetachAware {

  ScreenDetectorService scrDet;
  LoadingService loadingService;

  ContestEntry mainPlayer;
  ContestEntry selectedOpponent;

  DateTime updatedDate;
  String lastOpponentSelected = "Adversario";
  bool isOpponentSelected = false;

  List<String> matchesInvolved = [];

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  ViewContestComp(this._routeProvider, this.scrDet, this._refreshTimersService, this._myContestsService, this._profileService, this._flashMessage, this.loadingService) {
    loadingService.isLoading = true;

    _contestId = _routeProvider.route.parameters['contestId'];

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshViewContest(_contestId)
      .then((jsonObject) {
        loadingService.isLoading = false;

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
          // Comenzamos a actualizar la información
          _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE, _updateLive);
        }

      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));

    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  String getPrize(int index) {
    String prizeText = "-";
    if (index < _prizes.length) {
      prizeText = "${_prizes[index]}€";
    }
    return prizeText;
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE);
    _streamListener.cancel();
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

  // Handle que recibe cual es la nueva mediaquery que se aplica.
  void onScreenWidthChange(String msg) {
    if (msg == "xs") {
      _togglerEventsInitialized = false;
    }
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

  void toggleTeamsPanel() {
    if (!_togglerEventsInitialized) {
      JsUtils.runJavascript('#teamsPanel', 'on', {'shown.bs.collapse': onOpenTeamsPanel});
      JsUtils.runJavascript('#teamsPanel', 'on', {'hidden.bs.collapse': onCloseTeamsPanel});
      _togglerEventsInitialized = true;
    }

    // Abrimos el menú si está cerrado
    if (_isTeamsPanelOpen) {
      JsUtils.runJavascript('#teamsPanel', 'collapse', "hide");
    }
    else {
     JsUtils.runJavascript('#teamsPanel', 'collapse', "show");
    }
  }

  void onOpenTeamsPanel(dynamic sender) {
    //resetfiltersButton();
    _isTeamsPanelOpen = true;
    querySelector('#teamsToggler').classes.remove('toggleOff');
    querySelector('#teamsToggler').classes.add('toggleOn');
  }

  void onCloseTeamsPanel(dynamic sender) {
    querySelector('#teamsToggler').classes.remove('toggleOn');
    querySelector('#teamsToggler').classes.add('toggleOff');
    _isTeamsPanelOpen = false;
  }

  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  MyContestsService _myContestsService;

  String _contestId;
  bool _isTeamsPanelOpen  = false;
  bool _togglerEventsInitialized = false;
  var _streamListener;

  List<int> get _prizes => (contest != null) ? contest.prizes : [];
}