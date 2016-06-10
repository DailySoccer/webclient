library tab_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'dart:html';

@Component(
    selector: 'tab-bar',
    templateUrl: 'packages/webclient/components/navigation/tab_bar_comp.html',
    useShadowDom: false
)
class TabBarComp {

  static const String CONTESTS = "CONTEST";
  static const String LEADERBOARD = "LEADERBOARD";
  static const String STORE = "STORE";
  static const String FRIENDS = "FRIENDS";
  static const String BONUS = "BONUS";
  
  Map<String, TabBarItemComp> tabs = {};

  TabBarItemComp get storeTab    => tabs[STORE];
  TabBarItemComp get leaderTab   => tabs[LEADERBOARD];
  TabBarItemComp get contestsTab => tabs[CONTESTS];
  TabBarItemComp get friendsTab  => tabs[FRIENDS];
  TabBarItemComp get bonusTab    => tabs[BONUS];
  
  TabBarComp(this._router, this._loadingService, this._view, this._rootElement, 
              this._dateTimeService, this._profileService, this._templateService, 
              this._catalogService, this._appStateService) {
    tabs = { STORE       : new TabBarItemComp(_router, 
                                               name: "Store",
                                               iconImage: "images/menuLeaderboardLight.png",
                                               destination: "shop"),
             LEADERBOARD : new TabBarItemComp(_router, 
                                               name: "Leaders",
                                               iconImage: "images/menuLeaderboardLight.png", 
                                               destination: "leaderboard", 
                                               parameters: { "section": "points", 
                                                             "userId": _profileService.user.userId}, 
                                               notificationsCount: 700),
             CONTESTS    : new TabBarItemComp(_router, 
                                               name: "Torneos",
                                               iconImage: "images/menuLeaderboardLight.png", 
                                               destination: "lobby"),
             FRIENDS     : new TabBarItemComp(_router, 
                                               name: "Amigos",  
                                               iconImage: "images/menuLeaderboardLight.png", 
                                               destination: "leaderboard", 
                                               parameters: { "section": "points", 
                                                             "userId": _profileService.user.userId},
                                               notificationsCount: 3),
             BONUS       : new TabBarItemComp(_router, 
                                               name: "Bonos",
                                               iconImage: "images/menuLeaderboardLight.png",
                                               destination: "shop")
    };
  }
  
  

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "TabBar", substitutions);
  }

  Element _rootElement;
  View _view;
  Router _router;
  
  DateTimeService _dateTimeService;
  LoadingService _loadingService;

  TemplateService _templateService;
  CatalogService _catalogService;
  ProfileService _profileService;
  AppStateService _appStateService;
}

class TabBarItemComp {
  
  String name = "";
  String iconImage = "";
  String destination = "";
  int notificationsCount = 0;
  bool isActive = false;
  Map parameters = {};
  
  TabBarItemComp(Router router, {String name: "", String iconImage: "", String destination: "", Map parameters: const {}, int notificationsCount: 0}) {
    this.name = name;
    this.iconImage = iconImage;
    this.destination = destination;
    if (parameters.length > 0) this.parameters = parameters;
    this.notificationsCount = notificationsCount;
    _router = router;
    
    _router.onRouteStart.listen((RouteStartEvent event) {
              event.completed.then((_) {
                if (_router.activePath.isNotEmpty) {
                  isActive = _router.activePath[0].name == destination;
                }
              });
            });
  }
  
  void goLocation() {
    _router.go(destination, parameters);
  }

  Router _router;
}
