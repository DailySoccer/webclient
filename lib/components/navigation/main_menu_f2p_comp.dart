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

/*
  String get _userEnergy {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.Energy.toString();
  }
*/
  String get _userManagerPoints {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return "${profileService.user.ManagerPoints.toString()}/${profileService.user.pointsToNextLevel}";
  }

  String get _userManagerLevel {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.managerLevel.toInt().toString();
  }

  String get _userGold {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.Gold.toString();
  }

  String get _userTrueSkill {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return StringUtils.parseTrueSkill(profileService.user.trueSkill);
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
          ${getMainOptions()}
          <li highlights="user" class="right-menu username-dropdown-toggle" >
            <a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">${_userNickName}</a>
            <ul class="dropdown-menu">
              ${getUserMenuOptions(_scrDet.isXsScreen)}
            </ul>
          </li>
        </ul>
      </div>

      <div id ="desktopMenu" class="fixed-menu">        
        <ul class="links-options">
          ${getMainOptions()}
        </ul>
      
        <ul class="fixed-user-stats">
          <li class="energy additive" destination="shop.energy">
            <img src="images/icon-lightning-lg.png"> 
            <div class="count">
              <div class="progress">
                <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="${User.MAX_ENERGY}" style="width:${profileService.user.Energy * 100 / User.MAX_ENERGY}%"></div>
              </div>            
              <span class="plus">+</span></div>            
          </li>

          <li class="manager-points additive" destination="shop"> 
            <img src="images/icon-star-lg.png">
            <span class="managerLevel">${_userManagerLevel}</span>     
            <div class="count">
                ${_userManagerPoints}
                <span class="plus">+</span>
            </div>            
          </li>

          <li class="coins additive" destination="shop.gold">
            <img src="images/icon-coin-lg.png">      
            <div class="count">${_userGold}<span class="plus">+</span></div>
          </li>

          <li id="desktopMenuUser" class="profile">       
            <img src="images/icon-userProfile.png" data-toggle="dropdown">
            <div class="count">${_userTrueSkill}</div>
            <ul id="desktopUserMenu" class="dropdown-menu">
              ${getUserMenuOptions(_scrDet.isNotXsScreen)}
            </ul>
          </li> 
        </ul>
      
      </div>
    </div>
    ''';
    }

  String getUserMenuOptions(bool isDesktop) {
    if (isDesktop) {
      return '''        
          <li><a id="menuUserMyAccount" destination="user_profile"> ${StringUtils.translate("myaccount",  "mainmenu")}</a></li>
          <li><a id="menuUserShop"      destination="shop">         ${StringUtils.translate("shop",       "mainmenu")}</a></li>
          <li><a id="menuHowItWorks"    destination="help_info">    ${StringUtils.translate("howitworks", "mainmenu")}</a></li>
          <li><a id="menuUserLogOut"    destination="logout">       ${StringUtils.translate("logout",     "mainmenu")}</a></li>
        </ul>
      ''';
    }
    return '';
  }
  
  String getMainOptions() {
    return '''
      <li highlights="lobby"       class="mainLink"> ${getMainMenuLink("lobby")}       </li>
      <li highlights="my_contests" class="mainLink"> ${getMainMenuLink("my_contests")} </li>
      <li highlights="leaderboard" class="mainLink"> ${getMainMenuLink("leaderboard")} </li>
    ''';
  }
  
  String getMainMenuLink(String menuLink) {
    String ret = "";
    
    switch (menuLink) {
      case "lobby":
        ret = '''<a id="menuLobby"      destination="lobby">                            ${StringUtils.translate("lobby",        "mainmenu")}</a>''';
        break;
      case "my_contests":
        ret = '''<a id="menuMyContests" destination="my_contests" params="section:live">${StringUtils.translate("mycontest",    "mainmenu")}</a>''';
        break;
      case "leaderboard":
        ret = '''<a id="menuLeaderboard" destination="leaderboard">                     ${StringUtils.translate("leaderboard",  "mainmenu")}</a>''';
        break;
    }
    
    return ret;    
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
