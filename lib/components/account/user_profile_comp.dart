library user_profile_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/account/user_profile_comp.html',
    useShadowDom: false
)
class UserProfileComp {

  bool isEditingProfile = false;

  dynamic get userData => _profileManager.user;

  UserProfileComp(this._router, this._profileManager);

  void editPersonalData() {
    _router.go('edit_profile', {});
  }

  ProfileService _profileManager;
  Router _router;
}