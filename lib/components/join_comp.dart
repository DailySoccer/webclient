library join_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Component(
    selector: 'join',
    templateUrl: 'packages/webclient/components/join_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class JoinComp implements DetachAware {

  String firstName = "";
  String lastName = "";
  String email;
  String nickName;
  String password;
  bool enabledSubmit = true;

  JoinComp(this._router, this._profileService, this._flashMessage);

  void submitSignup() {
    enabledSubmit = false;

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) => _profileService.login(email, password))
        .then((_) => _router.go('lobby', {}))
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          enabledSubmit = true;
        });
  }

  void detach() {
    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
  }

  void loginPressed() {
    _router.go("login", {});
  }

  Router _router;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
}