library register_controller;

import 'package:angular/angular.dart';

import '../models/user.dart';

@NgController(
    selector: '[register-ctrl]',
    publishAs: 'ctrl'
)
class RegisterCtrl {
  User user = new User();
  
  void register() {
    user.register().then( (_) {
      print("Register End");
    });
  }
}