library main_menu_f2p_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'main-menu-f2p',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"])
class MainMenuF2PComp implements ShadowRootAware, ScopeAware, DetachAware {
  ProfileService profileService;

  MainMenuF2PComp(
      this._router, this.profileService, this._scrDet, this._rootElement) {
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
    _streamListener = _scrDet.mediaScreenWidth.listen(onScreenWidthChange);
  }
  
  @override void detach() {
    _streamListener.cancel();
  }
  
  void onScreenWidthChange(String msg) {
    _monitorChanges(null, null);
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
    String navClass = "navbar navbar-default",
        innerHtml;

    if (profileService.isLoggedIn) {
      innerHtml = _getLoggedInHtml();
      navClass += " logged-in";
    } else {
      innerHtml = _getNotLoggedInHtml();
    }

    String finalHtml = '''
    <nav id="mainMenu" class="${navClass}" role="navigation">
      ${innerHtml}
    </nav>
    ''';

    _rootElement.setInnerHtml(finalHtml, treeSanitizer: NULL_TREE_SANITIZER);

    if (profileService.isLoggedIn) {
      restrictUserNameWidth();
    }
  }

  void restrictUserNameWidth() {
    Element userNameElement = _rootElement.querySelector('#menuUser');
    if (userNameElement != null) {
      userNameElement.text = trimStringToPx(userNameElement, _maxNicknameWidth);
    }
  }

