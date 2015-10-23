library landing_page_1_slide_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
   selector: 'landing-page-1-slide',
   useShadowDom: false
)
class LandingPage1SlideComp implements ShadowRootAware, DetachAware {

  String content;
  ScreenDetectorService scrDet;

  int get screenHeight => window.innerHeight -70 - 122;


  String getLocalizedText(key) {
    return StringUtils.translate(key, "landing");
  }

  LandingPage1SlideComp(this._router, this._profileService, this.scrDet, this._loadingService, this._rootElement) {
    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);
    GameMetrics.logEvent(GameMetrics.LANDING_PAGE);
    GameMetrics.trackConversion(true);
  }

  void _composeDesktopHtml() {
    String html = _commonHTML.replaceAll('@HTMLContent', _theDesktopHTML);
    _createHTML(html);
  }

  void _ComposeMobileHtml() {
    String html = _commonHTML.replaceAll('@HTMLContent', _theMobileHTML);
    _createHTML(html);
  }

  void _createHTML(String theHTML) {
    _rootElement.nodes.clear();
    _rootElement.setInnerHtml(theHTML, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.querySelectorAll("[destination]").onClick
      .listen(_buttonPressed);
  }

  void smoothScrollTo(String selector) {
    scrDet.scrollTo(selector, offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void onShadowRoot(emulatedRoot) {
    // Nos deberia venir con el loading activo, ahora lo quitamos
    _loadingService.isLoading = false;

    if(scrDet.isXsScreen) {
      _ComposeMobileHtml();
    }
    else {
      _composeDesktopHtml();
    }
  }

  void detach() {
    _streamListener.cancel();
  }

  void onScreenWidthChange(String msg) {
    if(scrDet.isXsScreen) {
      _ComposeMobileHtml();
    }
    else {
      _composeDesktopHtml();
    }
  }

  void _buttonPressed(event) {
    String path = event.currentTarget.attributes["destination"];
    _router.go(path, {});
    scrDet.scrollTo('#mainWrapper', offset: 0, duration:  0, smooth: false, ignoreInDesktop: false);
  }

  String get _commonHTML {
    return '''
              <div class="screen-pattern"></div>
              <div id="landingPageRoot">
                @HTMLContent
                <div class="beta-label"><img src="images/beta.png"/></div>
              </div>
           ''';
  }

  String  get _theDesktopHTML {
    return '''
              <div id="desktopContent">    
                <div class="main-title-wrapper">
            
                  <div class="main-title">${getLocalizedText("title")}</div>
                  <div class="main-sub-title">${getLocalizedText("subtitle")}</div>
                  <div class="button-wrap">
                    <div id="playButtonDesktop" class="button-play" destination="lobby.welcome" >${getLocalizedText("buttonplay")}</div>
                  </div>
                  <div class="text-wrapper">
            
                    <div class="module-column">
                      <p class="icono-text">${getLocalizedText("info1")}</p>
                    </div>
            
                    <div class="module-column">
                      <p class="icono-text">${getLocalizedText("info2")}</p>
                    </div>
            
                    <div class="module-column">
                      <p class="icono-text">${getLocalizedText("info3")}</p>
                    </div>
            
                  </div>
                  <div class="modules-wrapper">
                    <div class="module-column">
                      <img src="images/iconsLeagues.png">
                    </div>
                    <div class="module-column">
                      <img src="images/iconsDevices.png">
                    </div>
                    <div class="module-column">
                      <img src="images/iconsPayment.png">
                    </div>
                  </div>
            
                </div>
                
              </div>
          ''';
  }

  String get _theMobileHTML {
    return '''
                <div id="mobileContent">
                  <div class="content">
                    <p class="main-title-mobile">DAILY FANTASY <br> LEAGUES</p>
                    <p class="title-sup-text-mobile">PLAY AS MANY CONTESTS AS YOU WANT</p>
                    <p class="title-sup-text-mobile">CREATE YOUR LINEUP IN SECONDS</p>
                    <p class="title-sup-text-mobile">AND WIN CASH</p>
                    <div class="button-wrap">
                      <div id="playButtonMobile" class="button-play-mobile" destination="lobby.welcome">${getLocalizedText("buttonplay")}</div>
                    </div>
                  </div> 
                </div>
            ''';
  }

  var _streamListener;

  Router _router;
  ProfileService _profileService;
  LoadingService _loadingService;
  Element _rootElement;
}