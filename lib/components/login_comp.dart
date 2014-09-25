library login_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/login_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class LoginComp implements ShadowRootAware  {

  bool enabledSubmit = true;
  String email = "";
  String password = "";
  String rememberMe;

  LoginComp(this._router, this._profileManager);

  void login() {
    _errSection.parent.parent.style.display = "none";
    enabledSubmit = false;

    _profileManager.login(email, password)
        .then((_) => _router.go('lobby', {}))
        .catchError( (error) {
          enabledSubmit = true;
          _errSection
            ..text = error["email"][0]
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected")
            ..parent.parent.style.display = '';
        });
  }

  bool get isEnabledSubmit => email.isNotEmpty && password.isNotEmpty;

  void navigateTo(String routePath, Map parameters, event) {
    event.preventDefault();
    _router.go(routePath, parameters);
  }

  Router _router;
  ProfileService _profileManager;
  Element _errSection;

  @override
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    _errSection = rootElement.querySelector("#mailPassError");
    _errSection.parent.parent.style.display = 'none';
  }
}
