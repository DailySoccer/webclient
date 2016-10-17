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
import 'package:webclient/utils/game_metrics.dart';

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
    //GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED, {"action via": "facebook"});
    
    jsApiCall("loginStatus", [onGetLoginStatus]);
  }

  void onGetLoginStatus(statusResponse) {
    if (statusResponse["status"] == "connected") {
      print(" - FB EVAL => CONNECTED");
      loginCallback(statusResponse);
    } else if (statusResponse["status"] == 'not_authorized') {
      // El usuario no ha autorizado el uso de su facebook.
      print(" - FB EVAL => NOT AUTH");
    } else {
      print(" - FB EVAL => CONNECTED AND AUTH");
      jsApiCall("login", [(js.JsObject loginResponse) {
        if (loginResponse["status"] == "connected") {
          loginCallback(loginResponse);
        }
      }]);
    }
  }
  
  static Future<Map> getFacebookPermissions() {
    Completer<Map> completer = new Completer<Map>();
    
    jsApiCall("permissions", [(js.JsObject permissionsResponse) {
      print(" - FB REQUEST => Permissions CB ${permissionsResponse["error"]}");
      if (permissionsResponse["error"] == false) {
        print(" - FB REQUEST => Permissions 1");
        js.JsArray permissionsJS = permissionsResponse['data'];
        print(" - FB REQUEST => Permissions 2");
        Map permissions = {};
        print(" - FB REQUEST => Permissions 3");
        permissionsJS.forEach( (p) {
          print(" - FB REQUEST => Permissions CB ${p['permission']} - ${p['status']}");
          permissions[p['permission']] = (p['status'] == 'granted');
        });
        print(" - FB REQUEST => Permissions 4");
        
        completer.complete(permissions);
      } else {
        print(" - FB REQUEST => Permissions -1");
        Logger.root.severe (ProfileService.decorateLog("WTF - 8696 - RunJS - Facebook Get Permissions Error: " + permissionsResponse["error"]['message']));
        completer.completeError({});
      }
      print(" - FB REQUEST => Permissions END");
    }]);
    
    return completer.future;  
  }
  
  static void share(Map info) {
    jsApiCall("share", 
        [{'description'   : info.containsKey('description')  ? info['description']  : '',
          'imageUrl'      : info.containsKey('image') ?        info['image']        : '',
          'caption'       : info.containsKey('caption') ?      info['caption']      : '',
          'url'           : info.containsKey('url') ?          info['url']          : 'futbolcuatro.epiceleven.com',
          'title'         : info.containsKey('title') ?        info['title']        : null,
          'dartCallback'  : info.containsKey('dartCallback') ? info['dartCallback'] : () => null
        }]);
  }

  static void loginCallback(loginResponse) {
    getFacebookPermissions().then( (permissions) {
      print(" - FB REQUEST => Permissions Then ${permissions.toString()}");
      if ( _checkPermissions(permissions) ) {
        print(" - FB REQUEST => Permissions Checked");
        serverLoginWithFB();
      } else {
        // ERROR
        print(" - FB REQUEST => Permissions Check ERROR");
        //GameMetrics.logEvent(GameMetrics.LOGIN_FB_PERMISSIONS_DENIED, permissions);
        Logger.root.severe (ProfileService.decorateLog("WTF - 8695 - Facebook Permissions Insuficent: $permissions"));
        rerequestLoginModal();
      }
    });
  }
  
  static Future onLoginDefault(String accessToken, String id, String name, String email) {
    return _profileManager.facebookLogin(accessToken, id, name, email)
                                .then((_) {
                                  Logger.root.info (ProfileService.decorateLog("Server Login with Facebook is OK"));
                                  _onLogin();
                                }).catchError((ServerError error) {
                                  Logger.root.severe(error);
                                }, test: (error) => error is ServerError);
  }
  
  static void serverLoginWithFB() {
    print(" - FB REQUEST => ProfileInfoRequest");
    profileInfo().then((info) {
              String accessToken = info['accessToken'];
              String email       = info['email'];
              String id          = info['id'];
              String name        = info['name'];
              print(" - FB REQUEST => ProfileInfoRequest Then: accessToken => $accessToken || email => $email || id => $id || name => $name ");
                     
              // LOGIN
              /*_profileManager.getFacebookAccount(accessToken, id).then((Map accountInfo) {
              });*/

              Logger.root.info (ProfileService.decorateLog("Server Login with Facebook"));
              return _onFacebookConnection(accessToken, id, name, email);
          });
  }
  
  static Future<Map> profileInfo() {
    Completer<Map> completer = new Completer<Map>();
    print(" - FB REQUEST => ProfileInfoRequest In");
    
    jsApiCall("profileInfo", [(js.JsObject profileInfoResponse) {
      Map info = {};
      print(" - FB REQUEST => ProfileInfoRequest CB");
      print(" - FB REQUEST => ProfileInfoRequest ${profileInfoResponse["error"]}");
      if (!profileInfoResponse["error"]) {
        print(" - FB REQUEST => ProfileInfoRequest 1");
        info['accessToken'] = profileInfoResponse['accessToken'];
        info['email']       = profileInfoResponse['email'];
        info['id']          = profileInfoResponse['id'];
        info['name']        = profileInfoResponse['name'];
        info['picture']     = profileInfoResponse['picture'];

        print(" - FB REQUEST => ProfileInfoRequest 2");
        Map image = {};
        image['imageUrl']   = profileInfoResponse['picture']['data']['url'];
        image['isDefault']  = profileInfoResponse['picture']['data']['is_silhouette'];

        print(" - FB REQUEST => ProfileInfoRequest 3");
        _profileImageCache[info['id']] = image;
        print(" - FB REQUEST => ProfileInfoRequest ${profileInfoResponse["accessToken"]}, ${profileInfoResponse["email"]}, ${profileInfoResponse["id"]}, ${profileInfoResponse["name"]}");

        completer.complete(info);
      } else {
        Logger.root.severe (ProfileService.decorateLog("WTF - 8692 - RunJS - Facebook Get Profile Info ${profileInfoResponse["error"]['message']}"));
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
              //GameMetrics.logEvent(GameMetrics.LOGIN_FB_REREQUEST_ACCEPTED);
              jsApiCall("loginReRequest", [(js.JsObject loginResponse) {
                if (loginResponse["status"] == "connected") {
                  loginCallback(loginResponse);
                }
              }]);
            }).catchError((_) {
              //GameMetrics.logEvent(GameMetrics.LOGIN_FB_REREQUEST_REJECTED);
              Logger.root.info(ProfileService.decorateLog("WTF - 8694 - Rejected Facebook Permissions ReRequest"));
            });
  }
  
  static Map profileImage(String facebookId) {
    Map defaultImage = { 'isDefault' : true, 'imageUrl': null };
    if (facebookId == null || facebookId == '') return defaultImage;

    if (_profileImageCache.containsKey(facebookId)) {
      return _profileImageCache[facebookId];
    }
    
    _profileImageCache[facebookId] = defaultImage;
    if (_isRequestingOpenGraph) {
      _openGraphRequestQueue.add(() => _profileImageJSCall(facebookId));
    } else {
      _profileImageJSCall(facebookId);
    }

    return defaultImage;
  }
  
  static void _profileImageJSCall(String facebookId) {
    _isRequestingOpenGraph = true;
    jsApiCall("profilePhoto", [facebookId, (js.JsObject profileInfoResponse) {
      Map image = {};
      
      print('error: ' + profileInfoResponse["error"]);
      
      if (profileInfoResponse["error"] == false) {
        
        print('imageUrl: ' + profileInfoResponse['imageUrl']);
        print('isDefault: ' + profileInfoResponse['isDefault']);
        
        image['imageUrl'] = profileInfoResponse['imageUrl'];
        image['isDefault'] = profileInfoResponse['isDefault'];
        _profileImageCache[facebookId] = image;
      } else {
        Logger.root.warning (ProfileService.decorateLog("WTF - 3510 - RunJS - Facebook Get Profile Image '${profileInfoResponse["error"]['message']}'"));
      }
      _isRequestingOpenGraph = false;
      if (_openGraphRequestQueue.length > 0) { 
        _openGraphRequestQueue.removeLast()(); // pop and call the function
      }
    }]);
  }
  
  
  static Future<List<String>> friendList(facebookId) {
    Completer<List<String>> completer = new Completer<List<String>>();
    if (facebookId == null || facebookId == '') return completer.future;
    
    if (_isRequestingOpenGraph) {
      _openGraphRequestQueue.add(() => _friendListJSCall(facebookId, completer));
    } else {
      _friendListJSCall(facebookId, completer);
    }
    
    return completer.future;
  }
  
  static void _friendListJSCall(String facebookId, Completer<List<String>> completer) {
    _isRequestingOpenGraph = true;

    jsApiCall("friends", [facebookId, (js.JsObject profileInfoResponse) {
        if (profileInfoResponse["error"] == false) {
          
          List<String> idList = new List<String>();
          int length = profileInfoResponse['friendsInfo']['length'];
          
          for (int i = 0; i < length; i++) {
            var currentFriend = profileInfoResponse['friendsInfo'][i];
            idList.add(currentFriend['id']);
  
            _profileImageCache[currentFriend['id']] = {
                    'imageUrl'  : currentFriend['image']['url'],
                    'isDefault' : currentFriend['image']['isDefault']
                  };
          }
          
          completer.complete(idList);
        } else {
          Logger.root.severe (ProfileService.decorateLog("WTF - 3511 - RunJS - Facebook Get Friends '${profileInfoResponse["error"]['message']}'"));
          completer.completeError(profileInfoResponse["error"]);
        }
        _isRequestingOpenGraph = false;
        if (_openGraphRequestQueue.length > 0) { 
          _openGraphRequestQueue.removeLast()(); // pop and call the function
        }
      }]);
  }
  
  static void parseXFBML(String cssSelector) {
    JsUtils.runJavascript(null, "facebookParseXFBML", [cssSelector]);
  }
  
  void refreshConnectedState() {
    jsApiCall("loginStatus", [(r) => _state = r["status"]]);
  }
  
  static bool _checkPermissions(Map permissions) {
    return NEEDED_PERMISSIONS.every( (p) {

      print(" - FB REQUEST => Permissions Check ${p} -> ${permissions[p]}");
      return permissions[p];
    });
  }
  
  static void jsApiCall(String funcName, dynamic params) {
    JsUtils.runJavascript(null, funcName, params, 'facebookApiWrapper');
  }

  String _state = null;
  String get state => _state;

  static Function _onFacebookConnection = onLoginDefault;
  static void set onFacebookConnection(Future funct(String accessToken, String id, String name, String email)) {
    _onFacebookConnection = funct;
  }
  static Function get onFacebookConnection => _onFacebookConnection;
  
  bool get isConnected => _state == "connected";

  static List<Function> _openGraphRequestQueue = new List<Function>();
  static bool _isRequestingOpenGraph = false;
  
  static Map <String, Map> _profileImageCache = {};
  static Router _router;
  static ProfileService _profileManager;
  static Function _onLogin;
  static List<String> NEEDED_PERMISSIONS = ['email', 'user_friends', 'public_profile']; // user_friends, email, public_profile
}