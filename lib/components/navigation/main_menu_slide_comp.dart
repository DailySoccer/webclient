library main_menu_slide_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'main-menu-slide',
    templateUrl: 'packages/webclient/components/navigation/main_menu_slide_comp.html',
    useShadowDom: false
)
class MainMenuSlideComp implements ShadowRootAware {

  ProfileService profileService;
  ScreenDetectorService scrDet;
  int maxNicknameLength = 30;
  String get userNickName => profileService.user.nickName.length > maxNicknameLength ? profileService.user.nickName.substring(0, maxNicknameLength-3) + "..." : profileService.user.nickName;

  MainMenuSlideComp(this._router, this.profileService, this.scrDet, this._rootElement, this._view) {

    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          _updateActiveElement(_router.activePath[0].name);
        }
      });
    });
  }

  @override void onShadowRoot(emulatedRoot) {
    _view.domRead(() {
      _rootElement.querySelector("#toggleSlideMenu").onClick.listen(_onToggleSlideMenuClick);
      _menuSlideElement = _rootElement.querySelector("#menuSlide");
    });
  }

  void _onToggleSlideMenuClick(MouseEvent e) {

    if (_slideState == "hidden") {
      _menuSlideElement.classes.remove("hidden-xs");
      _slideState = "slid";

      // Tenemos que dar un frame al browser para que calcule la posicion inicial
      window.animationFrame.then((_) {
        _menuSlideElement.classes.add("in");
      });
    }
    else {
      _menuSlideElement.classes.remove("in");
      _slideState = "hidden";
    }
  }

  void _updateActiveElement(String name) {

    LIElement li = _rootElement.querySelector("#mainMenu li.active");
    if (li != null) {
      li.classes.remove('active');
    }

    li = querySelector("[highlights=${name}]");

    if (li == null && _isRouteNameInsideUserMenu(name)) {
      li = _rootElement.querySelector('[highlights="user"]');
    }

    if (li != null) {
      li.classes.add('active');
    }
  }

  bool _isRouteNameInsideUserMenu(String name) {
    return name.contains('user') || name == 'help_info';
  }

  void navigateTo(event, [Map params]) {
    if (params == null) {
      params = {};
    }

    String destination = event.target.attributes["destination"];

    /*
    if (profileService.isLoggedIn && scrDet.isXsScreen && !event.target.id.contains("brandLogo")){
         JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed', 'offcanvas', 'toggle');
    }
    */

    if (destination.isNotEmpty) {
      _router.go(destination, params);
    }
  }

  void logOut() {
    //JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed', 'offcanvas', 'hide');
    _router.go('landing_page', {});
    profileService.logout();
  }


  Element _rootElement;
  Element _menuSlideElement;
  Router _router;
  View _view;

  String _slideState = "hidden";
}