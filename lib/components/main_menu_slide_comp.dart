library main_menu_slide_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';

@Component(
    selector: 'main-menu-slide',
    templateUrl: 'packages/webclient/components/main_menu_slide_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class MainMenuSlideComp implements ShadowRootAware{
  ProfileService profileService;


  void logOut() {
    _router.go('landing_page', {});
    profileService.logout();
    _currentActiveElement = null;
  }

  MainMenuSlideComp(this._router, this.profileService) {
  }


  void saveActiveClass() {
    if ( _currentActiveElement == null ) {
      LIElement activ = querySelector('.active');
      _currentActiveElement = activ;
      print("primera vez");
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

    updateMenuLinks(event.target);
  }

  void updateMenuLinks(dynamic a) {
    if(a.attributes["destination"] == "") {
      print("-MAIN_MENU_SLIDE_COMP-: Este elemento del menu no tiene 'destination'");
      return;
    }

    if(_currentActiveElement != null) {
      _currentActiveElement.classes.remove('active');
      if (a.attributes["destination"] == 'lobby') {
        _currentActiveElement = querySelector('#menuLobby').parent;
      }
      else {
        //Si el id tiene la palabra user, es un elemento del submenu de usuario
        if (a.id.contains("user")) {
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
      _currentActiveElement.classes.add('active');
    }
  }



  @override
  void onShadowRoot(root) {
   _rootElement = root as HtmlElement;
   // buscamos el menu
   // = _currentActiveElement.querySelector('.active');
   // --Debug only--
   //if(_currentActiveElement == null)
   //  print("No se ha encontrado el elemento del menu 'active'");
  }
  HtmlElement _rootElement;
  LIElement _currentActiveElement;
  Router _router;
}