library login_ctrl;

import 'package:angular/angular.dart';
import '../services/profile_service.dart';


@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {

  LoginCtrl(Scope this._scope, this._router, this._profileManager) {
  }

  void login(String email, String password) {
    _profileManager.login(email, password)
        .then((_) => _router.go('lobby', {}))
        .catchError((error) => print("login inválido: $error"));
  }

  Scope _scope;
  Router _router;
  ProfileService _profileManager;
}
