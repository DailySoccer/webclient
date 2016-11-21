 library login_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/utils/translate_config.dart';

@Component(
    selector: 'login',
    templateUrl: 'login_comp.html'
)
class LoginComp implements OnInit {
  static const String PATH_IF_SUCCESS = "home";
  static const String PATH_IF_FAIL = "home";

  String get emailOrUsername {
    TextInputElement input = document.querySelector("#login-mail");
    return input != null? input.value : "";
  }
  String get password {
    PasswordInputElement input = document.querySelector("#login-password");
    return input != null? input.value : "";
  }

  @Input("is-modal")
  bool isModal = false;

  static final String ERROR_WRONG_EMAIL_OR_PASSWORD = "ERROR_WRONG_EMAIL_OR_PASSWORD";

  bool get enabledSubmit => StringUtils.isValidEmail(emailOrUsername) && password.isNotEmpty && _enabledSubmit;

  String GetLocalizedText(key) {
    return config.translate(key, group:"login");
  }

  LoginComp(this._router, this._profileService, this.loadingService, this._rootElement, this._scrDet) {
    _fbLogin = new FBLogin(_router, _profileService, () => isModal ? ModalComp.close() : _router.navigate([PATH_IF_SUCCESS, {}]));
    //FBLogin.parseXFBML(".fb-login-button");
  }

  @override void ngOnInit() {
    _loginErrorLabel = _rootElement.nativeElement.querySelector("#loginErrorLabel");
    _loginErrorSection = _rootElement.nativeElement.querySelector("#loginErrorSection");
    _loginErrorSection.style.display = 'none';
    _fbLogin.refreshConnectedState();
    //_scrDet.scrollTo('.panel-heading', offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void login() {
    loadingService.isLoading = true;
    //GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED, {"action via": "email"});

    _loginErrorSection.style.display = "none";
    _enabledSubmit = false;

    _profileService.login(emailOrUsername, password)
        .then((_) {
          //GameMetrics.logEvent(GameMetrics.LOGIN_SUCCESSFUL, {"action via": "email"});
          // _profileService.finishTutorial();

          loadingService.isLoading = false;
          isModal ? ModalComp.close() : _router.navigate([PATH_IF_SUCCESS, {}]);
        })
        .catchError((ServerError error) {
          loadingService.isLoading = false;
          _enabledSubmit = true;
          _loginErrorSection.style.display = '';

          _loginErrorLabel
            ..text = _showMsgError(error.toJson()["email"][0])
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected");
        }, test: (error) => error is ServerError);
  }

  void onAction (String action, [event]) {
    if (event != null) {
      event.preventDefault();
    }

    switch (action) {
      case "SUBMIT":
        if (isModal && ModalComp.hasCallback()) {
          _enabledSubmit = false;
          ModalComp.callCallback({"email": emailOrUsername, 
                                  "password":password,
                                  "action": "login",
                                  "onError": (error) {
                                      _enabledSubmit = true;
                                      _loginErrorSection.style.display = '';
                              
                                      _loginErrorLabel
                                        ..text = _showMsgError(error.toJson()["email"][0])
                                        ..classes.remove("errorDetected")
                                        ..classes.add("errorDetected");
                                    }
                                  });
        } else {
          login();
        }
        break;

      case "CANCEL":
        isModal ? ModalComp.close() : _router.navigate([PATH_IF_FAIL, {}]);
        break;

      case "REMEMBER_PASSWORD":
        _router.navigate(['remember_password', {}]);
        break;

      case "JOIN":
        // TODO Angular 2
        // isModal ? _router.go("${_router.activePath.first.name}.join", {}) : _router.go('join', {});
        _router.navigate(['join', {}]);
        break;

      default:
        Logger.root.severe("login_comp: onAction: $action");
    }
  }

  Map<String, String> _errorMap = null;

  Map<String, String> get errorMap {
    if (_errorMap == null) {
      _errorMap = {
        ERROR_WRONG_EMAIL_OR_PASSWORD: GetLocalizedText("loginerror"),
        "_ERROR_DEFAULT_": GetLocalizedText("defaulterror")
      };
    }
    return _errorMap;
  }

  String _showMsgError(String errorCode) {
    String keyError = errorMap.keys.firstWhere( (key) => errorCode.contains(key), orElse: () => "_ERROR_DEFAULT_" );
    return errorMap[keyError];
  }

  bool get isFacebookConnected => _fbLogin.state == "connected";
  
  void makeFacebookLogin() {
    _fbLogin.loginFB();
  }

  FBLogin _fbLogin;

  final Router _router;
  final ProfileService _profileService;
  ElementRef _rootElement;
  Element _loginErrorSection;
  Element _loginErrorLabel;

  bool _enabledSubmit = true;
  ScreenDetectorService _scrDet;
  LoadingService loadingService;
}
