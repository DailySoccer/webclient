library register_ctrl;

import 'package:angular/angular.dart';

import '../services/user_manager.dart';
import '../models/user.dart';

@NgController(
    selector: '[signup-ctrl]',
    publishAs: 'ctrl'
)
class SignupCtrl {
  User user = new User();

  Router _router;
  UserManager _userManager;

  SignupCtrl(Scope scope, this._router, this._userManager) {
  }

  void submitSignup() {
    _userManager.signup(user)
        .then((_) => _router.go('login', {}))
        .catchError((error) => print("Signup inválido: $error"));
  }
}