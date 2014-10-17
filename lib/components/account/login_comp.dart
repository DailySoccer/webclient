library login_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/account/login_comp.html',
    useShadowDom: false
)
class LoginComp implements ShadowRootAware  {

  String email = "";
  String password = "";
  String rememberMe;

  LoginComp(this._router, this._profileManager);

  void login() {
    // Ejemplo de llamadas a mixpanel
    GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED);
    _errSection.parent.parent.style.display = "none";
    _enabledSubmit = false;

    _profileManager.login(email, password)
        .then((_) => _router.go('lobby', {}))
        .catchError( (error) {
          _enabledSubmit = true;
          _errSection
            ..text = error["email"][0]
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected")
            ..parent.parent.style.display = '';
        });
  }

  bool get enabledSubmit => email.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(routePath, parameters);
   }

  Router _router;
  ProfileService _profileManager;
  Element _errSection;
  bool _enabledSubmit = true;

  @override void onShadowRoot(emulatedRoot) {
    var rootElement = querySelector("#loginRoot");
    _errSection = rootElement.querySelector("#mailPassError");
    _errSection.parent.parent.style.display = 'none';
    rootElement.querySelector('#login-mail').focus();
  }
}
