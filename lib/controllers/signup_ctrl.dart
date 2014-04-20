library signup_ctrl;

import 'package:angular/angular.dart';

import 'package:webclient/services/profile_service.dart';


@NgController(
    selector: '[signup-ctrl]',
    publishAs: 'ctrl'
)
class SignupCtrl {

  String firstName;
  String lastName;
  String email;
  String nickName;
  String password;

  SignupCtrl(Scope scope, this._router, this._profileService) {
  }

  void submitSignup() {
    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) => /*_router.go('/', {})*/false)
        .catchError((error) => print("TODO: Signup inválido: $error"));
  }

  Router _router;
  ProfileService _profileService;
}