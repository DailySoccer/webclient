library main_menu_slide_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'main-menu-slide',
    templateUrl: 'packages/webclient/components/main_menu_slide_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class MainMenuSlideComp implements ShadowRootAware{
  ProfileService profileService;
  ScreenDetectorService scrDet;

  dynamic getMenuClass() {
    return  ['fade-background'];
  }
  void logOut() {
    JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed', 'offcanvas', 'hide');
    _router.go('landing_page', {});
    profileService.logout();
    _currentActiveElement = null;
  }

  String currentRouteName;

  MainMenuSlideComp(this._router, this.profileService, this.scrDet) {
    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          currentRouteName = _router.activePath[0].name;
          print("MAIN_MENU_SLIDE-: Estoy en ${currentRouteName}");
          updateActiveElement(currentRouteName);
        }
        else {
              currentRouteName = null;
        }
      });
    });
  }

  void updateActiveElement(String name) {
      LIElement oldLi = querySelector("li.active");
      if (oldLi != null) {
        oldLi.classes.remove('active');
      }
      LIElement li = querySelector("[highlights=${name}]");
      if (li != null ) {
        li.classes.add('active');
      }
      else {
        if ( name.contains('user')) {
          LIElement li = querySelector('[highlights="user"]');
          li.classes.add('active');
        }
      }
  }

  void navigateTo(event, [Map params]) {
    if( params == null) {
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

  @override
  void onShadowRoot(root) {
   _rootElement = root as HtmlElement;
  }

  HtmlElement _rootElement;
  LIElement _currentActiveElement;
  Router _router;

  bool _linkActualizado = false;
}