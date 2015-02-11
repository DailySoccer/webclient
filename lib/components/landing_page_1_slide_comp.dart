library landing_page_1_slide_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/game_metrics.dart';


@Component(
   selector: 'landing-page-1-slide',
   useShadowDom: false
)
class LandingPage1SlideComp implements ShadowRootAware, DetachAware {

  String content;
  ScreenDetectorService scrDet;

  int get screenHeight => window.innerHeight -70 - 122;


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
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll("[buttonOnclick]").onClick.listen(_buttonPressed);
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
    String path = event.currentTarget.attributes["buttonOnclick"];
    _router.go(path, {});
    scrDet.scrollTo('#mainWrapper', offset: 0, duration:  0, smooth: false, ignoreInDesktop: false);
  }

  String _commonHTML =
    '''
      <div class="screen-pattern"></div>
      <div id="landingPageRoot">
        @HTMLContent
        <div class="beta-label"><img src="images/beta.png"/></div>
      </div>
    ''';

  String _theDesktopHTML =
    '''
      <div id="desktopContent">    
        <div class="main-title-wrapper">
    
          <div class="main-title">WEEKLY FANTASY LEAGUES</div>
          <div class="main-sub-title">
            Play and win when you want, without waiting until the end of the season.
          </div>
          <div class="button-wrap">
            <button type="button" class="button-play" buttonOnclick="join" id="playButton1">JOIN AND PLAY FREE</button>
          </div>
          <div class="text-wrapper">
    
            <div class="module-column">
              <p class="icono-text">Play in as many contests as you want of La Liga, Premier and Champions</p>
            </div>
    
            <div class="module-column">
              <p class="icono-text">Create your lineup in seconds from any device</p>
            </div>
    
            <div class="module-column">
              <p class="icono-text">You can win cash right away</p>
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

  String _theMobileHTML =
  '''
        <div id="mobileContent">
          <div class="content">
            <p class="main-title-mobile">WEEKLY FANTASY <br> LEAGUES</p>
            <p class="title-sup-text-mobile">PLAY IN AS MANY CONTESTS AS YOU WANT</p>
            <p class="title-sup-text-mobile">CREATE YOUR TEAM IN SECONDS</p>
            <p class="title-sup-text-mobile">AND WIN CASH</p>
            <div class="button-wrap">
              <button type="button" class="button-play-mobile" buttonOnclick="join" id="playButtonMobile">JOIN AND PLAY FREE</button>
            </div>
          </div> 
        </div>
    ''';
  var _streamListener;

  int _windowHeigtht;

  Router _router;
  ProfileService _profileService;
  LoadingService _loadingService;
  Element _rootElement;
}