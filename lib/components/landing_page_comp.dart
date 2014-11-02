library landing_page_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';


@Component(
   selector: 'landing-page',
   templateUrl: 'packages/webclient/components/landing_page_comp.html',
   useShadowDom: false
)
class LandingPageComp implements ShadowRootAware, DetachAware {

  String content;
  ScreenDetectorService scrDet;

  int get screenHeight => window.innerHeight;


  LandingPageComp(this._router, this._profileService, this.scrDet, this._loadingService);

  void onShadowRoot(emulatedRoot) {

    // Nos deberia venir con el loading activo, ahora lo quitamos
    _loadingService.isLoading = false;

    // Capturamos los elementos envolventes, porque el layout en landing page es diferente al del resto de la web.
    _bodyObj     = querySelector('body');
    _mainWrapper = querySelector('#mainWrapper');
    _mainContent = querySelector('#mainContent');

    _bodyObj.classes.add('fondo-negro');
    _mainWrapper.classes
      ..clear()
      ..add('landing-wrapper');

    _mainContent.classes.clear();
    _mainContent.classes.add('unlogged-margin');
  }

  void detach() {

    if (_bodyObj != null) {
      _bodyObj.classes.remove('fondo-negro');
    }

    if (_mainWrapper != null) {
      _mainWrapper.classes
        ..clear()
        ..add('wrapper-content-container');
    }

    if (_mainContent != null) {
      _mainContent.classes.clear();
      _mainContent.classes.add('main-content-container');
    }
  }

  void buttonPressed(String route) {
    _router.go(route, {});
  }

  Router _router;
  ProfileService _profileService;
  LoadingService _loadingService;

  Element _bodyObj;
  Element _mainWrapper;
  Element _mainContent;
}