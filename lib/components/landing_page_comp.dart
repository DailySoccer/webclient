library landing_page_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
   selector: 'landing-page',
   templateUrl: 'packages/webclient/components/landing_page_comp.html',
   publishAs: 'landingPage',
   useShadowDom: false
)
class LandingPageComp implements ShadowRootAware, DetachAware {

  String content;
  HtmlElement mainWrapper;
  HtmlElement containerForContent;

  LandingPageComp(Scope scope, this._router, this._profileService) {

    // Capturamos el elemento wrapper
    mainWrapper = document.getElementById('mainWrapper');
    containerForContent = document.getElementById('mainContent');
  }

  void onShadowRoot(var root) {

    if(_profileService.isLoggedIn)
      _router.go("lobby", {});
      //_router.go("enter_contest", {'contestId': '539fbfdb300456034ddd85a5'});

    mainWrapper.classes.clear();
    mainWrapper.classes.add('landing-wrapper');
    containerForContent.classes.clear();
  }

  void detach() {
    mainWrapper.classes.clear();
    mainWrapper.classes.add('wrapper-content-container');
    containerForContent.classes.add('main-content-container');
  }

  
  void goToLobby(){
    _router.go("lobby", {});
  }
  
  
  Router _router;
  ProfileService _profileService;
}