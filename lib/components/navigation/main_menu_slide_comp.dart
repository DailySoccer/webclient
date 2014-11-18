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

  String get userNickName {
    if (profileService.isLoggedIn) {
      return profileService.user.nickName.length > maxNicknameLength ? profileService.user.nickName.substring(0, maxNicknameLength-3) + "..." :
                                                                       profileService.user.nickName;
    }
    else {
      return "";
    }
  }


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

      // Tanto el menuSlide como el backdrop estan ocultos fuera de la pantalla en xs
      _menuSlideElement.classes.add("hidden-xs");

      // El backdrop es la cortinilla traslucida que atenua todo el contenido
      _backdropElement = new DivElement();
      _backdropElement.classes.add("backdrop hidden-xs");

      // La insertamos en 0 para que no pise al #menuSlide
      _menuSlideElement.parent.children.insert(0, _backdropElement);

      _setUpAnimationControl();
    });
  }

  void _setUpAnimationControl() {
    _menuSlideElement.onTransitionEnd.listen((_) {
      if (_slideState == "hidden") {
        _menuSlideElement.classes.add("hidden-xs");
      }
    });

    _backdropElement.onTransitionEnd.listen((_) {
      if (_slideState == "hidden") {
        _backdropElement.classes.add("hidden-xs");
      }
    });

    _backdropElement.onClick.listen((_) {
      _hide();
    });
  }

  void _onToggleSlideMenuClick(MouseEvent e) {
    if (_slideState == "hidden") {
      _show();
    }
    else {
      _hide();
    }
  }

  void _show() {
    _slideState = "slid";

    // Desactivamos el scroll del body
    // TODO: Esto por supuesto hay q hacerlo, pero tiene los siguientes problemas:
    //       En todas los browsers, se va al principio del contenido.
    //       En chrome, al volver a bajar la barra de direcciones, el menuSlide tarda en moverse.
    //       En safari, el salto al ir al principio del contenido se ve acompaña de una redimension
    //       de la barra de redirecciones (detecta que te se ha ido al principio).
    querySelector("body").style.overflowY = "hidden";

    _menuSlideElement.classes.remove("hidden-xs");
    _backdropElement.classes.remove("hidden-xs");

    // Tenemos que dar un frame al browser para que calcule la posicion inicial
    window.animationFrame.then((_) {
      _menuSlideElement.classes.add("in");
      _backdropElement.classes.add("in");
    });
  }

  void _hide() {
    _slideState = "hidden";

    querySelector("body").style.overflowY = "visible";

    _menuSlideElement.classes.remove("in");
    _backdropElement.classes.remove("in");
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
      _hide();
      _router.go(destination, params);
    }
  }

  void logOut() {
    _hide();
    _router.go('landing_page', {});
    profileService.logout();
  }


  Element _rootElement;
  Element _menuSlideElement;
  Element _backdropElement;
  Router _router;
  View _view;

  String _slideState = "hidden";
}