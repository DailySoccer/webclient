  library landing_page_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
   selector: 'landing-page',
   templateUrl: 'packages/webclient/components/landing_page_comp.html',
   publishAs: 'landingPage',
   useShadowDom: false
)

class LandingPageComp implements ShadowRootAware, DetachAware {

  String content;
  var bodyObj;
  Element mainWrapper;
  Element containerForContent;
  ScreenDetectorService scrDet;

  LandingPageComp(this._router, this._profileService, this.scrDet) {

    // Capturamos el elemento wrapper
    bodyObj             = querySelector('body');
    mainWrapper         = querySelector('#mainWrapper');
    containerForContent = querySelector('#mainContent');

  }

  void onShadowRoot(var root) {

    if(_profileService.isLoggedIn)
      _router.go("lobby", {});

    mainWrapper.classes.clear();
    mainWrapper.classes.add('landing-wrapper');
    containerForContent.classes.clear();
    //containerForContent.style.backgroundColor = "tranparent";
    bodyObj.classes.add('fondo-negro');
  }

  void detach() {
    mainWrapper.classes.clear();
    mainWrapper.classes.add('wrapper-content-container');
    containerForContent.classes.add('main-content-container');
    //containerForContent.style.backgroundColor = "#FFFFFF";
    bodyObj.classes.remove('fondo-negro');
  }


  void goToLobby(){
    _router.go("lobby", {});
  }


  Router _router;
  ProfileService _profileService;
}