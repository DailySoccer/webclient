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
  Function onLeftColumn = (){};
  Function onRightColumn = (){};
  
  AppTopBarStateConfig({this.leftColumn: AppTopBarState.EMPTY, 
                        this.centerColumn: AppTopBarState.EMPTY, 
                        this.rightColumn: AppTopBarState.EMPTY, 
                        this.onLeftColumn,
                        this.onRightColumn});
  
  AppTopBarStateConfig.hidden() {
    this.leftColumn = AppTopBarState.EMPTY;
    this.centerColumn = AppTopBarState.EMPTY;
    this.rightColumn = AppTopBarState.EMPTY;
  }
  
  AppTopBarStateConfig.subSection(this.centerColumn, {this.rightColumn: AppTopBarState.EMPTY}) {
    this.leftColumn = AppTopBarState.BACK_BUTTON;
  }
  
}

class AppTabBarState {
  bool show = false;
  int leaderNotifications = 0;
  int myContestNotifications = 0;
  int contestNotifications = 0;
  int liveContestsNotifications = 0;
  int scoutingNotifications = 0;
}
