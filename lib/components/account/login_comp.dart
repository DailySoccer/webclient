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
class LoginComp implements ShadowRootAware {

  String email = "";
  String password = "";
  String rememberMe;

  bool get enabledSubmit => email.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  LoginComp(this._router, this._profileManager, this._rootElement);

  @override void onShadowRoot(emulatedRoot) {
    _errSection = _rootElement.querySelector("#mailPassError");
    _errSection.parent.parent.style.display = 'none';
    _rootElement.querySelector('#login-mail').focus();
  }

  void login() {
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

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }

    _router.go(routePath, parameters);
 }

  Router _router;
  ProfileService _profileManager;
  Element _rootElement;
  Element _errSection;

  bool _enabledSubmit = true;
}
