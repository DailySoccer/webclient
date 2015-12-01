library user_profile_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/account/user_profile_comp.html',
    useShadowDom: false
)
class UserProfileComp {

  LoadingService loadingService;

  bool isEditingProfile = false;

  dynamic get userData => _profileManager.user;

  Map playerSkillInfo = {'position':'_', 'id':'', 'name': '', 'points': ' '};
  Map playerMoneyInfo = {'position':'_', 'id':'', 'name': '', 'points': '\$ '};

  String getLocalizedText(key, [group = "userprofile"]) {
    return StringUtils.translate(key, group);
  }

  UserProfileComp(this._router, this._profileManager, this.loadingService, LeaderboardService leaderboardService) {
    loadingService.isLoading = true;
    leaderboardService.getUsers()
          .then((List<User> users) {

      List<User> pointsUserListTmp = new List<User>.from(users);
      List<User> moneyUserListTmp = new List<User>.from(users);
      List<Map> pointsUserList;
      List<Map> moneyUserList;

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

      playerSkillInfo = pointsUserList.firstWhere( (Map u1) => userData.userId == u1['id'], orElse:  () => {
        'position': pointsUserList.length,
        'id': "<unknown>",
        'name': "<unknown>",
        'points': 0
      });
      playerMoneyInfo = moneyUserList.firstWhere( (Map u1) => userData.userId == u1['id'], orElse:  () => {
        'position': moneyUserList.length,
        'id': "<unknown>",
        'name': "<unknown>",
        'points': 0
      });

      loadingService.isLoading = false;
    });
  }

  String get rankingPointsPosition {
    return playerSkillInfo['position'].toString();
  }
  String get rankingPoints {
    return playerSkillInfo['points'].toString();
  }
  String get rankingMoneyPosition {
    return playerMoneyInfo['position'].toString();
  }
  String get rankingMoney {
    return playerMoneyInfo['points'].toString();
  }

  void editPersonalData() {
    _router.go('edit_profile', {});
  }
  void goBuyGold() {
    _router.go('shop.gold', {});
  }
  void goLeaderboard() {
    _router.go('leaderboard', {});
  }

  ProfileService _profileManager;
  Router _router;
}