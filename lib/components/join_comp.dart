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

  bool _enabledSubmit = true;
  bool get enabledSubmit => nickName.isNotEmpty && email.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  JoinComp(this._router, this._profileService);

  void submitSignup() {

    nicknameError = querySelector('#nickNameError')
                      ..parent.style.display = "none";

    emailError =    querySelector('#emailError')
                      ..parent.style.display = "none";

    passwordError = querySelector('#passwordError')
                      ..parent.style.display = "none";

    _enabledSubmit = false;

    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) => _profileService.login(email, password))
        .then((_) => _router.go('lobby', {}))
        .catchError((Map error) {
          print("keys: ${error.keys.length} - ${error.keys.toString()}");

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
            print("-JOIN_COMP-: Error recibido: ${key}");
          });

          _enabledSubmit = true;
        });
  }

  void navigateTo(String routePath, Map parameters, event) {
    event.preventDefault();
    _router.go(routePath, parameters);
  }


  Router _router;
  ProfileService _profileService;

  @override
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    var errNickName = rootElement.querySelector("#nickNameError")
                        ..parent.style.display = 'none';

    var errEmail = rootElement.querySelector("#emailError")
                        ..parent.style.display = 'none';

    var errPassword = rootElement.querySelector("#passwordError")
                        ..parent.style.display = 'none';

  }
}