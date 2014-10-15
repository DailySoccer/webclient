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

  int get screenHeight => window.innerHeight;
/*
  String getBounds(String elemId) {
    Element elem = querySelector('#' + elemId + ' .screen-text-block');
    double container_height = elem.getBoundingClientRect().height;
    double wrapper_height = elem.parent.parent.getBoundingClientRect().height;

    return "wrapper: ${wrapper_height} - container: ${container_height}";
  }

  Map getStyle(String elemId) {
    Element elem = querySelector('#' + elemId + ' .screen-text-block');
    double container_height = elem.getBoundingClientRect().height;
    double wrapper_height = elem.parent.parent.getBoundingClientRect().height;

    return {"position":"absolute", "top":"${(wrapper_height - container_height)*0.5}px;"};
  }
*/
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
    _mainContent.classes.add('unlogged-margin');

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
      _mainContent.classes.clear();
      _mainContent.classes.add('main-content-container');
    }

  }

  void buttonPressed(String route) {
    _router.go(route, {});
  }

  Router _router;
  ProfileService _profileService;
}