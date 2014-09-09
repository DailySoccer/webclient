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

  Element errSection;

  LoginComp(this._router, this._profileManager);

  void login() {
    errSection = querySelector('#mailPassError')
                  ..parent.parent.style.display = "none";
    enabledSubmit = false;

    _profileManager.login(email, password)
        .then((_) => _router.go('lobby', {}))
        .catchError( (error) {
          enabledSubmit = true;
          errSection
            ..text = error["email"][0]
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected")
            ..parent.parent.style.display = '';
        });
  }

  bool get isEnabledSubmit => email.isNotEmpty && password.isNotEmpty;

  void registerPressed() {
    _router.go("join", {});
  }

  Router _router;
  ProfileService _profileManager;

  @override
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    var errSection = rootElement.querySelector("#mailPassError");
    errSection.parent.parent.style.display = 'none';
  }
}
