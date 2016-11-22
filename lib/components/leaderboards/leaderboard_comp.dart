library leaderboard_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/facebook_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/models/user_ranking.dart';
import 'package:logging/logging.dart';


@Component(
    selector: 'leaderboard',
    templateUrl: 'packages/webclient/components/leaderboards/leaderboard_comp.html',
    useShadowDom: false
)

class LeaderboardComp implements ShadowRootAware, DetachAware{
  static const String MAIN_RANKING          = "MAIN_RANKING";
  static const String RANKING_BEST_PLAYERS  = "RANKING_BEST_PLAYERS";
  static const String RANKING_MOST_RICH     = "RANKING_MOST_RICH";
  
  int USERS_TO_SHOW = 7;

  String playerPointsHint = '';
  String playerMoneyHint = '';

  LoadingService loadingService;

  String userId = null;

  

  bool isThePlayer(id) => id == userId/*get del singleton*/;
  bool get isLoggedPlayer => _profileService.user != null && userId == _profileService.user.userId;
  bool get showShare => isLoggedPlayer;
  UserRanking userShown = null;

  String get pointsColumnName => getLocalizedText("trueskill");
  String get moneyColumnName => getLocalizedText("gold");

  String get trueskillTabTitle    => getLocalizedText("trueskill_tab",    substitutions: {"PLAYER_POSITION": playerPointsInfo.skillRank});
  String get goldTabTitle         => getLocalizedText("gold_tab",         substitutions: {"PLAYER_POSITION": playerMoneyInfo.goldRank});

  List<UserRanking> pointsUserList;
  List<UserRanking> moneyUserList;

  UserRanking playerPointsInfo = new UserRanking();
  UserRanking playerMoneyInfo = new UserRanking();

  Map _sharingInfoGold = null;
  Map get sharingInfoGold {
    if (_sharingInfoGold == null && userId != null) {
      _sharingInfoGold = FacebookService.leaderboardGold(userId);
    }
    return showShare? _sharingInfoGold : null;
  }
  Map _sharingInfoTrueSkill = null;
  Map get sharingInfoTrueSkill {
    if (_sharingInfoTrueSkill == null && userId != null) {
      _sharingInfoTrueSkill = FacebookService.leaderboardTrueskill(userId);
    }
    return showShare? _sharingInfoTrueSkill : null;
  }

  String getLocalizedText(key, {group: "leaderboard", Map substitutions}) {
    return StringUtils.translate(key, group, substitutions);
  }

  
  String _sectionActive = MAIN_RANKING;
  
  void set sectionActive(String section) { 
    _sectionActive = section;
    tabList = [
      new AppSecondaryTabBarTab("HABILIDAD", () => sectionActive = RANKING_BEST_PLAYERS, () => isRankingBestPlayersActive),
      new AppSecondaryTabBarTab("GANANCIAS", () => sectionActive = RANKING_MOST_RICH,    () => isRankingMostRichActive)
    ];
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Rankings");
    _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
    switch(_sectionActive) {
      case MAIN_RANKING:
        refreshTopBar();
        tabList = [];        
        _appStateService.appTabBarState.show = true;
      break;
      case RANKING_BEST_PLAYERS:
        _appStateService.appTabBarState.show = false;
      break;
      case RANKING_MOST_RICH:
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Rankings");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
        _appStateService.appTabBarState.show = false;
      break;
    }
    // TODO: No tiene sentido obligar a regenerar las listas que ya tenemos construidas
    // refreshList();
    _appStateService.appSecondaryTabBarState.tabList = tabList;
  }
  
  String get sectionActive => _sectionActive;
  
  bool get isMainRankingPlayersActive => sectionActive == MAIN_RANKING;
  bool get isRankingBestPlayersActive => sectionActive == RANKING_BEST_PLAYERS;
  bool get isRankingMostRichActive => sectionActive == RANKING_MOST_RICH;
  
  List<AppSecondaryTabBarTab> tabList = [];
  
