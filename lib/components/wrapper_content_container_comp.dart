library wrapper_content_container_comp;

import 'package:angular/angular.dart';


@Component(
   selector: 'wrapper-content-container',
   templateUrl: 'packages/webclient/components/wrapper_content_container_comp.html',
   publishAs: 'wrapperContentContainer',
   useShadowDom: false
)

class WrapperContentContainer {
  bool isLanding;
  
  
  WrapperContentContainer(Scope scope, this._router) {
   //isLanding = false;//estamos en la pagina de landing 
    print(_router.activePath.toString());
   isLanding = false;
 }

  Router _router;
}
