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
  
  //AppTabBarState get appTabBarState => _appTabBarState;
  Stream<String> get onAppStateChange => _appStateController.stream;
  
  AppStateService(this._router) {
    _instance = this;
    //_appTabBarState = new AppTabBarState(_router);
    _appTopBarState = new AppTopBarState();
    
    _router.onRouteStart.listen((RouteStartEvent event) {
             event.completed.then((_) {
               if (_router.activePath.length > 0) {
                 String oldActivePath = _activePath;
                 _activePath = _router.activePath[0].name;
                 if (oldActivePath != _activePath) {
                   _appStateController.add("");
                 }
               }
             });
           });
  }
  
  Router _router;
  //AppTabBarState _appTabBarState;
  AppTopBarState _appTopBarState;
  String _activePath = "";
  StreamController<String> _appStateController = new StreamController.broadcast();
  
  static AppStateService _instance;
}

class AppSecondaryTabBarState {
  
  
  
}
class AppTopBarState {
  
  
  
}
class AppTabBarState {
  /*
  static const String CONTESTS = "CONTEST";
  static const String LEADERBOARD = "LEADERBOARD";
  static const String STORE = "STORE";
  static const String FRIENDS = "FRIENDS";
  static const String BONUS = "BONUS";
  
  Stream<String> get onTabBarStateChange => _tabBarStateController.stream;
  
  String get activeSection => _PATH_TAB[_activePath];

  AppTabBarState(this._router) {
    _router.onRouteStart.listen((RouteStartEvent event) {
          event.completed.then((_) {
            if (_router.activePath.length > 0) {
              String oldActivePath = _activePath;
              _activePath = _router.activePath[0].name;
              if (oldActivePath != _activePath) {
                _tabBarStateController.add(activeSection);
              }
            }
          });
        });
  }

  static const Map<String, String> _PATH_TAB = const {
    "lobby": CONTESTS,
    "leaderboard": LEADERBOARD,
    "shop": STORE,
    "friends": FRIENDS,
    "Bonus": BONUS,
  };
  
  String _activePath = "";
  Router _router;
  StreamController<String> _tabBarStateController = new StreamController.broadcast();
  */
}
