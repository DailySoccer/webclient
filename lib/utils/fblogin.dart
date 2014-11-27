library fblogin;

import 'package:webclient/utils/js_utils.dart';
import 'dart:js' as js;
import 'package:webclient/services/profile_service.dart';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';

class FBLogin {

  FBLogin(this._router, this._profileManager) {
    js.context['jsLoginFB'] = loginFB;
  }

  void loginFB() {
    //js.JsObject fb = js.context["FB"];
    //fb.callMethod("getLoginStatus", [onGetLoginStatus]);
    JsUtils.runJavascript(null, "getLoginStatus", [onGetLoginStatus], false, "FB");
  }

  void onGetLoginStatus(statusResponse) {
    if (statusResponse["status"]=="connected") {
      loginCallback(statusResponse);
    }
    else if (statusResponse["status"] == 'not_authorized') {
      // El usuario no ha autorizado el uso de su facebook.
    }
    else {
      JsUtils.runJavascript(null, "facebookLogin", [(js.JsObject loginResponse) {
        if (loginResponse["status"]=="connected") {
          loginCallback(loginResponse);
        }
      }]);
    }
  }

  void loginCallback(loginResponse) {
    _profileManager.facebookLogin(loginResponse["authResponse"]["accessToken"])
                          .then((_) => _router.go("lobby", {}))
                          .catchError((error) {
                              Logger.root.severe(error);
                              });
  }

  Router _router;
  ProfileService _profileManager;
}