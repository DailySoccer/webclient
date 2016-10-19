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
//import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'my-contests',
  templateUrl: 'packages/webclient/components/my_contests_comp.html',
  useShadowDom: false
)
class MyContestsComp implements DetachAware, ShadowRootAware {
  static const String TAB_WAITING = "waiting";
  static const String TAB_LIVE    = "live";
  static const String TAB_HISTORY = "history";

  bool get tabIsLive => _tabSelected == TAB_LIVE;
  bool get tabIsWaiting => _tabSelected == TAB_WAITING;
  bool get tabIsHistory => _tabSelected == TAB_HISTORY;

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

  bool get hasLiveContests    => numLiveContests > 0 || loadingService.isLoading;
  bool get hasWaitingContests => contestsService.hasWaitingContests || loadingService.isLoading;
  bool get hasHistoryContests => contestsService.hasHistoryContests || loadingService.isLoading;

  int get totalHistoryContestsWinner => contestsService.historyContests.fold(0, (prev, contest) => (contest.getContestEntryWithUser(_profileService.user.userId).position == 0) ? prev+1 : prev);
  int get totalHistoryContestsPrizes => contestsService.historyContests.fold(0, (prev, contest) => prev + contest.getContestEntryWithUser(_profileService.user.userId).prize);

  String getLocalizedText(key) {
    return StringUtils.translate(key, "mycontest");
  }

  MyContestsComp(this.loadingService, this._profileService, this._appStateService, this._refreshTimersService, this.contestsService, this._router, this._routeProvider,
                     this._flashMessage, this._rootElement, TutorialService tutorialService, this._leaderboardService) {

    loadingService.isLoading = true;

    _refreshTopBar();
    //_appStateService.appTopBarState.activeState = AppTopBarState.USER_DATA_CONFIG;
    _appStateService.appTabBarState.show = true;
    _appStateService.appSecondaryTabBarState.tabList = [];

    _tabSelected = TAB_LIVE;

    tutorialService.triggerEnter("my-contests");

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, _refreshTopBar);
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
  }
  
  void _refreshTopBar() {
    if (_tabSelected != TAB_HISTORY) {
      _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router, _leaderboardService);
    }
  }
  
  void _refreshMyContests() {
    if (_tabSelected == TAB_LIVE) {
      contestsService.refreshMyLiveContests().then((_) {
            loadingService.isLoading = false;
            _numLiveContests = contestsService.liveContests.length;
          })
          .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
    }
    else {
      Future refresher = contestsService.countMyLiveContests();
      Future selected = _tabSelected  == TAB_WAITING ? 
                          contestsService.refreshMyActiveContests() : 
                          contestsService.refreshMyHistoryContests();
      Future.wait([refresher, selected])
        .then((List jsonMaps) {
              loadingService.isLoading = false;
              _numLiveContests = jsonMaps[0];
            })
            .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
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
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
  }

  void gotoSection(String section) {
    /*switch (section) {
      case "live":
        GameMetrics.logEvent(GameMetrics.MY_CONTEST_LIVE);
      break;
      case "upcoming":
        GameMetrics.logEvent(GameMetrics.MY_CONTEST_UPCOMING);
      break;
      case "history":
        GameMetrics.logEvent(GameMetrics.MY_CONTEST_HISTORY);
      break;
    }*/
    _router.go('my_contests', {'section':section});
  }

  void tabChange(String tab) {
    /*
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
    */

    _tabSelected = tab.contains(TAB_WAITING)    ? TAB_WAITING
                    : tab.contains(TAB_LIVE)    ? TAB_LIVE
                    : TAB_HISTORY;
    
    if (_tabSelected == TAB_HISTORY) {
      _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Historico");
      _appStateService.appTopBarState.activeState.onLeftColumn = AppTopBarState.GOBACK;
      _appStateService.appTabBarState.show = false;
    }
    
    // Mostramos "cargando..." si no tenemos contests (no se ha entrado anteriormente o está vacío)
    loadingService.isLoading = true;
    /*loadingService.isLoading =  (_tabSelected == TAB_WAITING && !contestsService.hasWaitingContests) ||
                                (_tabSelected == TAB_LIVE && !contestsService.hasLiveContests) ||
                                (_tabSelected == TAB_HISTORY && !contestsService.hasHistoryContests);*/
    _refreshTopBar();
    _refreshMyContests();
  }

  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var section = _routeProvider.parameters["section"];
    switch(section) {
      case "live":
        tabChange('live-contest-content');
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_LIVE_CONTEST_LIST);
      break;
      case "upcoming":
        tabChange('waiting-contest-content');
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_UPCOMING_CONTEST_LIST);
      break;
      case "history":
        tabChange('history-contest-content');
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_HISTORY_LIST);
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
  AppStateService _appStateService;
  
  LeaderboardService _leaderboardService;
}