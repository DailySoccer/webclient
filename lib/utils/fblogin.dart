library fblogin;

import 'package:webclient/utils/js_utils.dart';
import 'dart:js' as js;
import 'package:webclient/services/profile_service.dart';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:async';

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

    String accessToken = loginResponse["authResponse"]["accessToken"];
    String email = null;
    String id = null;
    String name = null;
    
    JsUtils.runJavascript(null, "facebookProfileInfo", [(js.JsObject profileInfoResponse) {
      if (!profileInfoResponse["error"]) {
        email = profileInfoResponse['email'];
        id = profileInfoResponse['id'];
        name = profileInfoResponse['name'];
      }
      
      // LOGIN
      _profileManager.facebookLogin(accessToken, id, name, email)
                            .then((_) => _onLogin())
                            .catchError((ServerError error) {
                                Logger.root.severe(error);
                             }, test: (error) => error is ServerError);
    }]);
  }
  
  static Map profileImage(String facebookId) {
    Map defaultImage = { 'isDefault' : true, 'url': null };
    if (facebookId == null || facebookId == '') return defaultImage;

    if (_profileImageCache.containsKey(facebookId)) {
      return _profileImageCache[facebookId];
    }
    
    _profileImageCache[facebookId] = defaultImage;
    JsUtils.runJavascript(null, "facebookProfilePhoto", [facebookId, (js.JsObject profileInfoResponse) {
          Map image = {};
          if (profileInfoResponse["error"] == false) {
            image['imageUrl'] = profileInfoResponse['imageUrl'];
            image['isDefault'] = profileInfoResponse['isDefault'];
            _profileImageCache[facebookId] = image;
          } else {
            Logger.root.warning("WTF 3510");
          }
        }]);
    
    return defaultImage;
  }
  
  static Map <String, Map> _profileImageCache = {};
  Router _router;
  ProfileService _profileManager;
  Function _onLogin;
}