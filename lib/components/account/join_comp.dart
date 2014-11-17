library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/connection_error.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
    selector: 'join',
    templateUrl: 'packages/webclient/components/account/join_comp.html',
    useShadowDom: false
)
class JoinComp implements ShadowRootAware {

  String firstName  = "";
  String lastName   = "";
  String email      = "";
  String nickName   = "";
  String password   = "";
  String rePassword   = "";

  Element nicknameError;
  Element emailError;
  Element passwordError;

  bool get enabledSubmit => nickName.isNotEmpty && StringUtils.isValidEmail(email) && password.isNotEmpty && rePassword.isNotEmpty && _enabledSubmit;

  JoinComp(this._router, this._profileService, this.loadingService, this._rootElement);

  void onShadowRoot(emulatedRoot) {
    nicknameError = _rootElement.querySelector("#nickNameError");
    nicknameError.parent.style.display = 'none';

    emailError = _rootElement.querySelector("#emailError");
    emailError.parent.style.display = 'none';

    passwordError = _rootElement.querySelector("#passwordError");
    passwordError.parent.style.display = 'none';
  }

  void submitSignup() {
    GameMetrics.logEvent(GameMetrics.SIGNUP_ATTEMPTED);

    nicknameError.parent.style.display = "none";
    emailError.parent.style.display = "none";
    passwordError.parent.style.display = "none";
    _enabledSubmit = false;

    if (password != rePassword) {
      passwordError
        ..text = "Las contraseñas no coinciden. Revisa la ortografía"
        ..classes.remove("errorDetected")
        ..classes.add("errorDetected")
        ..parent.style.display = "";
        _enabledSubmit = true;
      return;
    }

    loadingService.isLoading = true;
    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) =>  _profileService.login(email, password))
          .then((_) {
            GameMetrics.logEvent(GameMetrics.SIGNUP_SUCCESSFUL);
            GameMetrics.trackConversion(true);

            loadingService.isLoading = false;
            _router.go('lobby', {});
        })
        .catchError((ConnectionError error) {
          error.toJson().forEach( (key, value) {
            switch (key)
            {
              case "nickName":
                nicknameError
                  ..text = value[0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";

              break;
              case "email":
                emailError
                  ..text = value[0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
              break;
              case "password":
                passwordError
                  ..text = value[0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
              break;
              default:
                print('WTF: 1212:Houston, ha pasado algo al hacer join');
              break;
            }
          });
          _enabledSubmit = true;
          loadingService.isLoading = false;

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

  LoadingService loadingService;
}