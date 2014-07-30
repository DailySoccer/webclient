library footer_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
   selector: 'footer',
   templateUrl: 'packages/webclient/components/footer_comp.html',
   publishAs: 'footer',
   useShadowDom: false
)

class FooterComp {
  bool   isLoggedIn = false;
  String fullName = "";

  FooterComp(Scope scope, this._profileService) {
    isLoggedIn  = _profileService.isLoggedIn;

       scope.watch("isLoggedIn", (value, _) {
         isLoggedIn = value;

         if (isLoggedIn) {
           fullName = _profileService.user.fullName;
         }
       }, context: _profileService);
     }

  void logOut() {
    _profileService.logout();
  }

  ProfileService _profileService;

}