library app_state_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/models/product.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/string_utils.dart';

@Injectable()
class AppStateService {
  
  static AppStateService get Instance => _instance;

  //AppTopBarStateConfig get appTabBarStateConfig => _appTabBarState.activeState;
  AppTabBarState get appTabBarState => _appTabBarState;
  AppTopBarState get appTopBarState => _appTopBarState;
  AppSecondaryTabBarState get appSecondaryTabBarState => _appSecondaryTabBarState;
  
  AppStateService() {
    _instance = this;
    _appTabBarState = new AppTabBarState();
    _appTopBarState = new AppTopBarState();
    _appSecondaryTabBarState = new AppSecondaryTabBarState();
  }
  
  AppTabBarState _appTabBarState;
  AppTopBarState _appTopBarState;
  AppSecondaryTabBarState _appSecondaryTabBarState;
  
  static AppStateService _instance;
}

class AppSecondaryTabBarState {
  List<AppSecondaryTabBarTab> tabList = [];
}
class AppSecondaryTabBarTab {
  String text;
  Function action;
  AppSecondaryTabBarTab(this.text, this.action);
}

class AppTopBarState {
  // COMPONENTS
  static const String BACK_BUTTON = "__BACK_BUTTON__";
  static const String EMPTY = "__EMPTY__";
  
  AppTopBarStateConfig activeState = new AppTopBarStateConfig.hidden();
}
class AppTopBarStateConfig {
  String leftColumn;
  String centerColumn;
  String rightColumn;
  String layoutClass;
  Function onLeftColumn = (){};
  Function onCenterColumn = (){};
  Function onRightColumn = (){};
  
  String getLocalizedText(key, {substitutions: null}) {
     return StringUtils.translate(key, "topBar", substitutions);
   }
  
  AppTopBarStateConfig({this.leftColumn: AppTopBarState.EMPTY, 
                        this.centerColumn: AppTopBarState.EMPTY, 
                        this.rightColumn: AppTopBarState.EMPTY, 
                        this.onLeftColumn,
                        this.onCenterColumn,
                        this.onRightColumn});
  
  AppTopBarStateConfig.hidden() {
    this.leftColumn = AppTopBarState.EMPTY;
    this.centerColumn = AppTopBarState.EMPTY;
    this.rightColumn = AppTopBarState.EMPTY;
  }
  
  AppTopBarStateConfig.subSection(this.centerColumn, {this.rightColumn: AppTopBarState.EMPTY}) {
    this.leftColumn = AppTopBarState.BACK_BUTTON;
  }

  AppTopBarStateConfig.userBar(ProfileService profileService, Router router) {
    leftColumn = '''
      <div class="lobby-topbar-left">
        <img class="gold-image" src="images/topBar/icon_user_profile.png">
        <span class="level">''' +  getLocalizedText("level") + '''</span>
        <span class="level">''' + (profileService.user != null ? profileService.user.trueSkill.toString() : "") + '''</span>
      </div>
    ''';
    centerColumn = '''
      <div class="lobby-topbar-center">
        <span class="coins-count">''' + (profileService.user != null ? profileService.user.balance.toString() : "0") + '''</span>
        <img class="gold-image" src="images/topBar/icon_coin_big.png">
        <img class="gold-image" src="images/topBar/icon_add_more_coins.png">
      </div>
    ''';
    rightColumn= '''
      <div class="lobby-topbar-right">
        ''' + getNotificationCount(profileService) + '''          
        <img class="gold-image" src="images/topBar/icon_Bell.png">
      </div>
    ''';
    onLeftColumn = (){
      router.go("profile", {});
    };
    onCenterColumn = (){
      router.go("shop", {});
    };
    onRightColumn = (){
      router.go("notifications", {});
    };
    layoutClass = "user-bar";
  }
  
  String getNotificationCount(ProfileService ps) {
    if (ps.user == null)
      return "";
    
    int notifCount = ps.user.notifications.length;
    
    if (notifCount > 0) 
      return ''' <span class="tab-bar-item-badge has-notifications">''' + notifCount.toString() + '''</span> ''';
        
    return "";
  }
  
  /*
  _appStateService.appTopBarState.activeState = new AppTopBarStateConfig(
       leftColumn: '''
        <div class="lobby-topbar-left">
          <img class="gold-image" src="images/topBar/icon_user_profile.png">
          <span class="level">''' +  getLocalizedText("level") + '''</span><span class="level">''' + skillPoints + '''</span>
         </div>
       ''', 
      centerColumn: '''
         <div class="lobby-topbar-center">
           <span class="coins-count">''' + "1250" + '''</span>
          <img class="gold-image" src="images/topBar/icon_coin_big.png">
          <img class="gold-image" src="images/topBar/icon_add_more_coins.png">
        </div>
      ''',
       rightColumn: '''
        <div class="lobby-topbar-right">
        <span class="tab-bar-item-badge has-notifications">''' + "1" + '''</span>          
         <img class="gold-image" src="images/topBar/icon_Bell.png">
         </div>
       ''');
  
  */
  
  
}

class AppTabBarState {
  bool show = false;
  int leaderNotifications = 0;
  int myContestNotifications = 0;
  int contestNotifications = 0;
  int liveContestsNotifications = 0;
  int scoutingNotifications = 0;
}