  LeaderboardComp ( this._leaderboardService, this.loadingService, 
                    this._profileService, this._appStateService, this._refreshTimersService, 
                    this._router, this._routeProvider, this._rootElement) {
    
    loadingService.isLoading = true;
    userId = 'null';
    if (_routeProvider.parameters.containsKey("userId")) {
      if (_routeProvider.parameters['userId'] != 'me') {
        userId = _routeProvider.parameters['userId'];
      } else if (_profileService.isLoggedIn) {
        userId = _profileService.user.userId;
      }
    } else if(_profileService.isLoggedIn) {
      userId = _profileService.user.userId;
    }

    refreshList();
      
    //refreshTopBar();
    //_appStateService.appSecondaryTabBarState.tabList = tabList;
    sectionActive = MAIN_RANKING;
      
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, refreshTopBar);
  }

  /*
  void tabChange(String tab) {
    querySelectorAll("#leaderboard-wrapper .tab-pane").classes.remove('active');
    Element e = querySelector("#${tab}");
    e.classes.add("active");
  }
  */
  
  Function _goldRankingInterface() {
    Map interface = {
      "id" : (UserRanking userRanking) => userRanking.userId,
      "name" : (UserRanking userRanking) => userRanking.nickName,
      "position" : (UserRanking userRanking) => userRanking.goldRank,
      "points" : (UserRanking userRanking) => userRanking.earnedMoney
    };
    return ({UserRanking userRanking, String name}) => interface.containsKey(name) ? interface[name](userRanking) : "-";
  }
  Function get goldRankingInterface => _goldRankingInterface();

  Function _skillRankingInterface() {
    Map interface = {
      "id" : (UserRanking userRanking) => userRanking.userId,
      "name" : (UserRanking userRanking) => userRanking.nickName,
      "position" : (UserRanking userRanking) => userRanking.skillRank,
      "points" : (UserRanking userRanking) => userRanking.trueSkill
    };
    return ({UserRanking userRanking, String name}) => interface.containsKey(name) ? interface[name](userRanking) : "-";
  }
  Function get skillRankingInterface => _skillRankingInterface();
  
  void refreshList() {
    _leaderboardService.getUsers()
          .then((List<UserRanking> users) {
            pointsUserList = _leaderboardService.skillRanking;
            moneyUserList = _leaderboardService.goldRanking;

            UserRanking userRanking = _leaderboardService.getUser(userId);
            
            playerPointsInfo = (userRanking != null) ? userRanking : pointsUserList.first;
            playerMoneyInfo = (userRanking != null) ? userRanking : moneyUserList.first;
            
            userShown = (userRanking != null) ? userRanking : users.first;

            loadingService.isLoading = false;
          });
  }
  
  
  void detach() {
      _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
  }
  void gotoSection(String section) {
    _router.go('leaderboard', {'section':section, 'userId': userId});
  }

  void tabChange(String tab) {

    //Cambiamos el activo del tab
    _rootElement.querySelectorAll("li").classes.remove('active');
    _rootElement.querySelector("#" + tab.replaceAll("content", "tab")).classes.add("active");

    //Cambiamos el active del tab-pane
    querySelectorAll(".tab-pane").classes.remove("active");
    querySelector("#" + tab).classes.add("active");

    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void refreshTopBar() {
    if (isRankingBestPlayersActive || isRankingMostRichActive) {
      return;
    }
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router, _leaderboardService);
  }

  //TODO: esta función para volver al perfil de usuario.
  void cancelPlayerDetails() {
    sectionActive = MAIN_RANKING;
  }
  
  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var section = _routeProvider.parameters["section"];

    switch(section) {
      case "points":
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_RANKING_COMPLETE, {'rankType' : 'Habilidad'});
        tabChange('points-content');
      break;
      case "money":
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_RANKING_COMPLETE, {'rankType' : 'Ganancias'});
        tabChange('money-content');
      break;
    }
  }

  void showPointsRanking() {
    sectionActive = RANKING_BEST_PLAYERS;
  }
  
  void showMoneyRanking() {
    sectionActive = RANKING_MOST_RICH;
  }

  Router _router;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  AppStateService _appStateService;
  RefreshTimersService _refreshTimersService;
  LeaderboardService _leaderboardService;
  Element _rootElement;
}