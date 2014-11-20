library main_menu_slide_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:async';


@Component(
    selector: 'main-menu-slide',
    useShadowDom: false
)
class MainMenuSlideComp implements ShadowRootAware {

  MainMenuSlideComp(this._router, this._profileService, this._scrDet, this._rootElement, this._turnZone) {
    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          _updateActiveElement(_router.activePath[0].name);
        }
      });
    });
  }

  @override void onShadowRoot(emulatedRoot) {
    _turnZone.runOutsideAngular(() => _monitorChanges(0));
  }

  void _monitorChanges(_) {
    if (_isLoggedIn != _profileService.isLoggedIn) {
      _reset();
      _isLoggedIn = _profileService.isLoggedIn;
      _createHtml();
      _setUpSlidingMenu();
      _setUpClicks();
    }

    window.animationFrame.then(_monitorChanges);
  }

  void _reset() {
    // Basta con asignar a null puesto que recreamos de 0 el HTML
    _menuSlideElement = null;
    _backdropElement = null;

    // Nos pueden haber deslogeado con el menu desplegado
    if (_scrollCancelationListener != null) {
      _scrollCancelationListener.cancel();
      _scrollCancelationListener = null;
    }

    _slideState = "hidden";
  }

  void _createHtml() {

    String navClass = "navbar navbar-default", innerHtml;

    if (_isLoggedIn) {
      innerHtml = _getLoggedInHtml();
      navClass += " logged-in";
    }
    else {
      innerHtml = _getNotLoggedInHtml();
    }

    String finalHtml =
    '''
    <nav id="mainMenu" class="${navClass}" role="navigation">
      ${innerHtml}
    </nav>
    ''';

    _rootElement.setInnerHtml(finalHtml, treeSanitizer: NULL_TREE_SANITIZER);
  }

  void _setUpSlidingMenu() {

    if (!_isLoggedIn) {
      return;
    }

    _rootElement.querySelector("#toggleSlideMenu").onClick.listen(_onToggleSlidingMenuClick);
    _menuSlideElement = _rootElement.querySelector("#menuSlide");

    // Tanto el menuSlide como el backdrop estan ocultos fuera de la pantalla en xs
    _menuSlideElement.classes.add("hidden-xs");

    // El backdrop es la cortinilla traslucida que atenua todo el contenido
    _backdropElement = new DivElement();
    _backdropElement.classes.add("backdrop hidden-xs");

    // La insertamos en 0 para que no pise al #menuSlide
    _menuSlideElement.parent.children.insert(0, _backdropElement);

    // Control de animacion
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
  }

  void _setUpClicks() {
    querySelectorAll("[destination]").onClick.listen(_onElementWithDestinationClick);

    if (_backdropElement != null) {
      _backdropElement.onClick.listen((_) => _hide());
    }
  }

  void _onElementWithDestinationClick(event) {
    String destination = event.currentTarget.attributes["destination"];

    _hide();

    if (destination == "logout") {
      _router.go('landing_page', {});
      _profileService.logout();
    }
    else {
      _router.go(destination, {});
    }
  }

  void _onToggleSlidingMenuClick(MouseEvent e) {
    if (_slideState == "hidden") {
      _show();
    }
    else {
      _hide();
    }
  }

  void _show() {
    _slideState = "slid";

    // Desactivamos el scroll del body (solo en Touch, en desktop nos da igual)
    _scrollCancelationListener = querySelector("body").onTouchMove.listen((event) {
      event.preventDefault();
    });

    _menuSlideElement.classes.remove("hidden-xs");
    _backdropElement.classes.remove("hidden-xs");

    // Tenemos que dar un frame al browser para que calcule la posicion inicial
    window.animationFrame.then((_) {
      _menuSlideElement.classes.add("in");
      _backdropElement.classes.add("in");
    });
  }

  void _hide() {
    if (_menuSlideElement != null) {
      _slideState = "hidden";

      _menuSlideElement.classes.remove("in");
      _backdropElement.classes.remove("in");
    }

    if (_scrollCancelationListener != null) {
      _scrollCancelationListener.cancel();
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

  String get _userNickName {
    if (!_profileService.isLoggedIn) {
      return "";
    }

    return _profileService.user.nickName.length > _maxNicknameLength ? _profileService.user.nickName.substring(0, _maxNicknameLength-3) + "..." :
                                                                      _profileService.user.nickName;
  }

  String _getNotLoggedInHtml() {
    return '''
    <div id="menuNotLoggedIn">
      <div id="brandLogoNotLogged" class="navbar-brand" destination="landing_page"></div>
      <div class="button-wrapper">
        <a id="joinButton"  type="button" class="button-join" destination="join">REGISTRO</a>
        <a id="loginButton" type="button" class="button-login" destination="login">ENTRAR</a>
      </div>
    </div>
    ''';
  }

  String _getLoggedInHtml() {
    return '''
    <div id="menuLoggedIn">
      <div class="navbar-header">
        <button type="button" id="toggleSlideMenu" class="navbar-toggle">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <div id="brandLogoLogged" class="navbar-brand" destination="lobby"></div>
      </div>
  
      <div id="menuSlide" class="offcanvas">
        <ul class="nav navbar-nav">
          <li highlights="lobby">      <a  id="menuLobby"      destination="lobby">Buscar Torneos</a></li>
          <li highlights="my_contests"><a  id="menuMyContests" destination="my_contests">Mis torneos</a></li>
          <li highlights="">           <a  id="menuPromos"     destination="beta_info">Promos</a></li>
          
          <li highlights="user" class="right-menu">
            <a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">${_userNickName}</a>
            <ul class="dropdown-menu">
              <li><a id="menuUserMyAccount"        destination="user_profile">Mi cuenta</a></li>
              <li><a id="menuUserAddFunds"         destination="beta_info">Añadir fondos</a></li>
              <li><a id="menuUserHistory"          destination="beta_info">Historial de transacciones</a></li>
              <li><a id="menuUserReferencesCenter" destination="beta_info">Centro de referencias</a></li>
              <li><a id="menuUserClassification"   destination="beta_info">Clasificación</a></li>
              <li><a id="menuUserAyuda"            destination="help_info">Ayuda</a></li>
              <li><a id="menuUserLogOut"           destination="logout">Salir</a></li>
            </ul>
          </li>
         <!--  <li class="right-menu"><span class="current-balance">35.000€</span><button class="add-funds-button">AÑADIR FONDOS</button></li> -->
        </ul>
      </div>
    </div>
    ''';
  }

  ProfileService _profileService;
  ScreenDetectorService _scrDet;

  Element _rootElement;
  Element _menuSlideElement;
  Element _backdropElement;
  Router _router;
  VmTurnZone _turnZone;

  String _slideState = "hidden";
  bool _isLoggedIn;

  StreamSubscription _scrollCancelationListener;

  static final int _maxNicknameLength = 30;
}