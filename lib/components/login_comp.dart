library login_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/login_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class LoginComp implements DetachAware  {
  bool enabledSubmit = true;

  LoginComp(this._router, this._profileManager, this._flashMessage);

  void login(String email, String password, bool rememberMe) {
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

    void registerPressed() {
      _router.go("join", {});
    }

    Router _router;
    ProfileService _profileManager;
    FlashMessagesService _flashMessage;
}
