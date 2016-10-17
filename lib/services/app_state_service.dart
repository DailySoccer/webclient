library app_state_service;
import 'dart:html';
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
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/leaderboard_service.dart';

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

  bool notificationsActive = false;
  
  static AppStateService _instance;
}

class AppSecondaryTabBarState {
  List<AppSecondaryTabBarTab> tabList = [];
}
class AppSecondaryTabBarTab {
  String text;
  Function action;
  Function isActive;
  AppSecondaryTabBarTab(this.text, this.action, this.isActive);
}

class AppTopBarState {
  // COMPONENTS
  static const String BACK_BUTTON = "__BACK_BUTTON__";
  static const String SEARCH_BUTTON = "__SEARCH_BUTTON__";
  static const String EMPTY = "__EMPTY__";
  
  static void GOBACK() {
    window.history.back();
  }
  
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
  
  /* SEARCH POURPOSES */
  Function onLeftColumnSearchingBackUp = (){};
  Function onSearch = ([_]){};
  bool isSearching = false;
  String searchValue = "";
  /* END SEARCH POURPOSES */
  
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
  AppTopBarStateConfig.subSectionWithSearch(this.centerColumn, Function onSearch) {
    this.leftColumn = AppTopBarState.BACK_BUTTON;
    this.rightColumn = AppTopBarState.SEARCH_BUTTON;
    
    this.onRightColumn = (){      
      isSearching = !isSearching;
      if (!isSearching) {
        
        searchValue = "";
        onSearch(searchValue);
        this.onLeftColumn = onLeftColumnSearchingBackUp;
        
      } else {
        
        this.leftColumn = AppTopBarState.BACK_BUTTON;
        onLeftColumnSearchingBackUp = this.onLeftColumn;
        this.onLeftColumn = this.onRightColumn;
        
      }
    };
    this.onSearch = onSearch;
  }
  
  AppTopBarStateConfig.contestSection(Contest contest, bool showInfoButton, Function backFunction, [Function infoFunction]) {
    if (contest == null) {
      this.centerColumn = '''
        <div class="contest-topbar-info">
          <div class="time-section">
            <div class="contest-flag"></div>
            <div class="column-start-hour"></div>
          </div>
          <div class="contest-name-section">
            <div class="contest-name"></div>
            <div class="contest-description"></div>
          </div>
        </div>
      '''; 
      this.rightColumn = AppTopBarState.EMPTY;
      this.leftColumn = AppTopBarState.BACK_BUTTON;
    } else {
      this.centerColumn = '''
        <div class="contest-topbar-info">
          <div class="time-section">
            <div class="contest-flag ${contest.getSourceFlag()}"></div>
            <div class="column-start-hour ${contest.isSoon()? 'start-soon' : ''}"> ${contest.timeInfo()}</div>
          </div>
          <div class="contest-name-section">
            <div class="contest-name">${contest.name}</div>
            <div class="contest-description">${contest.description}</div>
          </div>
        </div>
      '''; 
      this.rightColumn = showInfoButton? "<i class='material-icons'>&#xE88F;</i>" : AppTopBarState.EMPTY;
      this.leftColumn = AppTopBarState.BACK_BUTTON;
    }
    this.onLeftColumn = backFunction;
    this.onRightColumn = showInfoButton? infoFunction : (){};
    this.onCenterColumn = showInfoButton? infoFunction : (){};
  }

  AppTopBarStateConfig.userBar(ProfileService profileService, Router router, LeaderboardService leaderBoardService, [bool isHomeBar = false]) {
    String leftColAux = isHomeBar ? '' : '''
              <span class="level">''' +  leaderBoardService.myTrueSkillName + /*'''</span>
              <span class="level">''' + (profileService.isLoggedIn ? profileService.user.trueSkill.toString() : "") + */'''</span> 
            ''';  
    
    leftColumn = '''
      <div class="lobby-topbar-left">
        <img class="gold-image" src="images/topBar/icon_user_profile.png">
        $leftColAux
      </div>
    ''';
    
    if (!isHomeBar) {
      centerColumn = '''
        <div class="lobby-topbar-center">
          <span class="coins-count">''' + (profileService.isLoggedIn ? profileService.user.balance.toString() : "0") + '''</span>
          <img class="gold-image" src="images/topBar/icon_coin_big.png">
          <img class="gold-image" src="images/topBar/icon_add_more_coins.png">
        </div>
      ''';
    } else {
      centerColumn = '''
        <div class="lobby-topbar-center nickname">
          <div class="inner-nickname">''' + (profileService.isLoggedIn ? profileService.user.nickName : " ") + '''</div>
        </div>''';
    }
    rightColumn = '''
      <div class="lobby-topbar-right">
        ''' + getNotificationCount(profileService) + '''          
        <img class="gold-image" src="images/topBar/icon_Bell.png">
      </div>
    ''';
    onLeftColumn = (){
      router.go("user_profile", {});
    };
    onCenterColumn = (){
      if (!isHomeBar)
        router.go("shop", {});
    };
    onRightColumn = (){
      //router.go("notifications", {});
      AppStateService.Instance.notificationsActive = true;
    };
    layoutClass = "user-bar";
  }
  
  String getNotificationCount(ProfileService ps) {
    if (!ps.isLoggedIn) return "";
    
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
