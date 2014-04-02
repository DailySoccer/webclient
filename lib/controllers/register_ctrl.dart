library register_controller;

import 'package:angular/angular.dart';

import '../models/user.dart';

@NgController(
    selector: '[register-ctrl]',
    publishAs: 'ctrl'
)
class RegisterCtrl {
  User user = new User();
  
  /*
   * REVIEW: ¿Queremos ser explícitos a lo que un template puede acceder?
  RegisterCtrl(Scope scope) {
    scope['user'] = user;
  }
  */
  
  void register() {
    user.register().then( (_) {
      print("Register End");
      webclient:user = user;
    });
  }
}