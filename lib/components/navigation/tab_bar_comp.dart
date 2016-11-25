library tab_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'dart:html';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'dart:async';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/js_utils.dart';

@Component(
    selector: 'tab-bar',
    templateUrl: 'packages/webclient/components/navigation/tab_bar_comp.html',
    useShadowDom: false
)
class TabBarComp {

  static const String LEADERBOARD = "LEADERBOARD";
  static const String MY_CONTESTS = "NEXTS";
  static const String CONTESTS = "CONTEST";
  static const String LIVE_CONESTS = "LIVE_CONTESTS";
  //static const String SCOUTING = "SCOUTING";
  static const String HOME = "HOME";
  
  int numLiveContests = 0;
  int numVirtualHistoryContests = 0;
  int numRealHistoryContests = 0;
  int numUpcomingContests = 0;
  
  Map<String, TabBarItemComp> tabs = {};

  TabBarItemComp get homeTab    {
    tabs[HOME].notificationsCount = 0;
    return tabs[HOME];
  }  
  TabBarItemComp get myContest    {
    tabs[MY_CONTESTS].notificationsCount = _appStateService.appTabBarState.myContestNotifications;
    return tabs[MY_CONTESTS];
  }
  TabBarItemComp get contestsTab    {
    tabs[CONTESTS].notificationsCount = _appStateService.appTabBarState.contestNotifications;
    return tabs[CONTESTS];
  }
  TabBarItemComp get liveContestTab    {
    tabs[LIVE_CONESTS].notificationsCount = _appStateService.appTabBarState.liveContestsNotifications;
    return tabs[LIVE_CONESTS];
  }
  TabBarItemComp get leaderTab    {
    tabs[LEADERBOARD].notificationsCount = _appStateService.appTabBarState.leaderNotifications;
    return tabs[LEADERBOARD];
  }
  /*TabBarItemComp get scoutingTab    {
    tabs[SCOUTING].notificationsCount = _appStateService.appTabBarState.scoutingNotifications;
    return tabs[SCOUTING];
  }*/
  
  
  bool get isShown => _appStateService.appTabBarState.show;

  TabBarComp(this._router, this._loadingService, this._view, this._rootElement, 
                this._dateTimeService, this._profileService, this._templateService, this._contestsService, 
                this._catalogService, this._appStateService, this._leaderboardService, this._refreshTimersService) {
    tabs = { 
            HOME     : new TabBarItemComp( _router, 
                                                name: "Inicio",
                                                iconImage: "images/tabBar/Button_Home.png",
                                                destination: "home"),
            MY_CONTESTS  : new TabBarItemComp( _router, 
                                                name: "Próximos",
                                                iconImage: "images/tabBar/Button_Nexts.png", 
                                                destination: "my_contests",
                                                parameters: {"section": "upcoming"}),
            CONTESTS     : new TabBarItemComp( _router, 
                                                name: "Torneos",
                                                iconImage: "images/tabBar/Button_Contests.png", 
                                                destination: "lobby"),
            LIVE_CONESTS : new TabBarItemComp( _router, 
                                                name: "En Vivo",  
                                                iconImage: "images/tabBar/Button_Lives.png", 
                                                destination: "my_contests",
                                                parameters: {"section": "live"}),
            LEADERBOARD  : new TabBarItemComp( _router, 
                                                name: "Ranking",
                                                iconImage: "images/tabBar/Button_Ranking.png",
                                                destination: "leaderboard",
                                                parameters: {"userId": "me"})/*,
            SCOUTING     : new TabBarItemComp( _router, 
                                                name: "Ojeador",
                                                iconImage: "images/tabBar/Button_Scouting.png",
                                                destination: "scouting")*/
    };
    
    JsUtils.setJavascriptFunction('reevaluateDeepLinking', ([_]) {
      LoadingService.processULData(_router);
    });
    

    this._refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
    this._refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_RANKING_POSITION, _leaderboardService.calculateMyTrueSkillData);
  }
  
  void _refreshMyContests() {
    // Parallel processing using the Future API
    Future.wait([ TemplateService.Instance.refreshTemplateSoccerPlayers(), 
                  _contestsService.countMyContests()])
      .then((List jsonMaps) {
        Map jsonData = jsonMaps[1];
        numVirtualHistoryContests = jsonData.containsKey("numVirtualHistory") ? jsonData["numVirtualHistory"] : 0;
        numRealHistoryContests    = jsonData.containsKey("numRealHistory") ? jsonData["numRealHistory"] : 0;
        numLiveContests           = jsonData.containsKey("numLive") ? jsonData["numLive"] : 0;
        numUpcomingContests       = jsonData.containsKey("numWaiting") ? jsonData["numWaiting"] : 0;
        
        _appStateService.appTabBarState.liveContestsNotifications = numLiveContests;
      })
      .catchError((ServerError error) {
        Logger.root.severe("Error refreshing My Contests");
      }, test: (error) => error is ServerError);
  }
  
  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "TabBar", substitutions);
  }

  Element _rootElement;
  View _view;
  Router _router;
  
  DateTimeService _dateTimeService;
  LoadingService _loadingService;

  TemplateService _templateService;
  CatalogService _catalogService;
  ProfileService _profileService;
  AppStateService _appStateService;
  LeaderboardService _leaderboardService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
}

class TabBarItemComp {
  
  String name = "";
  String iconImage = "";
  String destination = "";
  int notificationsCount = 0;
  bool get isActive {
    bool b = _router.activePath[0].name == destination;
    parameters.forEach((k,v) => b = b && (_router.activePath[0].parameters[k] == v));
    
    return b;
  }
  Map parameters = {};
  
  TabBarItemComp(Router router, {String name: "", String iconImage: "", String destination: "", Map parameters: const {}, int notificationsCount: 0}) {
    this.name = name;
    this.iconImage = iconImage;
    this.destination = destination;
    if (parameters.length > 0) this.parameters = parameters;
    this.notificationsCount = notificationsCount;
    _router = router;
    /*
    _router.onRouteStart.listen((RouteStartEvent event) {
              event.completed.then((_) {
                if (_router.activePath.isNotEmpty) {
                  isActive = _router.activePath[0].name == destination;
                }
              });
            });*/
  }
  
  void goLocation() {
    _router.go(destination, parameters);
  }

  Router _router;
}