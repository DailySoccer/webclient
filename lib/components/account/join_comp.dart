library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'join',
    templateUrl: '/packages/webclient/components/account/join_comp.html',
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

  JoinComp(this._router, this._profileService, this._rootElement);

  void onShadowRoot(emulatedRoot) {
    nicknameError = _rootElement.querySelector("#nickNameError");
    nicknameError.parent.style.display = 'none';

    emailError = _rootElement.querySelector("#emailError");
    emailError.parent.style.display = 'none';

    passwordError = _rootElement.querySelector("#passwordError");
    passwordError.parent.style.display = 'none';
    _rootElement.querySelector('#nickName').focus();
  }

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

  Router _router;
  ProfileService _profileService;
  Element _rootElement;

  bool _enabledSubmit = true;
}