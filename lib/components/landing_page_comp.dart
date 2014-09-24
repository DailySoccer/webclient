library landing_page_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(
   selector: 'landing-page',
   templateUrl: 'packages/webclient/components/landing_page_comp.html',
   publishAs: 'comp',
   useShadowDom: false
)
class LandingPageComp implements ShadowRootAware, DetachAware {

  String content;
  Element _bodyObj;
  Element _mainWrapper;
  Element _mainContent;
  ScreenDetectorService scrDet;

  LandingPageComp(this._router, this._profileService, this.scrDet);

  void onShadowRoot(var root) {

    if (_profileService.isLoggedIn) {
      _router.go("lobby", {});
      return;
    }

    // Capturamos los elementos envolventes, porque el layout en landing page es diferente al del resto de la web.
    _bodyObj     = querySelector('body');
    _mainWrapper = querySelector('#mainWrapper');
    _mainContent = querySelector('#mainContent');

    _bodyObj.classes.add('fondo-negro');
    _mainWrapper.classes
      ..clear()
      ..add('landing-wrapper');
    _mainContent.classes.clear();

  }

  void detach() {
    if(_bodyObj !=null) {
      _bodyObj.classes.remove('fondo-negro');
    }
    if( _mainWrapper != null) {
      _mainWrapper.classes
        ..clear()
        ..add('wrapper-content-container');
    }
    if(_mainContent != null) {
      _mainContent.classes.add('main-content-container');
    }

  }

  void buttonPressed(String route) {
    _router.go(route, {});
  }

  Router _router;
  ProfileService _profileService;
}