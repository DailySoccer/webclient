library register_controller;

import 'package:angular/angular.dart';

import '../services/user_manager.dart';
import '../models/user.dart';

@NgController(
    selector: '[register-ctrl]',
    publishAs: 'ctrl'
)
class RegisterCtrl {
  User user = new User();
  
  Router _router;
  UserManager _userManager;
  
  RegisterCtrl(Scope scope, this._router, this._userManager) {
    print("create RegisterCtrl");
  }
  
  void register() {
    _userManager.register( user )
      .then( (_) => _router.go('login', {}) )
      .catchError( (error) => print("register inválido: $error") );
  }
}