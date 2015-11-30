library my_contests_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:async';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/tutorial_service.dart';

@Component(
  selector: 'my-contests',
  templateUrl: 'packages/webclient/components/my_contests_comp.html',
  useShadowDom: false
)
class MyContestsComp implements DetachAware, ShadowRootAware {
  static const String TAB_WAITING = "waiting";
  static const String TAB_LIVE = "live";
  static const String TAB_HISTORY = "history";

  ContestsService contestsService;
  LoadingService loadingService;

  Map liveSortType    = {'fieldName':'contest-start-time', 'order': 1};
  Map waitingSortType = {'fieldName':'contest-start-time', 'order': 1};
  Map historySortType = {'fieldName':'contest-start-time', 'order': -1};

  String get liveContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasLiveContests? "${contestsService.liveContests.length} ${getLocalizedText("hasLivecontests1")}" :
                             getLocalizedText("hasLivecontests2");
  }
  String get waitingContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasWaitingContests ? "${getLocalizedText("haswaitingcontests1")} ${contestsService.waitingContests.length} ${getLocalizedText("haswaitingcontests2")}" :
                                 getLocalizedText("haswaitingcontests3");
  }
  String get historyContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasHistoryContests? "${contestsService.historyContests.length} ${getLocalizedText("hasHistoryContests1")} / ${totalHistoryContestsWinner} ${getLocalizedText("hasHistoryContests2")}" :
                                getLocalizedText("hasHistoryContests3");
  }

  num get numLiveContests => _numLiveContests;

  bool get hasLiveContests    => numLiveContests > 0;
  bool get hasWaitingContests => contestsService.hasWaitingContests;
  bool get hasHistoryContests => contestsService.hasHistoryContests;

  int get totalHistoryContestsWinner => contestsService.historyContests.fold(0, (prev, contest) => (contest.getContestEntryWithUser(_profileService.user.userId).position == 0) ? prev+1 : prev);
  int get totalHistoryContestsPrizes => contestsService.historyContests.fold(0, (prev, contest) => prev + contest.getContestEntryWithUser(_profileService.user.userId).prize);

  String getLocalizedText(key) {
    return StringUtils.translate(key, "mycontest");
  }

  MyContestsComp(this.loadingService, this._profileService, this._refreshTimersService, this.contestsService, this._router, this._routeProvider,
                     this._flashMessage, this._rootElement, TutorialService tutorialService) {

    loadingService.isLoading = true;

    _tabSelected = TAB_LIVE;

    tutorialService.triggerEnter("my-contests");

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
  }

  void _refreshMyContests() {
    Future myContests =
          _tabSelected  == TAB_WAITING  ? contestsService.refreshMyActiveContests()
        : _tabSelected  == TAB_LIVE     ? contestsService.refreshMyLiveContests()
        : contestsService.refreshMyHistoryContests()
        .. then((_) {
          loadingService.isLoading = false;

          // Actualizar el número de contests "live"
          if (_tabSelected == TAB_LIVE) {
            _numLiveContests = contestsService.liveContests.length;
          }
        })
        .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);

    // Cuando no estamos en "live" tenemos que actualizar el número de "live" con una query independiente
    if (_tabSelected != TAB_LIVE) {
      contestsService.countMyLiveContests().then((count) {
        _numLiveContests = count;
      });
    }
  }

  void onWaitingActionClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId": contest.contestId, "parent": "my_contests", "viewContestEntryMode": "viewing"});
  }

  void onLiveActionClick(Contest contest) {
    _router.go('live_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void onHistoryActionClick(Contest contest) {
    _router.go('history_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void gotoLobby() {
    _router.go("lobby", {});
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS);
  }

  void gotoSection(String section) {
    _router.go('my_contests', {'section':section});
  }

  void tabChange(String tab) {

    //Cambiamos el activo del tab
    _rootElement.querySelectorAll("#myContestMenuTabs li").classes.remove('active');
    _rootElement.querySelector("#" + tab.replaceAll("content", "tab")).classes.add("active");
    
    //Cambiamos el active del tab-pane
    querySelectorAll(".tab-pane").classes.remove("active");
    querySelector("#" + tab).classes.add("active");

    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

    _tabSelected = tab.contains(TAB_WAITING)    ? TAB_WAITING
                    : tab.contains(TAB_LIVE)    ? TAB_LIVE
                    : TAB_HISTORY;

    // Mostramos "cargando..." si no tenemos contests (no se ha entrado anteriormente o está vacío)
    loadingService.isLoading =  (_tabSelected == TAB_WAITING && !contestsService.hasWaitingContests) ||
                                (_tabSelected == TAB_LIVE && !contestsService.hasLiveContests) ||
                                (_tabSelected == TAB_HISTORY && !contestsService.hasHistoryContests);
    _refreshMyContests();
  }

  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var section = _routeProvider.parameters["section"];
    switch(section) {
      case "live":
        tabChange('live-contest-content');
      break;
      case "upcoming":
        tabChange('waiting-contest-content');
      break;
      case "history":
        tabChange('history-contest-content');
      break;
    }
  }

  Element _rootElement;
  num _numLiveContests = 0;

  Router _router;
  RouteProvider _routeProvider;

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;

  String _tabSelected = TAB_LIVE;
}