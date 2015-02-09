library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/server_error.dart';
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
  int MAX_NICKNAME_LENGTH = 30;

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

  static const String STATE_BEFORE = 'STATE_BEFORE';
  static const String STATE_AFTER   = 'STATE_AFTER';

  String join_state = STATE_BEFORE;

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
    nickNameElement   = _rootElement.querySelector("#nickNameInputGroup");
    emailElement      = _rootElement.querySelector("#emailInputGroup");
    passwordElement   = _rootElement.querySelector("#passwordInputGroup");
    rePasswordElement = _rootElement.querySelector("#rePasswordInputGroup");

    nicknameError = _rootElement.querySelector("#nickNameError")
        ..parent.style.display = 'none';

    emailError = _rootElement.querySelector("#emailError")
        ..parent.style.display = 'none';

    passwordError = _rootElement.querySelector("#passwordError")
        ..parent.style.display = 'none';
    //_scrDet.scrollTo('.panel-heading', offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void validateNickName({bool forceValidation: null}) {
    nickNameElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (nickName.length >= MIN_NICKNAME_LENGTH) {
      nickNameElement.classes.add('valid');
    }
    else {
      nickNameElement.classes.add('not-valid');
    }
    if(forceValidation != null) {
      (forceValidation) ? nickNameElement.classes.add('valid') : nickNameElement.classes.add('not-valid');
    }
  }

  void validateEmail({bool forceValidation: null}) {
    emailElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (StringUtils.isValidEmail(email)) {
      emailElement.classes.add('valid');
    }
    else {
      emailElement.classes.add('not-valid');
    }
    if(forceValidation != null) {
      (forceValidation) ? emailElement.classes.add('valid') : emailElement.classes.add('not-valid');
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

    bool errorDetected = false;

    nicknameError.parent.style.display = "none";
    emailError.parent.style.display = "none";
    passwordError.parent.style.display = "none";
    _enabledSubmit = false;
    loadingService.isLoading = true;

    if (password.length < MIN_PASSWORD_LENGTH) {
      errorDetected =  true;
    }

    if (password != rePassword) {
      passwordError
        ..text = "Las contraseñas no coinciden. Revisa la ortografía"
        ..classes.remove("errorDetected")
        ..classes.add("errorDetected")
        ..parent.style.display = "";
        errorDetected =  true;
    }

    if(errorDetected) {
      _enabledSubmit = true;
      loadingService.isLoading = false;
      return;
    }

    loadingService.isLoading = true;
    _profileService.signup(firstName, lastName, email, nickName, password)
        .then((_) {
          join_state = STATE_AFTER;
          GameMetrics.logEvent(GameMetrics.SIGNUP_SUCCESSFUL);
          loadingService.isLoading = false;
          _rootElement.querySelector("form").style.display = "none";
        })
        .catchError((ServerError error) {
          error.toJson().forEach( (key, value) {
            switch (key)
            {
              case "nickName":
                nicknameError
                  ..text = value[0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
                validateNickName(forceValidation: false);

              break;
              case "email":
                emailError
                  ..text = value[0]
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
                validateEmail(forceValidation: false);
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