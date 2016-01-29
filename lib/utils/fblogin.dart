library fblogin;

import 'package:webclient/utils/js_utils.dart';
import 'dart:js' as js;
import 'package:webclient/services/profile_service.dart';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:async';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/string_utils.dart';

class FBLogin {

  FBLogin(Router router, ProfileService _profileService, [Function onLogin]) {
    _router = router;
    _profileManager = _profileService;
    _onLogin = onLogin;
    js.context['jsLoginFB'] = loginFB;
    
    // Default action onLogin
    if (_onLogin == null) {
      _onLogin = () => _router.go("lobby", {});
    }
  }

  void loginFB() {
    //js.JsObject fb = js.context["FB"];
    //fb.callMethod("getLoginStatus", [onGetLoginStatus]);
    JsUtils.runJavascript(null, "facebookLoginStatus", [onGetLoginStatus]);
  }

  void onGetLoginStatus(statusResponse) {
    if (statusResponse["status"] == "connected") {
      loginCallback(statusResponse);
    } else if (statusResponse["status"] == 'not_authorized') {
      // El usuario no ha autorizado el uso de su facebook.
    } else {
      JsUtils.runJavascript(null, "facebookLogin", [(js.JsObject loginResponse) {
        if (loginResponse["status"] == "connected") {
          loginCallback(loginResponse);
        }
      }]);
    }
  }
  
  static Future<Map> getFacebookPermissions() {
    Completer<Map> completer = new Completer<Map>();
    
    JsUtils.runJavascript(null, "facebookPermissions", [(js.JsObject permissionsResponse) {
      if (permissionsResponse["error"] == false) {
        js.JsArray permissionsJS = permissionsResponse['data'];
        Map permissions = {};
        permissionsJS.forEach( (p) => permissions[p['permission']] = (p['status'] == 'granted') );
        
        completer.complete(permissions);
      } else {
        completer.completeError({});
      }
    }]);
    return completer.future;  
  }
  
  static void share(Map info) {
    JsUtils.runJavascript(null, "facebookShare", 
        [{'description'   : info.containsKey('description')  ? info['description']  : '',
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

  static void loginCallback(loginResponse) {
    getFacebookPermissions().then( (permissions) {
      if ( _checkPermissions(permissions) ) {
        serverLoginWithFB();
      } else {
        // ERROR
        rerequestLoginModal();
      }
    });
  }
  
  static void serverLoginWithFB() {
    profileInfo().then((info) {
              String accessToken = info['accessToken'];
              String email       = info['email'];
              String id          = info['id'];
              String name        = info['name'];
              // LOGIN
              _profileManager.facebookLogin(accessToken, id, name, email)
                                    .then((_) => _onLogin())
                                    .catchError((ServerError error) {
                                        Logger.root.severe(error);
                                     }, test: (error) => error is ServerError);
            });
  }
  
  static Future<Map> profileInfo() {
    Completer<Map> completer = new Completer<Map>();

    JsUtils.runJavascript(null, "facebookProfileInfo", [(js.JsObject profileInfoResponse) {
      Map info = {};
      if (!profileInfoResponse["error"]) {
        info['accessToken'] = profileInfoResponse['accessToken'];
        info['email']       = profileInfoResponse['email'];
        info['id']          = profileInfoResponse['id'];
        info['name']        = profileInfoResponse['name'];
        
        completer.complete(info);
      } else {
        completer.completeError({});
      }
      
    }]);
    return completer.future;
  }
  
  static void rerequestLoginModal() {
    modalShow("",
              '''
                <h1>${StringUtils.translate('facebookReRequestTitle', 'login')}</h1>
                <p>${StringUtils.translate('facebookReRequestText', 'login')}</p>
              '''
              // <ul>${NEEDED_PERMISSIONS.fold('', (prev, curr) => '$prev<li>$curr</li>')}</ul>
              , onBackdropClick: false
              , onOk: StringUtils.translate('facebookReRequestOk', 'login')
              , onCancel: StringUtils.translate('facebookReRequestCancel', 'login')
              , aditionalClass: "facebook-rerequest-modal"
            ).then((_) {
              JsUtils.runJavascript(null, "facebookLoginReRequest", [(js.JsObject loginResponse) {
                if (loginResponse["status"] == "connected") {
                  loginCallback(loginResponse);
                }
              }]);
            });//.catchError((_) => _router.go('home', {}));
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
  
  static Future<List<String>> friendList(facebookId) {
    Completer<List<String>> completer = new Completer<List<String>>();
    if (facebookId == null || facebookId == '') return completer.future;
    
    JsUtils.runJavascript(null, "facebookFriends", [facebookId, (js.JsObject profileInfoResponse) {
          if (profileInfoResponse["error"] == false) {
            List<String> idList = new List<String>.from(profileInfoResponse['idList']);
            completer.complete(idList);
          } else {
            Logger.root.warning("WTF 3511");
            completer.completeError(profileInfoResponse["error"]);
          }
        }]);
    
    return completer.future;
  }
  
  static void parseXFBML(String cssSelector) {
    JsUtils.runJavascript(null, "facebookParseXFBML", [cssSelector]);
  }
  
  void refreshConnectedState() {
    JsUtils.runJavascript(null, "facebookLoginStatus", [(r) => _state = r["status"]]);
  }
  
  static bool _checkPermissions(Map permissions) {
    return NEEDED_PERMISSIONS.every( (p) => permissions[p]);
  }

  String _state = null;
  String get state => _state;

  bool get isConnected => _state == "connected";
  
  static Map <String, Map> _profileImageCache = {};
  static Router _router;
  static ProfileService _profileManager;
  static Function _onLogin;
  static List<String> NEEDED_PERMISSIONS = ['email', 'user_friends', 'public_profile']; // user_friends, email, public_profile
}