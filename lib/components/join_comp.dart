library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'join',
    templateUrl: 'packages/webclient/components/join_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class JoinComp implements ShadowRootAware {

  String firstName  = "";
  String lastName   = "";
  String email      = "";
  String nickName   = "";
  String password   = "";

  Element nicknameError;
  Element emailError;
  Element passwordError;

  bool get enabledSubmit => nickName.isNotEmpty && email.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  JoinComp(this._router, this._profileService);

  void submitSignup() {

    nicknameError.parent.style.display = "none";
    emailError.parent.style.display = "none";
    passwordError.parent.style.display = "none";
    _enabledSubmit = false;

    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) => _profileService.login(email, password))
        .then((_) => _router.go('lobby', {}))
        .catchError((Map error) {
       //   print("keys: ${error.keys.length} - ${error.keys.toString()}");

          error.keys.forEach( (key) {
            switch (key)
            {
              case "nickName":
                nicknameError
                  ..text = error[key][0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";

              break;
              case "email":
                emailError
                  ..text = error[key][0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
              break;
              case "email":
                passwordError
                  ..text = error[key][0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
              break;
            }
          });

          _enabledSubmit = true;
        });
  }

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(routePath, parameters);
  }

  @override
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    nicknameError = rootElement.querySelector("#nickNameError");
    nicknameError.parent.style.display = 'none';

    emailError = rootElement.querySelector("#emailError");
    emailError.parent.style.display = 'none';

    passwordError = rootElement.querySelector("#passwordError");
    passwordError.parent.style.display = 'none';
    rootElement.querySelector('#nickName').focus();
  }

  Router _router;
  ProfileService _profileService;
  bool _enabledSubmit = true;

}