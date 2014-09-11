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

  MainMenuSlideComp(this._router, this.profileService);

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
        _currentActiveElement = a.parent;
      }
    }
    _currentActiveElement.classes.add('active');
  }

  // Para las utilidades del menu solo queremos buscar cosas que estén dentro del menu
  LIElement _currentActiveElement;
  Router _router;


  @override
  void onShadowRoot(root) {
    Element rootElement = root as HtmlElement;
    // buscamos el menu
    _currentActiveElement = rootElement.querySelector('.active') as LIElement;
    // --Debug only--
    if(_currentActiveElement != null)
      print("Encontrado el elemento activo");
  }
}