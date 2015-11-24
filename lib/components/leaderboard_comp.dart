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

class LeaderboardComp {

  LoadingService loadingService;
  ProfileService profileService;

  int usersToShow = 7;

  String get pointsColumnName => getLocalizedText("trueskill");
  String get moneyColumnName => getLocalizedText("gold");

  String playerPointsHint = '';
  String playerMoneyHint = '';

  bool isThePlayer(id) => id == profileService.user.userId/*get del singleton*/;

  int get achievementsEarned => Achievement.AVAILABLES.where( (achievement) => profileService.user.hasAchievement(achievement["id"]) ).length;

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

  LeaderboardComp (LeaderboardService leaderboardService, this.loadingService, this.profileService) {
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

  void tabChange(String tab) {
    querySelectorAll("#leaderboard-wrapper .tab-pane").classes.remove('active');
    querySelector("#${tab}").classes.add("active");
  }

}