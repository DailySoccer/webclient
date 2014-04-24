library signup_ctrl;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';


@NgController(
    selector: '[signup-ctrl]',
    publishAs: 'ctrl'
)
class SignupCtrl implements NgDetachAware {

  String firstName;
  String lastName;
  String email;
  String nickName;
  String password;

  SignupCtrl(Scope scope, this._router, this._profileService, this._flashMessage);

  void submitSignup() {
    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) => _profileService.login(email, password))
        .then((_) => _router.go('lobby', {}))
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
  }

  void detach() {
    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
  }

  Router _router;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
}