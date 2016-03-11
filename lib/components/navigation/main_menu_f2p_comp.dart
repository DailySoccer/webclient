library main_menu_f2p_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:intl/intl.dart';
import 'package:webclient/utils/host_server.dart';

@Component(
    selector: 'main-menu-f2p',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"])
class MainMenuF2PComp implements ShadowRootAware, ScopeAware, DetachAware {
  ProfileService profileService;

  bool betaOn = true;
  
  MainMenuF2PComp(
      this._router, this.profileService, this._scrDet, this._rootElement) {
    _router.onRouteStart.listen((RouteStartEvent event) {
      event.completed.then((_) {
        if (_router.activePath.length > 0) {
          _updateActiveElement(_router.activePath[0].name);
        }
      });
    });
    Timer timer = new Timer.periodic(new Duration(milliseconds: 500), (Timer t) {
      DivElement energyTimeLeftElement = querySelector("#energyTimeLeft");
      if (energyTimeLeftElement != null) {
        energyTimeLeftElement.text = energyTimeLeftText;
      }
    });
  }

  @override void set scope(Scope theScope) {
    _scope = theScope;
  }

  @override void onShadowRoot(emulatedRoot) {
    _scope.watch("profileService.info", _monitorChanges, canChangeModel: false);
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
    <span class='beta-label'>${StringUtils.translate('beta', 'mainmenu')} <small>${HostServer.CURRENT_VERSION}</small></span>
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
      _router.go('home', {});
      profileService.logout();
    } else {
      String paramString = event.currentTarget.attributes["params"];
      if (paramString != null) {
        Map paramMap = StringUtils.stringToMap(paramString.toString());
        _router.go(destination, paramMap);
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
    return "<span class='current-manager'>${profileService.user.ManagerPoints.toString()}</span><span class='max-manager'>/${profileService.user.pointsToNextLevel}</span>";
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

    int gold = profileService.user.Gold;
    String goldString = gold.toString();

    if(gold > 9999) {
      gold ~/= 1000;
      goldString = '${gold}k';

      if(gold > 999) {
        gold ~/= 1000;
        goldString = '${gold}M';
      }
    }

    return goldString;
  }

  String get _userTrueSkill {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return StringUtils.parseTrueSkill(profileService.user.trueSkill);
  }

  String get _userPhoto {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.profileImage;
  }

  String get _energyTimeLeft {
    if (!profileService.isLoggedIn) {
      return "";
    }
    return profileService.user.printableEnergyTimeLeft;
  }

  String get _notificationsCountCode {
    int numNotifications = profileService.isLoggedIn ? profileService.user.notifications.length : 0;

    if (numNotifications > 0) {
      return "<span class='count'>${numNotifications}</span>";
    }
    return "";
  }

  String _getNotLoggedInHtml() {
    return '''
    <div id="menuNotLoggedIn">
      <div id="brandLogoNotLogged" class="navbar-brand" destination="home"></div>
      <div id ="desktopMenu" class="fixed-menu">        
        <ul class="links-options">
          <li highlights="home"          class="mainLink"> ${getMainMenuLink("home")}         </li>
          <li highlights="lobby"         class="mainLink"> ${getMainMenuLink("lobby")}        </li>
        </ul>
        
        <div class="button-wrapper">
          <div id="helpButton" type="button" class="button-help-flat" destination="help_info" highlights="help_info">${StringUtils.translate("howitworks", "mainmenu")}</div>
          <div id="signupButton" type="button" class="button-signup-flat" destination="join">${StringUtils.translate("signup", "mainmenu")}</div>
          <div id="loginButton" type="button" class="button-login-flat" destination="login">${StringUtils.translate("login", "mainmenu")}</div>
        </div>
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
        <div id="brandLogoLogged" class="navbar-brand" destination="home"></div>
      </div>

      <div id="menuSlide" class="menu-elements">
        <ul class="nav navbar-nav">
          ${getMainOptions()}
          <li highlights="user" class="right-menu username-dropdown-toggle" >
            <menu-a id="menuUser" class="dropdown-toggle" data-toggle="dropdown">${_userNickName}</menu-a>
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
          <li class="energy additive" destination="shop">
            <img src="images/icon-lightning-lg.png"> 
            <span class="energyCount">${profileService.user.Energy}</span>    
            <div class="count">
              <div class="time-left" id="energyTimeLeft">${energyTimeLeftText}</div>
              <!--div class="progress">
                <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="${User.MAX_ENERGY}" style="width:${profileService.user.Energy * 100 / User.MAX_ENERGY}%"></div>                  
              </div-->
              ${profileService.user.printableEnergyTimeLeft != ""? "<span class='plus'>+</span></div>" : ""}            
          </li>

          <li class="manager-points additive"> 
            <img src="images/icon-star-lg.png">
            <span class="managerLevel">${_userManagerLevel}</span>     
            <div class="count">
                ${_userManagerPoints}
                <!--span class="plus">+</span-->
            </div>            
          </li>

          <li class="coins additive" destination="shop">
            <img src="images/icon-coin-lg.png">      
            <div class="count"><span class='amount'>${_userGold}</span><span class="plus">+</span></div>
          </li>

          <li id="desktopMenuUser" class="profile">
            <img src="$_userPhoto" data-toggle="dropdown">
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
  
  String get energyTimeLeftText {
    String text = profileService.user.printableEnergyTimeLeft;
    if (profileService.user.printableEnergyTimeLeft == "") {
      text = "Completo";
    }
    return text;
  }
  
  String getUserMenuOptions(bool isDesktop) {
    if (isDesktop) {
      return '''        
          <li><menu-a id="menuUserMyAccount" destination="user_profile"> ${StringUtils.translate("myaccount",  "mainmenu")}</menu-a></li>
          <li><menu-a id="menuUserShop"      destination="shop">         ${StringUtils.translate("shop",       "mainmenu")}</menu-a></li>
          <!--li><menu-a id="menuHowItWorks" destination="help_info">    ${StringUtils.translate("howitworks", "mainmenu")}</menu-a></li-->
          <li><menu-a id="menuUserLogOut"    destination="logout">       ${StringUtils.translate("logout",     "mainmenu")}</menu-a></li>
        </ul>
      ''';
    }
    return '';
  }

  String getMainOptions() {
    return '''
      <li highlights="home"          class="mainLink"> ${getMainMenuLink("home")}         </li>
      <li highlights="lobby"         class="mainLink"> ${getMainMenuLink("lobby")}        </li>
      <li highlights="my_contests"   class="mainLink"> ${getMainMenuLink("my_contests")}  </li>
      <li highlights="leaderboard"   class="mainLink"> ${getMainMenuLink("leaderboard")}  </li>
      <li highlights="notifications" class="mainLink"> ${getMainMenuLink("notifications")}</li>
      <li highlights="help_info"     class="mainLink"> ${getMainMenuLink("help")}         </li>
    ''';
  }

  String getMainMenuLink(String menuLink) {
    String ret = "";

    switch (menuLink) {
      case "home":
        ret = '''<menu-a id="menuHome"        destination="home">                             ${StringUtils.translate("home",          "mainmenu")}</menu-a>''';
        break;
      case "lobby":
        ret = '''<menu-a id="menuLobby"       destination="lobby">                            ${StringUtils.translate("lobby",         "mainmenu")}</menu-a>''';
        break;
      case "my_contests":
        ret = '''<menu-a id="menuMyContests"  destination="my_contests" params="section:live">${StringUtils.translate("mycontest",     "mainmenu")}</menu-a>''';
        break;
      case "leaderboard":
        ret = '''<menu-a id="menuLeaderboard" destination="leaderboard" params="section:points, userId:${profileService.user.userId}"> ${StringUtils.translate("leaderboard",   "mainmenu")}</menu-a>''';
        break;
      case "notifications":
        ret = '''<menu-a id="menuNotifications" destination="notifications">                  ${StringUtils.translate("notifications", "mainmenu")}${_notificationsCountCode}</menu-a>''';
        break;
      case "help":
        ret = '''<menu-a id="menuHelp"        destination="help_info">                        ${StringUtils.translate("howitworks",    "mainmenu")}</menu-a>''';
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
