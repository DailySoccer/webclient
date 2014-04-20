library menu_ctrl;

import 'package:angular/angular.dart';
import '../services/profile_service.dart';

@NgController(
    selector: '[menu-ctrl]',
    publishAs: 'menuCtrl'
)
class MenuCtrl {
  bool   isLoggedIn = false;
  String fullName = "";
  String nickName = "";

  MenuCtrl(Scope scope, this._profileService) {
    isLoggedIn  = _profileService.isLoggedIn;

    scope.watch("isLoggedIn", (value, _) {
      isLoggedIn = value;

      if (isLoggedIn) {
        fullName = _profileService.user.fullName;
        nickName = _profileService.user.nickName;
      }

    }, context: _profileService);
  }

  void logOut() {
  }


  ProfileService _profileService;
}