 library login_comp;

import 'package:angular/angular.dart';
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
import 'package:webclient/components/base_comp.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/account/login_comp.html',
    useShadowDom: false
)
class LoginComp extends BaseComp implements ShadowRootAware {

  String emailOrUsername = "";
  String password = "";
  String rememberMe;

  @NgOneWay("is-modal")
  bool isModal = false;

  static final String ERROR_WRONG_EMAIL_OR_PASSWORD = "ERROR_WRONG_EMAIL_OR_PASSWORD";

  bool get enabledSubmit => StringUtils.isValidEmail(emailOrUsername) && password.isNotEmpty && _enabledSubmit;

  LoginComp(this._router, this._profileManager, this.loadingService, this._rootElement, this._scrDet) {
    _fbLogin = new FBLogin(_router, _profileManager, () => isModal ? ModalComp.close() : _router.go('lobby', {}));
  }

  @override void onShadowRoot(emulatedRoot) {
    _loginErrorLabel = _rootElement.querySelector("#loginErrorLabel");
    _loginErrorSection = _rootElement.querySelector("#loginErrorSection");
    _loginErrorSection.style.display = 'none';
    //_scrDet.scrollTo('.panel-heading', offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void login() {
    loadingService.isLoading = true;
    GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED);

    _loginErrorSection.style.display = "none";
    _enabledSubmit = false;

    _profileManager.login(emailOrUsername, password)
        .then((_) {
          GameMetrics.logEvent(GameMetrics.LOGIN_SUCCESSFUL);
          _profileManager.finishTutorial();

          loadingService.isLoading = false;
          isModal ? ModalComp.close() : _router.go('lobby', {});
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
        login();
        break;

      case "CANCEL":
        isModal ? ModalComp.close() : _router.go('landing_page', {});
        break;

      case "REMEMBER_PASSWORD":
        _router.go('remember_password', {});
        break;

      case "JOIN":
        isModal ? _router.go("${_router.activePath.first.name}.join", {}) : _router.go('join', {});
        break;

      default:
        Logger.root.severe("login_comp: onAction: $action");
    }
  }

  Map<String, String> get errorMap => {
    ERROR_WRONG_EMAIL_OR_PASSWORD: T.errorWrongEmailOrPassword,
    "_ERROR_DEFAULT_": T.errorDefault
  };

  String _showMsgError(String errorCode) {
    String keyError = errorMap.keys.firstWhere( (key) => errorCode.contains(key), orElse: () => "_ERROR_DEFAULT_" );
    return errorMap[keyError];
  }


  FBLogin _fbLogin;

  Router _router;
  ProfileService _profileManager;
  Element _rootElement;
  Element _loginErrorSection;
  Element _loginErrorLabel;

  bool _enabledSubmit = true;
  ScreenDetectorService _scrDet;
  LoadingService loadingService;
}
