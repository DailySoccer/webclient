library user_profile_comp;

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

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/account/user_profile_comp.html',
    useShadowDom: false
)
class UserProfileComp {

  LoadingService loadingService;

  bool isEditingProfile = false;

  dynamic get userData => _profileService.user;

  Map playerSkillInfo = {'position':'_', 'id':'', 'name': '', 'points': ' '};
  Map playerMoneyInfo = {'position':'_', 'id':'', 'name': '', 'points': '\$ '};

  String getLocalizedText(key, [group = "userprofile"]) {
    return StringUtils.translate(key, group);
  }

  UserProfileComp(this._router, this._profileService, this._contestsService, this.loadingService, LeaderboardService leaderboardService) {
    loadingService.isLoading = true;
    _fbLogin = new FBLogin(_router, _profileService, fbLoginCallback);
    leaderboardService.getUsers()
          .then((List<User> users) {

      List<User> pointsUserListTmp = new List<User>.from(users);
      List<User> moneyUserListTmp = new List<User>.from(users);
      List<Map> pointsUserList;
      List<Map> moneyUserList;

      pointsUserListTmp.sort( (User u1, User u2) => u2.trueSkill.compareTo(u1.trueSkill) );
      moneyUserListTmp.sort( (User u1, User u2) => u2.earnedMoney.compareTo(u1.earnedMoney) );

      int i = 1;
      pointsUserList = pointsUserListTmp.map((User u) => {
        'position': i++,
        'id': u.userId,
        'name': u.nickName,
        'points': StringUtils.parseTrueSkill(u.trueSkill)
        }).toList();

      i = 1;
      moneyUserList = moneyUserListTmp.map((User u) => {
        'position': i++,
        'id': u.userId,
        'name': u.nickName,
        'points': u.earnedMoney
        }).toList();

      playerSkillInfo = pointsUserList.firstWhere( (Map u1) => userData.userId == u1['id'], orElse:  () => {
        'position': pointsUserList.length,
        'id': "<unknown>",
        'name': "<unknown>",
        'points': 0
      });
      playerMoneyInfo = moneyUserList.firstWhere( (Map u1) => userData.userId == u1['id'], orElse:  () => {
        'position': moneyUserList.length,
        'id': "<unknown>",
        'name': "<unknown>",
        'points': 0
      });

      loadingService.isLoading = false;
    });
    GameMetrics.logEvent(GameMetrics.USER_PROFILE);
  }

  String get rankingPointsPosition {
    return playerSkillInfo['position'].toString();
  }
  String get rankingPoints {
    return playerSkillInfo['points'].toString();
  }
  String get rankingMoneyPosition {
    return playerMoneyInfo['position'].toString();
  }
  String get rankingMoney {
    return playerMoneyInfo['points'].toString();
  }

  void editPersonalData() {
    _router.go('edit_profile', {});
  }
  void goBuyGold() {
    _router.go('shop', {});
  }
  void goLeaderboard() { 
    _router.go('leaderboard', {'section': 'points', 'userId': _profileService.user.userId});
  }

  void fbLoginCallback() {
    
  }
  
  void bindWithServer() {
    modalSelectServerBind();
  }
  void bindWithFacebook() {
    FBLogin.onLogin = fbLoginCallback;
    showGuestNameModal();
    //modalFacebookBindConfirm();
//    /_fbLogin.loginFB();
  }
  
  void bindWithServerJoin() {
    ModalComp.open(_router, "user_profile.join", {}, bindWithServerCallback);
    FBLogin.onLogin = fbLoginCallback;
  }
  void bindWithServerLogin() {
    ModalComp.open(_router, "user_profile.login", {}, bindWithServerCallback);
    FBLogin.onLogin = fbLoginCallback;
  }
  void bindWithServerCallback(Map params) {
    if (params["action"] == "join") {
      String firstName = params["firstName"];
      String lastName = params["lastName"];
      String email = params["email"];
      String nickName = params["nickName"];
      String password = params["password"];
      Function onError = params["onError"];
      
      getAccount(email, password, (ServerError error) {
        // No existe el usuario?
        if (error.responseError.contains("email")) {
          loadingService.isLoading = true;
          _profileService.bindUUID(firstName, lastName, email, nickName, password)
              .then(([_]) { loadingService.isLoading = false; })
              .catchError((ServerError error) {
                loadingService.isLoading = false;
                Logger.root.severe(error);
                onError(error);
              }, test: (error) => error is ServerError);
        } else {
          onError(error);
        }
      });
      
    } else if (params["action"] == "login") {
      String email = params["email"];
      String password = params["password"];
      Function onError = params["onError"];

      getAccount(email, password, onError);
      
    } else {
      Logger.root.severe("Unknown BindWithFutbolCuatro process on user profile");
    }
  }
  
  void getAccount(String email, String password, void onError(ServerError)) {
    loadingService.isLoading = true;
    _profileService.getAccount(email, password).then((Map accountInfo) {
          loadingService.isLoading = false;

          ModalComp.deleteCallback();
          ModalComp.close();
          
          // Select the right account
          selectAccount(accountInfo);
          
        }).catchError((ServerError error) {
            loadingService.isLoading = false;
            onError(error);
        }, test: (error) => error is ServerError);
  }
  
