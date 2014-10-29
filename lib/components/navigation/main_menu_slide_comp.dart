library main_menu_slide_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'dart:js';

@Component(
    selector: 'main-menu-slide',
    templateUrl: 'packages/webclient/components/navigation/main_menu_slide_comp.html',
    useShadowDom: false
)
class MainMenuSlideComp {

  ProfileService profileService;
  ScreenDetectorService scrDet;
  int maxNicknameLength = 30;
  String get userNickName => profileService.user.nickName.length > maxNicknameLength ? profileService.user.nickName.substring(0, maxNicknameLength-3) + "..." : profileService.user.nickName;

  String currentRouteName;

  MainMenuSlideComp(this._router, this.profileService, this.scrDet, this._rootElement) {

    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        _elementActivated = false;
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

  void checkForActiveElement() {
    if(_elementActivated) {
      return;
    }
    if (_router.activePath.length > 0) {
      currentRouteName = _router.activePath[0].name;
      updateActiveElement(currentRouteName);
    }
    else
    {
      updateActiveElement('lobby');
    }
  }

  void updateActiveElement(String name) {
      LIElement oldLi = _rootElement.querySelector("#mainMenu li.active");
      if (oldLi != null) {
        oldLi.classes.remove('active');
      }
      LIElement li = querySelector("[highlights=${name}]");
      if (li != null ) {
        li.classes.add('active');
        _elementActivated = true;
      }
      else {
        if ( name.contains('user') || name == 'help_info') {
          LIElement li = _rootElement.querySelector('[highlights="user"]');
          if (li != null ) {
            li.classes.add('active');
            _elementActivated = true;
          }
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
  bool _elementActivated = false;
}