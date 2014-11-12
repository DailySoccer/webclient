 library login_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/connection_error.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:js';
import 'package:logging/logging.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/account/login_comp.html',
    useShadowDom: false
)
class LoginComp implements ShadowRootAware {

  String email = "";
  String password = "";
  String rememberMe;

  bool get enabledSubmit => StringUtils.isValidEmail(email) && password.isNotEmpty && _enabledSubmit;

  LoginComp(this._router, this._profileManager, this.loadingService, this._rootElement);

  @override void onShadowRoot(emulatedRoot) {
    _errSection = _rootElement.querySelector("#mailPassError");
    _errSection.parent.parent.style.display = 'none';
  }

  void loginFB() {
    JsUtils.runJavascript(null, "getLoginStatus", [(JsObject statusResponse) {
      if (statusResponse["status"]=="connected") {
        loginCallback(statusResponse);
      }
      else if (statusResponse["status"] == 'not_authorized') {
        // El usuario no ha autorizado el uso de su facebook.
      }
      else {
        JsUtils.runJavascript(null, "facebookLogin", [(JsObject loginResponse) {
          print("facebook login: $loginResponse");
          if (loginResponse["status"]=="connected") {
            loginCallback(loginResponse);
          }
        }]);

        /*
        JsUtils.runJavascript(null, "login", {"cb": , "opts": {"scope": 'public_profile,email'}},
            false, "FB");

        */

      }
    }, true],
    false, "FB");
  }

  void loginCallback(loginResponse) {
    _profileManager.facebookLogin(loginResponse["authResponse"]["accessToken"])
                          .then((_) => _router.go("lobby", {}))
                          .catchError((error) {
                              Logger.root.severe(error);
                              });
  }

  void login() {
    loadingService.isLoading = true;
    GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED);

    _errSection.parent.parent.style.display = "none";
    _enabledSubmit = false;

    _profileManager.login(email, password)
        .then((_) {
          loadingService.isLoading = false;
          _router.go('lobby', {});
        })
        .catchError( (ConnectionError error) {
          loadingService.isLoading = false;
          _enabledSubmit = true;
          _errSection
            ..text = error.toJson()["email"][0]
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected")
            ..parent.parent.style.display = '';
        });
  }

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }

    _router.go(routePath, parameters);
 }

  Router _router;
  ProfileService _profileManager;
  Element _rootElement;
  Element _errSection;

  bool _enabledSubmit = true;

  LoadingService loadingService;
}
