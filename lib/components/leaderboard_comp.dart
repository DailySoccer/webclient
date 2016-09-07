library leaderboard_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/services/facebook_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';


@Component(
    selector: 'leaderboard',
    templateUrl: 'packages/webclient/components/leaderboard_comp.html',
    useShadowDom: false
)

class LeaderboardComp implements ShadowRootAware{
  static const String MAIN_RANKING          = "MAIN_RANKING";
  static const String RANKING_BEST_PLAYERS  = "RANKING_BEST_PLAYERS";
  static const String RANKING_MOST_RICH     = "RANKING_MOST_RICH";
  static const String ACHIEVEMENTS          = "ACHIEVEMENTS";
  
  int USERS_TO_SHOW = 7;

  String playerPointsHint = '';
  String playerMoneyHint = '';

  LoadingService loadingService;

  String userId = null;

  

  bool isThePlayer(id) => id == userId/*get del singleton*/;
  bool get isLoggedPlayer => _profileService.user != null && userId == _profileService.user.userId;
  bool get showShare => isLoggedPlayer;
  User userShown = null;

  int get achievementsEarned => Achievement.AVAILABLES.where( (achievement) => userShown != null? userShown.hasAchievement(achievement["id"]) : false).length;

  String get pointsColumnName => getLocalizedText("trueskill");
  String get moneyColumnName => getLocalizedText("gold");

  String get trueskillTabTitle    => getLocalizedText("trueskill_tab",    substitutions: {"PLAYER_POSITION": playerPointsInfo['position']});
  String get goldTabTitle         => getLocalizedText("gold_tab",         substitutions: {"PLAYER_POSITION": playerMoneyInfo['position']});
  String get achievementsTabTitle => getLocalizedText("achievements_tab", substitutions: {"PLAYER_ACHIEVEMENTS": achievementsEarned,
                                                                                          "TOTAL_ACHIEVEMENTS": Achievement.AVAILABLES.length});

  List<Map> pointsUserList;
  List<Map> moneyUserList;

  Map playerPointsInfo = {'position':'_', 'id':'', 'name': '', 'points': ' '};
  Map playerMoneyInfo = {'position':'_', 'id':'', 'name': '', 'points': '\$ '};

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
    switch(_sectionActive) {
      case MAIN_RANKING:
        refreshTopBar();
        _appStateService.appTabBarState.show = true;
      break;
      case RANKING_BEST_PLAYERS:        
        //refreshTopBar();
        _appStateService.appSecondaryTabBarState.tabList = tabList;
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Rankings");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
        _appStateService.appTabBarState.show = false;
      break;
      case RANKING_MOST_RICH:
        _appStateService.appSecondaryTabBarState.tabList = tabList;
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Rankings");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
        _appStateService.appTabBarState.show = false;
      break;
      case ACHIEVEMENTS:
        _appStateService.appSecondaryTabBarState.tabList = tabList;
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Perfil");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
        _appStateService.appTabBarState.show = false;
      break;
    }    
  }
  
  String get sectionActive => _sectionActive;
  
  bool get isMainRankingPlayersActive => sectionActive == MAIN_RANKING;
  bool get isRankingBestPlayersActive => sectionActive == RANKING_BEST_PLAYERS;
  bool get isRankingMostRichActive => sectionActive == RANKING_MOST_RICH;
  bool get isAchievementsActive => sectionActive == ACHIEVEMENTS;
  
  List<AppSecondaryTabBarTab> tabList = [];
  
  LeaderboardComp ( LeaderboardService leaderboardService, this.loadingService, 
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

    leaderboardService.getUsers()
      .then((List<User> users) {
        List<User> pointsUserListTmp = new List<User>.from(users);
        List<User> moneyUserListTmp = new List<User>.from(users);

        pointsUserListTmp.sort( (User u1, User u2) => u2.trueSkill.compareTo(u1.trueSkill) );
        moneyUserListTmp.sort( (User u1, User u2) => u2.earnedMoney.compareTo(u1.earnedMoney) );

        int i = 1;
        pointsUserList = pointsUserListTmp.map((User u) => {
              'position': i++,
              'id': u.userId,
              'name': u.nickName,
              'points': StringUtils.parseTrueSkill(u.trueSkill)
              }).toList();

        i = 1;
        moneyUserList = moneyUserListTmp.map((User u) => {
            'position': i++,
            'id': u.userId,
            'name': u.nickName,
            'points': u.earnedMoney
          }).toList();

        playerPointsInfo = pointsUserList.firstWhere( (u) => isThePlayer(u['id']), orElse: () => pointsUserList.first);
        playerMoneyInfo = moneyUserList.firstWhere( (u) => isThePlayer(u['id']), orElse: () => moneyUserList.first);
        userShown = isLoggedPlayer? _profileService.user : users.firstWhere( (u) => isThePlayer(u.userId), orElse: () => users.first);

        loadingService.isLoading = false;
      });
    
      tabList = [
            new AppSecondaryTabBarTab("RANKING DE JUGONES", () => sectionActive = RANKING_BEST_PLAYERS, () => isRankingBestPlayersActive),
            new AppSecondaryTabBarTab("RANKING DE FORADOS", () => sectionActive = RANKING_MOST_RICH,    () => isRankingMostRichActive),
            new AppSecondaryTabBarTab("LOGROS",             () => sectionActive = ACHIEVEMENTS,         () => isAchievementsActive)
      ];
      
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
    if (isRankingBestPlayersActive || isRankingMostRichActive || isAchievementsActive)
      return;
    
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router);
  }

  //TODO: esta función para volver al perfil de usuario.
  void cancelPlayerDetails() {
    print("Cancelado... hay que volver al Perfil de usuario");
  }
  
  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var section = _routeProvider.parameters["section"];

    switch(section) {
      case "points":
        GameMetrics.logEvent(GameMetrics.LEADERBOARD, {'value': 'trueskill'});
        tabChange('points-content');
      break;
      case "money":
        GameMetrics.logEvent(GameMetrics.LEADERBOARD, {'value': 'money'});
        tabChange('money-content');
      break;
      case "achievements":
        GameMetrics.logEvent(GameMetrics.ACHIEVEMENTS);
        tabChange('achievements-content');
      break;
    }
  }

  Router _router;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  AppStateService _appStateService;
  RefreshTimersService _refreshTimersService;
  Element _rootElement;
}