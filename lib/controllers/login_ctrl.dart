library login_ctrl;

import 'package:angular/angular.dart';
import '../services/user_manager.dart';


@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {

  Scope _scope;
  Router _router;
  UserManager _userManager;

  LoginCtrl(Scope this._scope, this._router, this._userManager) {
  }

  void login(String email, String password) {
    _userManager.login(email, password)
      .then( (_) => _router.go('lobby', {}) )
      .catchError( (error) => print("login inválido: $error") );
  }
}
