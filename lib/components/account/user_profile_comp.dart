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

  String getLocalizedText(key) {
    return StringUtils.translate(key, "userprofile");
  }

  UserProfileComp(this._router, this._profileManager);

  void editPersonalData() {
    _router.go('edit_profile', {});
  }

  void closeProfile() {
    _router.go('lobby', {});
  }

  void goTransactions() {
    _router.go('transaction_history', {});
  }

  void goAddFounds() {
    _router.go('add_funds', {});
  }

  void goWithdrawFounds() {
    _router.go('withdraw_funds', {});
  }

  ProfileService _profileManager;
  Router _router;
}