library login_controller;

import 'package:angular/angular.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {
  String email = "";
  String password = "";  

  void login() {
    print('Login: Email($email) Password($password)');
  }
}