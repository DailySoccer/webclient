library root_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
   selector: 'root',
   useShadowDom: false
)
class RootComp {

  RootComp(Router router, ProfileService profileService) {
    if (profileService.isLoggedIn) {
      router.go("lobby", {});
    }
    else {
      router.go("landing_page", {});
    }
  }
}