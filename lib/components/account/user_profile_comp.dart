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

  UserProfileComp(this._router, this._profileService, this.loadingService, LeaderboardService leaderboardService) {
    loadingService.isLoading = true;
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

  void bindWithFutbolCuatroJoin() {
    ModalComp.open(_router, "user_profile.join", {}, bindWithFutbolCuatroCallback);
  }
  void bindWithFutbolCuatroLogin() {
    ModalComp.open(_router, "user_profile.login", {}, bindWithFutbolCuatroCallback);
  }
  void bindWithFutbolCuatroCallback(Map params) {
    if (params["action"] == "join") {
      String firstName = params["firstName"];
      String lastName = params["lastName"];
      String email = params["email"];
      String nickName = params["nickName"];
      String password = params["password"];
      Function onError = params["onError"];

      getAccount(email, password, (ServerError error) {
        if (error.responseError == "not_exists") {
          loadingService.isLoading = true;
          _profileService.bindUUID(firstName, lastName, email, nickName, password)
              .then(([_]) { loadingService.isLoading = false; })
              .catchError((ServerError error) {
                loadingService.isLoading = false;
                Logger.root.severe(error);
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
  
  Future getAccount(String email, String password, void onError(ServerError)) {
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
      

      ModalComp.open(_router, "user_profile.selectAccount", {}, bindWithFutbolCuatroCallback);

      modalSelectAccount(deviceAccountInfo, cloudAccountInfo);
        

    });
  }
  

  Future<bool> modalSelectAccount(deviceAccount, cloudAccount) {
  
    Element modalWindow = querySelector("#modalWindow");
  
    void onClose(dynamic sender) {
      modalWindow.children.remove(modalWindow.querySelector('#alertRoot'));
    }
  
    void onButtonClick(dynamic sender) {
      JsUtils.runJavascript('#alertRoot', 'modal', "hide");
      BackdropComp.instance.hide();
    }
    
    modalWindow.setInnerHtml(''' 
              <div id="alertRoot" class="modal container modal-select-acount" tabindex="-1" role="dialog" style="display: block;">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content"> 
    
                    <div class="alert-content">      
                      <div id="alertBox" class="main-box">
                        <div class="panel">
                          <!-- Content Message and Buttons-->
                          <div class="panel-body" >
                            <!-- Alert Text -->
                            <div class="form-description" id="modalContentWrapper">
                              <button class="ok-button" eventCallback="onCloudAccount">Cloud</button>
                              <button class="ok-button" eventCallback="onDeviceAccount">Device</button>
                            </div>            
                            <!-- Alert Buttons -->
                            <div class="input-group user-form-field">
                              <div class="new-row">                  
                                <div class="autocentered-buttons-wrapper">
                                  <div class="button-box"><button class="cancel-button" eventCallback="onCancel">Cancel</button></div> 
                                  <div class="button-box"><button class="ok-button" eventCallback="onConfirm">Ok</button><div>
                                </div>
                              </div>
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
    modalWindow.querySelectorAll("[eventCallback]").onClick.listen((sender) {
      String eventCallback = sender.currentTarget.attributes["eventCallback"];
      switch (eventCallback) {
            case "onCancel":
              print("cancel");
              break;
            case "onConfirm":
              print("confirm");
              break;
            case "onCloudAccount":
              print("cloud");
              break;
            case "onDeviceAccount":
              print("device");
              break;
          }
    });
  
    JsUtils.runJavascript('#alertRoot', 'modal', null);
    JsUtils.runJavascript('#alertRoot', 'on', {'hidden.bs.modal': (sender) { onClose(sender); } });
    BackdropComp.instance.show();
  }
/*
  String getNotEnoughGoldContent(Money goldNeeded) {
    return '''
    <div class="content-wrapper">
      <img class="main-image" src="images/iconNoGold.png">
      <span class="not-enough-resources-count">${goldNeeded}</span>
      <p class="content-text">
        <strong>${getLocalizedText("alert-no-gold-message")}</strong>
        <br>
        ${getLocalizedText('alert-user-gold-message', substitutions: {'MONEY': _profileService.user.goldBalance})}
        <img src="images/icon-coin-xs.png">
      </p>
    </div>
    ''';
  }
*/
  

  ProfileService _profileService;
  ContestsService _contestsService;
  Router _router;
}