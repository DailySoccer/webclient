library signup_ctrl;

import 'package:angular/angular.dart';

import '../services/profile_service.dart';
import '../models/user.dart';

@NgController(
    selector: '[signup-ctrl]',
    publishAs: 'ctrl'
)
class SignupCtrl {

  User user = new User();

  SignupCtrl(Scope scope, this._router, this._profileService) {
  }

  void submitSignup() {
    _profileService.signup(user)
        .then((_) => _router.go('login', {}))
        .catchError((error) => print("Signup inválido: $error"));
  }

  Router _router;
  ProfileService _profileService;
}