  void selectAccount(Map cloudAccountInfo) {
    Map deviceAccountInfo = {};
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

      //ModalComp.open(_router, "user_profile.selectAccount", {}, bindWithFutbolCuatroCallback);

      modalSelectAccount(deviceAccountInfo, cloudAccountInfo);
      
    });
  }
  

  void modalSelectAccount(Map deviceAccount, Map cloudAccount) {
  
    Element modalWindow = querySelector("#modalWindow");
  
    void onClose(String eventCallback) {
      
      JsUtils.runJavascript('#alertRoot', 'modal', "hide");
      BackdropComp.instance.hide();
      modalWindow.children.remove(modalWindow.querySelector('#alertRoot'));
      
      switch (eventCallback) {
        case "onCloudAccount": modalConfirmAccount(cloudAccount, () => modalSelectAccount(deviceAccount, cloudAccount)); break;
        case "onDeviceAccount": modalConfirmAccount(deviceAccount, () => modalSelectAccount(deviceAccount, cloudAccount)); break;
        case "onCancel": print("Cancel"); break;
        default: print("undefined");
      }
    }
    
    modalWindow.setInnerHtml(''' 
              <div id="alertRoot" class="modal container modal-select-account" tabindex="-1" role="dialog" style="display: block;">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content"> 
    
                    <div class="alert-content">      
                      <div id="alertBox" class="main-box">
                        <div class="panel">
                          <!-- Content Message and Buttons-->
                          <div class="panel-body" >
                            <!-- Alert Text -->
                            <div class="form-description" id="modalContentWrapper">
                              <i class="material-icons close-button" eventCallback="onCancel">close</i>
                              <h1>${getLocalizedText("bind-an-account")}</h1>
                              <p>${getLocalizedText("bind-select-account")}</p>
                              ${accountResumeBox(cloudAccount)}
                              <div class="button-box"><button class="cloud-button" eventCallback="onCloudAccount">${getLocalizedText("bind-cloud-account-btt")} <i class="material-icons">cloud_download</i></button></div>
                              ${accountResumeBox(deviceAccount)}
                              <div class="button-box"><button class="device-button" eventCallback="onDeviceAccount">${getLocalizedText("bind-device-account-btt")} <i class="material-icons">phone_android</i></button></div>
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
  
  String accountResumeBox(Map account) {
    return '''  <div class="account-resume-box">
                  <div class="account-resume-username">${account["name"]}</div>
                  <div class="account-resume-gold">${getLocalizedText("wallet")}: ${account["balance"]}</div>
                  <div class="account-resume-played">${getLocalizedText("bind-info-historic")}: ${account["historyCount"]}</div>
                  <div class="account-resume-level">${getLocalizedText("bind-info-level")}: ${account["managerLevel"].truncate()} </div>
                  <div class="account-resume-playing">${getLocalizedText("bind-info-upcoming-live")}: ${account["playingCount"]}</div>
                </div>
            ''';
  }

  void modalConfirmAccount(Map account, Function onBackButton) {
  
    Element modalWindow = querySelector("#modalWindow");
  
    void onClose(String eventCallback) {
      JsUtils.runJavascript('#alertRoot', 'modal', "hide");
      BackdropComp.instance.hide();
      modalWindow.children.remove(modalWindow.querySelector('#alertRoot'));
      
      switch (eventCallback) {
        case "onConfirm":
          print("confirm");
          break;
          
        case "onBack": 
        case "onCancel": 
          onBackButton(); 
        break;
        
        default:
          print("undefined");
      }
    }
    
    modalWindow.setInnerHtml(''' 
              <div id="alertRoot" class="modal container modal-select-account" tabindex="-1" role="dialog" style="display: block;">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content"> 
    
                    <div class="alert-content">      
                      <div id="alertBox" class="main-box">
                        <div class="panel">
                          <!-- Content Message and Buttons-->
                          <div class="panel-body" >
                            <!-- Alert Text -->
                            <div class="form-description" id="modalContentWrapper">
                              <i class="material-icons back-button" eventCallback="onBack">arrow_back</i>
                              <h1>${getLocalizedText("bind-an-account")}</h1>
                              <p>${getLocalizedText("bind-confirm-account")}</p>
                              ${accountResumeBox(account)}
                              <div class="button-box"><button class="confirm-button" eventCallback="onConfirm">${getLocalizedText("modal-ok")}</button></div>
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
  void modalSelectServerBind() {
    
      Element modalWindow = querySelector("#modalWindow");
    
      void onClose(String eventCallback) {
        switch (eventCallback) {
          case "onLogin":
            bindWithServerLogin();
            break;
          case "onJoin":
            bindWithServerJoin();
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
                              <p>${getLocalizedText("bind-have-account")}</p>
                              <button class="bind-type-button" eventCallback="onLogin">${getLocalizedText("bind-login-btt")}</button>
                              <p>${getLocalizedText("bind-new-account")}</p>
                              <button class="bind-type-button" eventCallback="onJoin">${getLocalizedText("bind-join-btt")}</button>
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
  void modalFacebookBindConfirm() {
    
      Element modalWindow = querySelector("#modalWindow");
    
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
  
  
  // Esta modal es para colocarla en el estado de bienvenida.
  void showGuestNameModal() {
    modalShow(
          "",
          '''
            <div class="content-wrapper">
              <h1 class="alert-content-title">Bienvenido a Futbol Cuatro</h1>
              <h2 class="alert-content-subtitle">Tú nombre en los torneos será <b>Guest12345</b> <br>Si quieres puedes cambiar de nombre en tu perfil.</h2>
            </div>
          '''
          , onBackdropClick: true
          , aditionalClass: "guest-name-modal"
        )
        .then((_) => _router.go('home', {}))
        .catchError((_) => _router.go('home', {}));
  }
  

  ProfileService _profileService;
  ContestsService _contestsService;
  Router _router;
  FBLogin _fbLogin;
}