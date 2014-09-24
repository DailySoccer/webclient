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

  void logOut() {
    JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed-left', 'offcanvas', 'hide');
    _router.go('landing_page', {});
    profileService.logout();
    _currentActiveElement = null;
  }

  MainMenuSlideComp(this._router, this.profileService, this.scrDet);

  void saveActiveClass() {
   if ( _currentActiveElement == null ) {
      LIElement activ = querySelector('.active');
      _currentActiveElement = activ;
      //print("No funciono bien... arreglamé");
    }
    String aActive  = window.location.hash.replaceFirst("#/", "");
    if (aActive.isEmpty) {
      aActive = "lobby";
    }
    Element aElementActive = querySelector('a[destination="${aActive}"]');
    if(aElementActive != null && !_linkActualizado) {
      updateMenuLinks(aElementActive);
      _linkActualizado = true;
      print('actualizo link');
    }
  }

  void navigateTo(event, [Map params]) {
    if( params == null) {
      params = {};
    }

    String destination = event.target.attributes["destination"];

    if (destination.isNotEmpty) {
      _router.go(destination, params);
    }

    if (profileService.isLoggedIn && scrDet.isXsScreen && !event.target.id.contains("brandLogo")){
      JsUtils.runJavascript('.navbar-offcanvas.navmenu-fixed-left', 'offcanvas', 'toggle');
    }

    updateMenuLinks(event.target);
  }

  void updateMenuLinks(dynamic a) {
    if(a.attributes["destination"] == "") {
      print("-MAIN_MENU_SLIDE_COMP-: Este elemento del menu no tiene 'destination'");
      return;
    }

    if (_currentActiveElement != null) {
      _currentActiveElement.classes.remove('active');
      if (a.attributes["destination"] == 'lobby') {
        _currentActiveElement = querySelector('#menuLobby').parent;
      }
      else {
        //Si el id tiene la palabra user, es un elemento del submenu de usuario
        if (a.id.contains("menuUser")) {
          _currentActiveElement = a.parent.parent.parent; // Si está en el submenu tenemos que subir hasta el li padre (profuncidad actual: li>ul>li>a)
        }
        else {
          if (a.parent.runtimeType.toString() != "DivElement") {
            _currentActiveElement = a.parent;
          }
          else {
            _currentActiveElement = null;
          }
        }
      }

      if(_currentActiveElement != null) {
        _currentActiveElement.classes.add('active');
      }
    }
  }

/*  void updateActiveMenu(String parent) {
    print(parent);
    if (parent.isEmpty) {parent = "lobby";}
    Element active = querySelector("a[destination='" + parent + "']");
    print(active);
    active.parent.classes.add("active");
  }*/

  @override
  void onShadowRoot(root) {
   _rootElement = root as HtmlElement;
  }

  HtmlElement _rootElement;
  LIElement _currentActiveElement;
  Router _router;

  bool _linkActualizado = false;
}