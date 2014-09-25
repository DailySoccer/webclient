library remember_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'remember-password',
    templateUrl: 'packages/webclient/components/remember_password_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class RememberPasswordComp implements ShadowRootAware {

  bool enabledSubmit = true;
  String email = "";

  bool get isEnabledSubmit => email.isNotEmpty && enabledSubmit;

  RememberPasswordComp(this._router, this._profileManager);

  void navigateTo(String route, Map parameters, event)
  {
    event.preventDefault();
    _router.go(route, {});
  }

  void rememberMyPassword() {
    print('-REMEMBER_PASSWORD-: Se ha enviado correctamente');
    _errSection.parent.parent.style.display = "none";
    enabledSubmit = false;
/*
      _profileManager.rememberPassword(email)
          .then((_) => _router.go('lobby', {}))
          .catchError( (error) {
            enabledSubmit = true;
            _errSection
              ..text = error["email"][0]
              ..classes.remove("errorDetected")
              ..classes.add("errorDetected")
              ..parent.parent.style.display = '';
          });
*/
  }

  @override
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    _errSection = rootElement.querySelector("#errLabel");
    _errSection.parent.parent.style.display = 'none';
  }

  Router _router;
  ProfileService _profileManager;
  Element _errSection;
}