library fblogin;

import 'package:webclient/utils/js_utils.dart';
import 'dart:js' as js;
import 'package:webclient/services/profile_service.dart';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_error.dart';

class FBLogin {

  FBLogin(this._router, this._profileManager, [this._onLogin]) {
    js.context['jsLoginFB'] = loginFB;

    // Default action onLogin
    if (_onLogin == null) {
      _onLogin = () => _router.go("lobby", {});
    }
  }

  void loginFB() {
    //js.JsObject fb = js.context["FB"];
    //fb.callMethod("getLoginStatus", [onGetLoginStatus]);
    JsUtils.runJavascript(null, "getLoginStatus", [onGetLoginStatus], "FB");
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
  
  static void share(Map info) {
    JsUtils.runJavascript(null, "facebookShare", 
        [{'description'   : info.containsKey('description') ?  info['description']  : '',
          'imageUrl'      : info.containsKey('image') ?        info['image']        : '',
          'caption'       : info.containsKey('caption') ?      info['caption']      : '',
          'url'           : info.containsKey('url') ?          info['url']          : 'jugar.epiceleven.com',
          'title'         : info.containsKey('title') ?        info['title']        : null,
          'dartCallback'  : info.containsKey('dartCallback') ? info['dartCallback'] : () => null
        }]
        /*(js.JsObject loginResponse) {
            if (loginResponse["status"]=="connected") {
              loginCallback(loginResponse);
            }
          }]*/);
  }

  void loginCallback(loginResponse) {
    _profileManager.facebookLogin(loginResponse["authResponse"]["accessToken"])
                          .then((_) => _onLogin())
                          .catchError((ServerError error) {
                              Logger.root.severe(error);
                           }, test: (error) => error is ServerError);
  }

  Router _router;
  ProfileService _profileManager;
  Function _onLogin;
}