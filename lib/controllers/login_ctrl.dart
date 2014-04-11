library login_controller;

import 'package:angular/angular.dart';

import '../services/user_manager.dart';
import '../models/user.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl {
  User user = new User();
  
  Scope _scope;
  Router _router;
  UserManager _userManager;
  
  LoginCtrl(Scope this._scope, this._router, this._userManager ) {
    print("create LoginCtrl");
  }

  void login() {
    // _scope.$digest();
    
    _userManager.login( user )
      .then( (_) => _router.go('lobby', {}) )
      .catchError( (error) => print("login inválido: $error") );
  }
}
