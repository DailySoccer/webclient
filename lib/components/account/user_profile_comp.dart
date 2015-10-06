library user_profile_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/account/user_profile_comp.html',
    useShadowDom: false
)
class UserProfileComp {

  bool isEditingProfile = false;

  dynamic get userData => _profileManager.user;

  String getLocalizedText(key, [group = "userprofile"]) {
    return StringUtils.translate(key, group);
  }
  
  UserProfileComp(this._router, this._profileManager);

  String get rankingPointsPosition {
    return "3";
  }
  num get rankingPoints {
    return 2500;
  }
  String get rankingMoneyPosition {
    return "58";
  }
  num get rankingMoney {
    return 8500;
  }
  
  void editPersonalData() {
    _router.go('edit_profile', {});
  }
  void goBuyGold() {
    _router.go('add_funds', {});
  }
  void goLeaderboard() {
    _router.go('leaderboard', {});
  }

  ProfileService _profileManager;
  Router _router;
}