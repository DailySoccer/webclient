library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/connection_error.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/fblogin.dart';

@Component(
    selector: 'join',
    templateUrl: 'packages/webclient/components/account/join_comp.html',
    useShadowDom: false
)
class JoinComp implements ShadowRootAware {

  int MIN_PASSWORD_LENGTH = 8;
  int MIN_NICKNAME_LENGTH = 4;

  String firstName  = "";
  String lastName   = "";
  String email      = "";
  String nickName   = "";
  String password   = "";
  String rePassword   = "";

  Element nickNameElement;
  Element emailElement;
  Element passwordElement;
  Element rePasswordElement;

  Element nicknameError;
  Element emailError;
  Element passwordError;

  String get theNickName => nickName;
  void set theNickName (String value) {
    nickName = value;
    validateNickName();
  }

  String get theEmail => email;
  void set theEmail (String value) {
    email = value;
    validateEmail();
  }

  String get thePassword => password;
  void set thePassword (String value) {
    password = value;
    validatePassword();
  }

  String get theRePassword => rePassword;
  void set theRePassword (String value) {
    rePassword = value;
    validateRePassword();
  }

  bool get enabledSubmit => nickName.length >= MIN_NICKNAME_LENGTH && StringUtils.isValidEmail(email) && password.length >= MIN_PASSWORD_LENGTH && password == rePassword && _enabledSubmit;

  JoinComp(this._router, this._profileService, this.loadingService, this._rootElement, this._scrDet) {
    _fbLogin = new FBLogin(_router, _profileService);
  }

  void onShadowRoot(emulatedRoot) {
    nickNameElement   = _rootElement.querySelector("#groupNickName");
    emailElement      = _rootElement.querySelector("#groupEmail");
    passwordElement   = _rootElement.querySelector("#groupPassword");
    rePasswordElement = _rootElement.querySelector("#groupRePassword");

    nicknameError = _rootElement.querySelector("#nickNameError");
    nicknameError.parent.style.display = 'none';

    emailError = _rootElement.querySelector("#emailError");
    emailError.parent.style.display = 'none';

    passwordError = _rootElement.querySelector("#passwordError");
    passwordError.parent.style.display = 'none';
    _scrDet.scrollTo('.panel-heading', offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void validateNickName() {
    nickNameElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (nickName.length >= MIN_NICKNAME_LENGTH) {
      nickNameElement.classes.add('valid');
    }
    else {
      nickNameElement.classes.add('not-valid');
    }
  }

  void validateEmail() {
    emailElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (StringUtils.isValidEmail(email)) {
      emailElement.classes.add('valid');
    }
    else {
      emailElement.classes.add('not-valid');
    }
  }

  void validatePassword() {
    passwordElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (password.length >= MIN_PASSWORD_LENGTH) {
      passwordElement.classes.add('valid');
    }
    else {
      passwordElement.classes.add('not-valid');
    }
  }

  void validateRePassword() {
    rePasswordElement.classes.removeAll(['valid', 'not-valid']);
    //Validación de la confirmación del password
    if (password == rePassword) {
      rePasswordElement.classes.add('valid');
    }
    else {
      rePasswordElement.classes.add('not-valid');
    }
  }

  void submitSignup() {
    GameMetrics.logEvent(GameMetrics.SIGNUP_ATTEMPTED);

    nicknameError.parent.style.display = "none";
    emailError.parent.style.display = "none";
    passwordError.parent.style.display = "none";
    _enabledSubmit = false;

    if (password.length < MIN_PASSWORD_LENGTH) {
      _enabledSubmit = true;
      return;
    }
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
            GameMetrics.trackConversion(false);

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

  FBLogin _fbLogin;

  Router _router;
  ProfileService _profileService;
  Element _rootElement;

  ScreenDetectorService _scrDet;
  bool _enabledSubmit = true;

  LoadingService loadingService;
}