  void _setUpSlidingMenu() {
    if (!profileService.isLoggedIn) {
      return;
    }

    _rootElement.querySelector("#toggleSlideMenu").onClick
        .listen(_onToggleSlidingMenuClick);
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
    _rootElement.querySelectorAll("[destination]").onClick
        .listen(_onElementWithDestinationClick);

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
    } else {
      String paramString = event.currentTarget.attributes["params"];
      if (paramString != null) {
        _router.go(
            destination, StringUtils.stringToMap(paramString.toString()));
      } else {
        _router.go(destination, {});
      }
    }
  }

  void _onToggleSlidingMenuClick(MouseEvent e) {
    if (_slideState == "hidden") {
      _show();
    } else {
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

    _scrollEndListener =
        querySelector("body").onTouchEnd.listen((_) => lastY = -1);

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
    List<Element> elem = _rootElement.querySelectorAll(".active");
    
    if (elem != null) {
      elem.forEach((e){ e.classes.remove('active');});
    }
    
    elem = _rootElement.querySelectorAll("[highlights=${name}]");

    if (elem == null && _isRouteNameInsideUserMenu(name)) {
      elem = _rootElement.querySelectorAll('[highlights="user"]');
    }

    if (elem != null) {
      elem.forEach((e){ e.classes.add('active');});
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

  String get _maxEnergy {
    return User.MAX_ENERGY.toString();
  }

  String get _userEnergy {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.Energy.toString();
  }

  String get _userManagerPoints {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.ManagerPoints.toString();
  }

  String get _userGold {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.Gold.toString();
  }

  String get _userTrueSkill {
    return '9999';
  }
  String get _energyTimeLeft {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.printableEnergyTimeLeft;
  }

  String _getNotLoggedInHtml() {
    return '''
    <div id="menuNotLoggedIn">
      <div id="brandLogoNotLogged" class="navbar-brand" destination="landing_page"></div>
      <div class="button-wrapper">
        <div id="loginButton" type="button" class="button-login-flat" destination="login">${StringUtils.translate("login", "mainmenu")}</div>
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

      <div id="menuSlide" class="menu-elements">
        <ul class="nav navbar-nav">
          <li highlights="lobby"       class="mainOption"><a  id="menuLobby"      destination="lobby">${StringUtils.translate("lobby", "mainmenu")}</a></li>
          <li highlights="my_contests" class="mainOption"><a  id="menuMyContests" destination="my_contests" params="section:live">${StringUtils.translate("mycontest", "mainmenu")}</a></li>
          <li highlights="help_info"   class="mainOption"><a  id="menuHowItWorks" destination="help_info">${StringUtils.translate("howitworks", "mainmenu")}</a></li>
          <li id="userBalanceOut-sm"   class="right-menu">
            <div class="balance">
              <span class="current-balance">${_userBalance}</span>
              <button class="add-funds-button" destination="add_funds">${StringUtils.translate("buttonaddfunds", "mainmenu")}</button>
            </div>
          </li>
          <li highlights="user" class="right-menu username-dropdown-toggle" >
            <a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">${_userNickName}</a>
            <ul class="dropdown-menu">
              <li><a id="menuUserMyAccount"        destination="user_profile">${StringUtils.translate("myaccount", "mainmenu")}</a></li>
              <li id="userBalanceIn"><a id="menuUserAddFunds-sm" destination="add_funds">${StringUtils.translate("addfunds", "mainmenu")}</a></li>
              <li><a id="menuUserHistory"          destination="transaction_history">${StringUtils.translate("transactions", "mainmenu")}</a></li>
              <!--li><a id="menuUserReferencesCenter" destination="beta_info">${StringUtils.translate("referral", "mainmenu")}</a></li>
              <li><a id="menuUserClassification"   destination="beta_info">${StringUtils.translate("classification", "mainmenu")}</a></li-->
              <!--<li><a id="menuUserAyuda"            destination="help_info">${StringUtils.translate("howitworks2", "mainmenu")}</a></li>-->
              <li><a id="menuUserLogOut"           destination="logout">${StringUtils.translate("logout", "mainmenu")}</a></li>
            </ul>
          </li>
          
          <li id="userBalanceOut-xs" class="right-menu">
            <a id="menuUserAddFunds-xs" destination="add_funds">${StringUtils.translate("buttonaddfunds", "mainmenu")} <span class="current-balance">${_userBalance}</span></a>            
          </li>
        </ul>
      </div>

      <div id ="desktopMenu" class="fixed-menu">
        
        <div class="links-options">
          <div highlights="lobby" class="mainLink">
            <a id="menuLobby" destination="lobby" highlights="lobby">${StringUtils.translate("lobby", "mainmenu")}</a>
          </div>
          <div highlights="my_contests" class="mainLink">
            <a id="menuMyContests" destination="my_contests" params="section:live">${StringUtils.translate("mycontest", "mainmenu")}</a>
          </div>
          <div highlights="help_info" class="mainLink">
            <a id="menuHowItWorks" destination="help_info">${StringUtils.translate("howitworks", "mainmenu")}</a>
          </div>
        </div>
      
        <div class="fixed-user-stats">

          <div class="energy">         
            <img src="images/icon-lightning-lg.png"> 
            <div class="count">${_userEnergy}/${_maxEnergy}</div>
          </div>
          <div class="manager-points"> 
            <img src="images/icon-star-lg.png">     
            <div class="count">${_userManagerPoints}</div>
          </div>
          <div class="coins">
            <img src="images/icon-coin-lg.png">      
            <div class="count">${_userGold}</div>
          </div>
          <div id="desktopMenuUser" class="profile">       
            <img src="images/icon-userProfile.png" data-toggle="dropdown">
            <div class="count">${_userTrueSkill}</div>
            ${getDesktopFixedMenu()}
          </div> 
        </div>
      
      </div>
    </div>
    ''';
    }

  String getDesktopFixedMenu() {
    if (_scrDet.isNotXsScreen) {
      return '''
        
          <ul id="desktopUserMenu" class="dropdown-menu">
            <li><a id="menuUserMyAccount"        destination="user_profile">${StringUtils.translate("myaccount", "mainmenu")}</a></li>
            <li id="userBalanceIn"><a id="menuUserAddFunds-sm" destination="add_funds">${StringUtils.translate("addfunds", "mainmenu")}</a></li>
            <li><a id="menuUserHistory"          destination="transaction_history">${StringUtils.translate("transactions", "mainmenu")}</a></li>
            <!--li><a id="menuUserReferencesCenter" destination="beta_info">${StringUtils.translate("referral", "mainmenu")}</a></li>
            <li><a id="menuUserClassification"   destination="beta_info">${StringUtils.translate("classification", "mainmenu")}</a></li-->
            <!--<li><a id="menuUserAyuda"            destination="help_info">${StringUtils.translate("howitworks2", "mainmenu")}</a></li>-->
            <li><a id="menuUserLogOut"           destination="logout">${StringUtils.translate("logout", "mainmenu")}</a></li>
          </ul>
      ''';
    }
    return '';
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
  
  var _streamListener;
  
  static final int _maxNicknameWidth = 170;
}
