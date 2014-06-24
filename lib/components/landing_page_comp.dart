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
class LandingPageComp  implements ShadowRootAware, DetachAware {
  
  String content;
  HtmlElement mainWrapper;
  HtmlElement containerForContent;
 
  LandingPageComp(Scope scope, this._router, this._profileService) {
    
    //capturamos el elemento wrapper
    mainWrapper = document.getElementById('mainWrapper');
    containerForContent = document.getElementById('mainContent'); 
 }
  
  void onShadowRoot(var root) {
    
   if(_profileService.isLoggedIn)
       _router.go("lobby", {});
       
   mainWrapper.classes.clear();
   mainWrapper.classes.add('landing-wrapper');
   containerForContent.classes.clear();
 }
 
 void detach() {
   mainWrapper.classes.clear();
   mainWrapper.classes.add('wrapper-content-container');
   containerForContent.classes.add('main-content-container');
 }
 
 Router _router;
 ProfileService _profileService;
}