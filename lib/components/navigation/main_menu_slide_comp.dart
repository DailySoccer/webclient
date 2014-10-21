library main_menu_slide_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'main-menu-slide',
    templateUrl: '/packages/webclient/components/navigation/main_menu_slide_comp.html',
    useShadowDom: false
)
class MainMenuSlideComp {

  ProfileService profileService;
  ScreenDetectorService scrDet;

  String currentRouteName;

  MainMenuSlideComp(this._router, this.profileService, this.scrDet, this._rootElement) {

    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          currentRouteName = _router.activePath[0].name;
          updateActiveElement(currentRouteName);
        }
        else {
          currentRouteName = null;
        }
      });
    });
  }

  void updateActiveElement(String name) {
      LIElement oldLi = querySelector("#mainMenu li.active");
      if (oldLi != null) {
        oldLi.classes.remove('active');
      }
      LIElement li = querySelector("[highlights=${name}]");
      if (li != null ) {
        li.classes.add('active');
      }
      else {
        if ( name.contains('user') || name == 'help_info') {
          LIElement li = querySelector('[highlights="user"]');
          li.classes.add('active');
        }
      }
  }

  void navigateTo(event, [Map params]) {
    if (params == null) {
      params = {};
    }

    String destination = event.target.attributes["destination"];

    if (profileService.isLoggedIn && scrDet.isXsScreen && !event.target.id.contains("brandLogo")){
         JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed', 'offcanvas', 'toggle');
    }

    if (destination.isNotEmpty) {
      _router.go(destination, params);
    }
  }

  void logOut() {
    JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed', 'offcanvas', 'hide');
    _router.go('landing_page', {});
    profileService.logout();
    _currentActiveElement = null;
  }


  Element _rootElement;
  LIElement _currentActiveElement;
  Router _router;

  bool _linkActualizado = false;
}