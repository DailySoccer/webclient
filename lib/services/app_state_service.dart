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
  // LAYOUTS
  static const String THREE_COLUMNS = "THREE_COLUMNS";
  static const String ONE_COLUMN = "ONE_COLUMN";
  static const String NONE_COLUMNS = "NONE";

  // COMPONENTS
  static const String CREATE_CONTEST_BUTTON = "CREATE_CONTEST_BUTTON";
  static const String LIVE_CONTESTS = "LIVE_CONTEST_BUTTON";
  static const String BACK_BUTTON = "BACK_BUTTON";
  static const String USER_CURRENCIES = "USER_CURRENCIES";
  static const String TITLE_LABEL = "TITLE";
  static const String EMPTY = "EMPTY";
  
  // PRECONFIGURATIONS
  static AppTopBarStateConfig HIDDEN_CONFIG     = new AppTopBarStateConfig(NONE_COLUMNS, const[]);
  static AppTopBarStateConfig USER_DATA_CONFIG  = new AppTopBarStateConfig(THREE_COLUMNS, const[CREATE_CONTEST_BUTTON, USER_CURRENCIES, LIVE_CONTESTS]);
  static AppTopBarStateConfig SUBSECTION_CONFIG = new AppTopBarStateConfig(THREE_COLUMNS, const[BACK_BUTTON, TITLE_LABEL, EMPTY]);
  static AppTopBarStateConfig SECTION_CONFIG    = new AppTopBarStateConfig(ONE_COLUMN, const[TITLE_LABEL]);
  
  AppTopBarStateConfig activeState = HIDDEN_CONFIG;
  Map configParameters = { "title" : "FURBORCUATRO" }; 
}
class AppTopBarStateConfig {
  String layout;
  List<String> elements;
  AppTopBarStateConfig(this.layout, this.elements);
}

class AppTabBarState {
  bool show = false;
  int storeNotifications = 0;
  int leaderNotifications = 0;
  int contestNotifications = 0;
  int friendsNotifications = 0;
  int bonusNotifications = 0;
}
