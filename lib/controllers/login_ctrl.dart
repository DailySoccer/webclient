library login_controller;

import 'package:angular/angular.dart';

import '../models/user.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {
  User user = new User();

  void login() {
    user.login().then( (_) {
      if ( user.isLogin )
        user.profile();
    });
  }
}
