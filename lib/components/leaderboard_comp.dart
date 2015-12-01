library leaderboard_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';


@Component(
    selector: 'leaderboard',
    templateUrl: 'packages/webclient/components/leaderboard_comp.html',
    useShadowDom: false
)

class LeaderboardComp implements ShadowRootAware{
  
  int USERS_TO_SHOW = 7;

  String playerPointsHint = '';
  String playerMoneyHint = '';
    
  LoadingService loadingService;

  bool isThePlayer(id) => id == _profileService.user.userId/*get del singleton*/;

  int get achievementsEarned => Achievement.AVAILABLES.where( (achievement) => _profileService.user.hasAchievement(achievement["id"]) ).length;

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

  String getLocalizedText(key, {group: "leaderboard", Map substitutions}) {
    return StringUtils.translate(key, group, substitutions);
  }

  LeaderboardComp (LeaderboardService leaderboardService, this.loadingService, this._profileService, this._router, this._routeProvider, this._rootElement) {
    loadingService.isLoading = true;
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

        playerPointsInfo = pointsUserList.firstWhere( (u) => isThePlayer(u['id']), orElse: () => {
          'position': pointsUserList.length,
          'id': "<unknown>",
          'name': "<unknown>",
          'points': 0
        });
        playerMoneyInfo = moneyUserList.firstWhere( (u) => isThePlayer(u['id']), orElse: () => {
          'position': pointsUserList.length,
          'id': "<unknown>",
          'name': "<unknown>",
          'points': 0
        });

        loadingService.isLoading = false;
        //print("Users: ${users.length}");
      });
  }

  /*
  void tabChange(String tab) {
    querySelectorAll("#leaderboard-wrapper .tab-pane").classes.remove('active');
    Element e = querySelector("#${tab}");
    e.classes.add("active");
  }
  */
  void gotoSection(String section) {
    _router.go('leaderboard', {'section':section});
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
  
 
  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var section = _routeProvider.parameters["section"];
    switch(section) {
      case "points":
        tabChange('points-content');
      break;
      case "money":
        tabChange('money-content');
      break;
      case "achievements":
        tabChange('achievements-content');
      break;
    }
  }
  
  Router _router;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  Element _rootElement;
 

}