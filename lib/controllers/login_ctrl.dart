library login_controller;

import 'package:angular/angular.dart';

import '../models/user.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {
  User user = new User();
  
  /*
   * REVIEW: ¿Queremos ser explícitos a lo que un template puede acceder?
  LoginCtrl(Scope scope) {
    scope['user'] = user;
  }
  */

  void login() {
    user.login().then( (_) {
      if ( user.isLogin ) {
        user.profile();
      }
      webclient:user = user;
    });
  }
}
