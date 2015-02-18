library join_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:logging/logging.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/components/modal_comp.dart';

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

  static final String ERROR_CREATING_YOUR_ACCOUNT = "ERROR_CREATING_YOUR_ACCOUNT";
  static final String ERROR_NICKNAME_TAKEN = "ERROR_NICKNAME_TAKEN";
  static final String ERROR_EMAIL_TAKEN = "ERROR_EMAIL_TAKEN";
  static final String ERROR_CHECK_EMAIL_SPELLING = "ERROR_CHECK_EMAIL_SPELLING";
  static final String ERROR_PASSWORD_TOO_SHORT = "ERROR_PASSWORD_TOO_SHORT";

  @NgOneWay("is-modal")
  bool isModal = false;

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
    _fbLogin = new FBLogin(_router, _profileService, () => isModal ? ModalComp.close() : _router.go('lobby', {}));
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
        .then((_) =>  _profileService.login(email, password))
          .then((_) {
            GameMetrics.logEvent(GameMetrics.SIGNUP_SUCCESSFUL);
            GameMetrics.trackConversion(false);

            loadingService.isLoading = false;
            isModal ? ModalComp.close() : _router.go('lobby', {});
        })
        .catchError((ServerError error) {
          error.toJson().forEach( (key, value) {
            switch (key)
            {
              case "nickName":
                nicknameError
                  ..text = _showMsgError(value[0])
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
                validateNickName(forceValidation: false);

              break;
              case "email":
                emailError
                  ..text = _showMsgError(value[0])
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..parent.style.display = "";
                validateEmail(forceValidation: false);
              break;
              case "password":
                passwordError
                  ..text = _showMsgError(value[0])
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

        }, test: (error) => error is ServerError);
  }

  void onAction (String action, [event]) {
    if (event != null) {
      event.preventDefault();
    }

    switch (action) {
      case "SUBMIT":
        submitSignup();
        break;

      case "CANCEL":
        isModal ? ModalComp.close() : _router.go('landing_page', {});
        break;

      case "LOGIN":
        isModal ? _router.go("${_router.activePath.first.name}.login", {}) : _router.go('login', {});
        break;

      default:
        Logger.root.severe("join_comp: onAction: $action");
    }
  }

  Map<String, String> errorMap = {
    ERROR_CREATING_YOUR_ACCOUNT: "An error has occurred while creating your account.",
    ERROR_NICKNAME_TAKEN: "Nickname already taken.",
    ERROR_EMAIL_TAKEN: "Email address already taken.",
    ERROR_CHECK_EMAIL_SPELLING: "Something went wrong, check the spelling on your email address.",
    ERROR_PASSWORD_TOO_SHORT: "Password is too short.",
    "_ERROR_DEFAULT_": "An error has occurred. Please, try again later."
  };

  String _showMsgError(String errorCode) {
    String keyError = errorMap.keys.firstWhere( (key) => errorCode.contains(key), orElse: () => "_ERROR_DEFAULT_" );
    return errorMap[keyError];
  }

  FBLogin _fbLogin;

  Router _router;
  ProfileService _profileService;
  Element _rootElement;

  ScreenDetectorService _scrDet;
  bool _enabledSubmit = true;

  LoadingService loadingService;
}