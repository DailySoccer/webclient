library landing_page_comp;

import 'package:webclient/components/wrapper_content_container_comp.dart'; 
import 'package:angular/angular.dart';


@Component(
   selector: 'landing-page',
   templateUrl: 'packages/webclient/components/landing_page_comp.html',
   publishAs: 'landingPage',
   useShadowDom: false
)

class LandingPageComp {
  
  String content;
  
  LandingPageComp(Scope scope, this._router) {
   content    = "Under constrution: landing page";
 }
  
 Router _router;
}