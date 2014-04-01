library login_controller;

import 'package:angular/angular.dart';

import '../webclient.dart';
import '../models/user.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {
  User _user = new User();
  
  LoginCtrl(Scope scope) {
    scope['user'] = _user;
  }

  void login() {
    _user.login().then( (_) {
      if ( _user.isLogin ) {
        _user.profile();
      }
      user = _user;
    });
  }
}
