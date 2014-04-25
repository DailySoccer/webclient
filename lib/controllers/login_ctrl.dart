library login_ctrl;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@NgController(
    selector: '[login-ctrl]',
    publishAs: 'ctrl'
)
class LoginCtrl implements NgDetachAware {
  bool enabledSubmit = true;

  LoginCtrl(this._router, this._profileManager, this._flashMessage);

  void login(String email, String password) {
    enabledSubmit = false;
    
    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
    _profileManager.login(email, password)
        .then((_) => _router.go('lobby', {}))
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          enabledSubmit = true;
        });
  }

  void detach() {
    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
  }

  Router _router;
  ProfileService _profileManager;
  FlashMessagesService _flashMessage;
}
