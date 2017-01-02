library facebook_login_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:async';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/components/backdrop_comp.dart';
import 'dart:html';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/models/user_ranking.dart';

@Component(
    selector: 'facebook-login',
    templateUrl: 'packages/webclient/components/account/facebook_login_comp.html',
    useShadowDom: false
)
class UserProfileComp {

  LoadingService loadingService;
  bool get isLoggedByFacebook => _profileService.user.isLoggedByFacebook;
  User get userData => _profileService.user;
  bool isConfirmModalOn = false;
  bool isSelectAccountModalOn = false;

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "contestlist", substitutions);
  }
  
  UserProfileComp(this._router, this._profileService, this._contestsService, this._appStateService, this.loadingService, LeaderboardService leaderboardService) {
    _fbLogin = new FBLogin(_router, _profileService, loginCallback);
  }
  
  void startLoginWithFacebook() {
    _fbLogin.loginFB();
  }
  
  Future loginCallback(String accessToken, String id, String name, String email) {
    Completer completer = new Completer();
    
    _profileService.getFacebookAccount(accessToken, id).then((Map accountInfo) {
        ModalComp.deleteCallback();
        ModalComp.close();
        
        accountInfo['accessToken'] = accessToken;
        accountInfo['facebookId'] = id;
        accountInfo['facebookName'] = name;
        accountInfo['facebookEmail'] = email;
        
        selectAccount(accountInfo);
      }).catchError((ServerError error) {
        loadingService.isLoading = true;
        _profileService.bindFacebookUUID(accessToken, id, name, email)
            .then(([_]) {
              ModalComp.deleteCallback();
              ModalComp.close();
              loadingService.isLoading = false; 
              /*GameMetrics.logEvent(GameMetrics.BINDING_WITH_APP, {"action via": "facebook",
                                                                  "platform": HostServer.isAndroidPlatform? 'android' : 
                                                                              HostServer.isiOSPlatform? 'ios' : 
                                                                                                        'unknown'
                                                                  });*/
            })
            .catchError((ServerError error) {
              loadingService.isLoading = false;
            }, test: (error) => error is ServerError);
      }, test: (error) => error is ServerError);
    
    return completer.future;
  }

  void selectAccount(Map cloudAccountInfo) {
    Map deviceAccountInfo = {};
    loadingService.isLoading = true;
    _contestsService.countMyContests().then((Map jsonData) {
      loadingService.isLoading = false;
      
      num numVirtualHistoryContests = jsonData.containsKey("numVirtualHistory") ? jsonData["numVirtualHistory"] : 0;
      num numRealHistoryContests    = jsonData.containsKey("numRealHistory") ? jsonData["numRealHistory"] : 0;
      num numLiveContests           = jsonData.containsKey("numLive") ? jsonData["numLive"] : 0;
      num numUpcomingContests       = jsonData.containsKey("numWaiting") ? jsonData["numWaiting"] : 0;
      
      deviceAccountInfo["name"] = _profileService.user.nickName;
      deviceAccountInfo["balance"] = _profileService.user.balance;
      deviceAccountInfo["managerLevel"] = _profileService.user.managerLevel;
      deviceAccountInfo["historyCount"] = numVirtualHistoryContests + numRealHistoryContests;
      deviceAccountInfo["playingCount"] = numLiveContests + numUpcomingContests;

      if (cloudAccountInfo.containsKey("email")) {
        deviceAccountInfo["email"] = cloudAccountInfo["email"];
        deviceAccountInfo["password"] = cloudAccountInfo["password"];
      }
      if (cloudAccountInfo.containsKey("accessToken")) {
        deviceAccountInfo["accessToken"] = cloudAccountInfo["accessToken"];
        deviceAccountInfo["facebookId"] = cloudAccountInfo["facebookId"];
        deviceAccountInfo["facebookName"] = cloudAccountInfo["facebookName"];
        deviceAccountInfo["facebookEmail"] = cloudAccountInfo["facebookEmail"];
      }
      
      showModalSelectAccount(deviceAccountInfo, cloudAccountInfo);
    });
  }
  void showModalSelectAccount(Map deviceAccount, Map cloudAccount) {
    isSelectAccountModalOn = true;
    
  }
  
  void bindWithFacebook() {
    //FBLogin.onLogin = fbLoginCallback;
    FBLogin.onFacebookConnection = fbLoginCallback;
    //modalFacebookBindConfirm();
    _fbLogin.loginFB();
  }
  
  void modalFacebookBindConfirm() {
      Element modalWindow = querySelector("modal-window");
    
      void onClose(String eventCallback) {
        switch (eventCallback) {
          case "onConfirm":
            print("Confirm");
            break;
          case "onCancel": break;
          default:
            print("undefined");
        }
        JsUtils.runJavascript('#alertRoot', 'modal', "hide");
        BackdropComp.instance.hide();
        modalWindow.children.remove(modalWindow.querySelector('#alertRoot'));
      }
      
      modalWindow.setInnerHtml(''' 
              <div id="alertRoot" class="modal container modal-bind-join-login" tabindex="-1" role="dialog" style="display: block;">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="alert-content">
                      <div id="alertBox" class="main-box">
                        <div class="panel">
                          <!-- Content Message and Buttons-->
                          <div class="panel-body">
                            <!-- Alert Text -->
                            <div class="form-description" id="modalContentWrapper">
                              <i class="material-icons close-button" eventCallback="onCancel">close</i>
                              <h1>${getLocalizedText("bind-an-account")}</h1>
                              <p>${getLocalizedText("bind-fb-exists")}</p>
                              <p>${getLocalizedText("bind-fb-agree")}</p>
                              <button class="confirm-button" eventCallback="onConfirm">${getLocalizedText("modal-ok")}</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
      ''', treeSanitizer: NULL_TREE_SANITIZER);

      // Aqui hago el setup de los botones. (que tiene que hacer cada botón al ser clickado... ver: main_menu_slide_comp).
      modalWindow.querySelectorAll("[eventCallback]").onClick.listen((sender) { onClose(sender.currentTarget.attributes["eventCallback"]); });
    
      JsUtils.runJavascript('#alertRoot', 'modal', null);
      JsUtils.runJavascript('#alertRoot', 'on', {'hidden.bs.modal': (sender) { onClose("onCancel"); } });
      BackdropComp.instance.show();
  }

  ProfileService _profileService;
  ContestsService _contestsService;
  AppStateService _appStateService;
  Router _router;
  FBLogin _fbLogin;
}

class ResumeAccount {
  
}