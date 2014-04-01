library register_controller;

import 'package:angular/angular.dart';

import '../webclient.dart';
import '../models/user.dart';

@NgController(
    selector: '[register-ctrl]',
    publishAs: 'ctrl'
)
class RegisterCtrl {
  User _user = new User();
  
  RegisterCtrl(Scope scope) {
    scope['user'] = _user;
  }
  
  void register() {
    _user.register().then( (_) {
      print("Register End");
      user = _user;
    });
  }
}