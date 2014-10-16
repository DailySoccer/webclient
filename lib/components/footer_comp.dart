library footer_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/datetime_service.dart';


@Component(
   selector: 'footer',
   templateUrl: 'packages/webclient/components/footer_comp.html',
   publishAs: 'footer',
   useShadowDom: false
)
class FooterComp {
  DateTimeService dateTimeService;
  ProfileService profileService;

  FooterComp(this.profileService, this.dateTimeService,  this._router);

  void goTo(String routePath) {
    _router.go(routePath, {});
  }

  Router _router;
}