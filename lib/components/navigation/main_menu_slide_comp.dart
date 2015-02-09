library main_menu_slide_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:async';

@Component(
    selector: 'main-menu-slide',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"]
)
class MainMenuSlideComp implements ShadowRootAware, ScopeAware {

  ProfileService profileService;

  MainMenuSlideComp(this._router, this.profileService, this._scrDet, this._rootElement) {
    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          _updateActiveElement(_router.activePath[0].name);
        }
      });
    });
  }

  @override void set scope(Scope theScope) {
    _scope = theScope;
  }

  @override void onShadowRoot(emulatedRoot) {
    _scope.watch("profileService.user", _monitorChanges, canChangeModel: false);
  }

  void _monitorChanges(currentVal, prevVal) {
    _reset();
    _createHtml();
    if (_router.activePath.length > 0) {
      _updateActiveElement(_router.activePath[0].name);
    }
    _setUpSlidingMenu();
    _setUpClicks();
  }

  void _reset() {
    // Basta con asignar a null puesto que recreamos de 0 el HTML
    _menuSlideElement = null;
    _backdropElement = null;

    querySelector("body").classes.remove("main-menu-slide-in");

    // Nos pueden haber deslogeado con el menu desplegado
    _cancelListeners();

    _slideState = "hidden";
  }

  void _createHtml() {

    String navClass = "navbar navbar-default", innerHtml;

    if (profileService.isLoggedIn) {
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

    if (profileService.isLoggedIn) {
      restrictUserNameWidth();
    }
  }

  void  restrictUserNameWidth() {
      Element userNameElement = _rootElement.querySelector('#menuUser');
      if (userNameElement != null) {
        userNameElement.text = trimStringToPx(userNameElement, _maxNicknameWidth);
      }
  }


  void _setUpSlidingMenu() {

    if (!profileService.isLoggedIn) {
      return;
    }

    _rootElement.querySelector("#toggleSlideMenu").onClick.listen(_onToggleSlidingMenuClick);
    _menuSlideElement = _rootElement.querySelector("#menuSlide");

    // Tanto el menuSlide como el backdrop estan ocultos fuera de la pantalla en xs
    _menuSlideElement.classes.add("hidden-xs");

    // El backdrop es la cortinilla traslucida que atenua todo el contenido
    _backdropElement = new DivElement();
    _backdropElement.id = "backdrop";
    _backdropElement.classes.add("hidden-xs");

    // La insertamos en 0 para que no pise al #menuSlide
    _menuSlideElement.parent.children.insert(0, _backdropElement);

    // Control de animacion
    _menuSlideElement.onTransitionEnd.listen((_) {
      if (_slideState == "hidden") {
        _menuSlideElement.classes.add("hidden-xs");
        _backdropElement.classes.add("hidden-xs");
      }
    });
  }

  void _setUpClicks() {
    _rootElement.querySelectorAll("[destination]").onClick.listen(_onElementWithDestinationClick);

    if (_backdropElement != null) {
      _backdropElement.onClick.listen((_) => _hide());
    }
  }

  void _onElementWithDestinationClick(event) {

    String destination = event.currentTarget.attributes["destination"];

    _hide();

    if (destination == "logout") {
      _router.go('landing_page', {});
      profileService.logout();
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

    _menuSlideElement.classes.remove("hidden-xs");
    _backdropElement.classes.remove("hidden-xs");

    querySelector("body").classes.add("main-menu-slide-in");

    int lastY = -1;
    _scrollMoveListener = querySelector("body").onTouchMove.listen((event) {
      var elem = event.target as Element;

      if (elem.matchesWithAncestors("#menuSlide ul") && lastY != -1) {
        int diff = lastY - event.touches.first.client.y;
        // Aqui claramente se podria hacer con aceleracion
        _menuSlideElement.scrollTop = _menuSlideElement.scrollTop + diff;
      }

      lastY = event.touches.first.client.y;
      event.preventDefault();
    });

    _scrollEndListener = querySelector("body").onTouchEnd.listen((_) => lastY = -1);

    // Tenemos que dar un frame al browser para que calcule la posicion inicial
    window.animationFrame.then((_) {
      _menuSlideElement.classes.add("slide-in");
      _backdropElement.classes.add("slide-in");
    });
  }

  void _hide() {
    if (_menuSlideElement != null) {
      _slideState = "hidden";

      _menuSlideElement.classes.remove("slide-in");
      _backdropElement.classes.remove("slide-in");
    }

    querySelector("body").classes.remove("main-menu-slide-in");

    _cancelListeners();
  }

  void _updateActiveElement(String name) {

    LIElement li = _rootElement.querySelector("#mainMenu li.active");
    if (li != null) {
      li.classes.remove('active');
    }

    li = _rootElement.querySelector("[highlights=${name}]");

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
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.nickName;
  }

  String get _userBalance {
    if (profileService.user == null) {
      return "0";
    }
    return profileService.user.balance.toString();
  }


  String _getNotLoggedInHtml() {
    return '''
    <div id="menuNotLoggedIn">
      <div id="brandLogoNotLogged" class="navbar-brand" destination="landing_page"></div>
      <div class="button-wrapper">
        <!--
            <button id="joinButton"  type="button" class="button-join" destination="join">REGISTRO</button>
            <button id="loginButton" type="button" class="button-login" destination="login">ENTRAR</button>
        -->
        <div id="loginButton" type="button" class="button-login-flat" destination="login">ENTRAR</div>
        <!--button class="btn-fb-span">
          <fb:login-button scope="public_profile,email" size="medium" onlogin="jsLoginFB()">
          </fb:login-button>
          <script>
             if (typeof FB !== "undefined" && FB != null) {
               FB.XFBML.parse();
             }
          </script>
        </button-->
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
  
      <div id="menuSlide">
        <ul class="nav navbar-nav">
          <li highlights="lobby">      <a  id="menuLobby"      destination="lobby">Buscar Torneos</a></li>
          <li highlights="my_contests"><a  id="menuMyContests" destination="my_contests">Mis torneos</a></li>
          <li highlights="">           <a  id="menuPromos"     destination="beta_info">Promos</a></li>
          
          <li highlights="user" class="right-menu username-dropdown-toggle" >
            <a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">${_userNickName}</a>
            <ul class="dropdown-menu">
              <li><a id="menuUserMyAccount"        destination="user_profile">Mi cuenta</a></li>
              <li id="userBalanceIn"><a id="menuUserAddFunds-sm" destination="add_funds">Añadir fondos</a></li>
              <li><a id="menuUserHistory"          destination="transaction_history">Historial de transacciones</a></li>
              <li><a id="menuUserReferencesCenter" destination="beta_info">Centro de referencias</a></li>
              <li><a id="menuUserClassification"   destination="beta_info">Clasificación</a></li>
              <li><a id="menuUserAyuda"            destination="help_info">Ayuda</a></li>
              <li><a id="menuUserLogOut"           destination="logout">Salir</a></li>
            </ul>
          </li>
          <li id="userBalanceOut-sm" class="right-menu">
            <div class="balance">
              <span class="current-balance">${_userBalance}</span>
              <button class="add-funds-button" destination="add_funds">AÑADIR FONDOS</button>
            <div>
          </li>
          <li id="userBalanceOut-xs" class="right-menu">
            <a id="menuUserAddFunds-xs" destination="add_funds">Añadir fondos <span class="current-balance">${_userBalance}</span></a>            
          </li>
        </ul>
      </div>
    </div>
    ''';
  }

  void _cancelListeners() {
    if (_scrollMoveListener != null) {
      _scrollMoveListener.cancel();
      _scrollEndListener.cancel();
      _scrollMoveListener = null;
      _scrollEndListener = null;
    }
  }

  ScreenDetectorService _scrDet;
  Scope _scope;
  StreamSubscription _scrollMoveListener;
  StreamSubscription _scrollEndListener;

  Element _rootElement;
  Element _menuSlideElement;
  Element _backdropElement;
  Router _router;

  String _slideState = "hidden";

  static final int _maxNicknameWidth = 200;
}