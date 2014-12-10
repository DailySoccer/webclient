library landing_page_1_slide_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/game_metrics.dart';


@Component(
   selector: 'landing-page-1-slide',
   templateUrl: 'packages/webclient/components/landing_page_1_slide_comp.html',
   useShadowDom: false
)
class LandingPage1SlideComp implements ShadowRootAware, DetachAware {

  String content;
  ScreenDetectorService scrDet;

  int get screenHeight => window.innerHeight -70 - 122;


  LandingPage1SlideComp(this._router, this._profileService, this.scrDet, this._loadingService) {
    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);
    GameMetrics.logEvent(GameMetrics.LANDING_PAGE);
    GameMetrics.trackConversion(true);
  }

  void smoothScrollTo(String selector) {
    scrDet.scrollTo(selector, offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void onShadowRoot(emulatedRoot) {

    // Nos deberia venir con el loading activo, ahora lo quitamos
    _loadingService.isLoading = false;

    // Capturamos los elementos envolventes, porque el layout en landing page es diferente al del resto de la web.
    _bodyObj     = querySelector('body');
    _mainWrapper = querySelector('#mainWrapper');

    //_bodyObj.classes.add('fondo-negro');
    _mainWrapper.classes
      ..remove('wrapper-content-container')
      ..add('landing-wrapper');

    _mainContent = querySelector('#mainContent');
    _mainContent.classes
      ..remove('main-content-container');

    if(scrDet.isXsScreen) {
      onScreenWidthChange("xs");
    }
  }

  void detach() {
    _streamListener.cancel();

    if (_bodyObj != null) {
      _bodyObj.classes.remove('fondo-negro');
    }

    if (_mainWrapper != null) {
      _mainWrapper.classes
        ..remove('landing-wrapper')
        ..add('wrapper-content-container');
    }

    if (_mainContent != null) {
      _mainContent.classes
        ..remove('unlogged-margin')
        ..add('main-content-container');
    }
  }

  void onScreenWidthChange(String msg) {
    // Solo nos mostramos como modal en desktop
    if (msg == "xs") {
      Element container = querySelector('#mobileContent .content');
      if (container != null) {
        container.style.height = ('${window.innerHeight -130}px');
      }
    }
  }

  void buttonPressed(String route) {
    _router.go(route, {});
    scrDet.scrollTo('#mainWrapper', offset: 0, duration:  0, smooth: false, ignoreInDesktop: false);
  }

  var _streamListener;

  int _windowHeigtht;

  Router _router;
  ProfileService _profileService;
  LoadingService _loadingService;

  Element _bodyObj;
  Element _mainWrapper;
  Element _mainContent;
}