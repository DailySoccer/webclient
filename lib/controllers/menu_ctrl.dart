library user_ctrl;

import 'package:angular/angular.dart';
import '../services/user_manager.dart';

@NgController(
    selector: '[menu-ctrl]',
    publishAs: 'menuCtrl'
)
class MenuCtrl {
  bool   isLoggedIn = false;
  String fullName = "";
  String nickName = "";

  UserManager _userManager;

  MenuCtrl(Scope scope, this._userManager) {
    isLoggedIn  = _userManager.isLoggedIn;

    scope.watch("isLoggedIn", (value, _) {
      isLoggedIn = value;

      if (isLoggedIn) {
        fullName = _userManager.user.fullName;
        nickName = _userManager.user.nickName;
      }

    }, context: _userManager);
  }

  void logOut() {
  }
}