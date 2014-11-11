library footer_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/loading_service.dart';
import 'dart:html';

@Component(
   selector: 'footer',
   templateUrl: 'packages/webclient/components/navigation/footer_comp.html',
   useShadowDom: false
)
class FooterComp {
  DateTimeService dateTimeService;
  ProfileService profileService;
  LoadingService loadingService;

  bool get isDev => HostServer.isDev;

  FooterComp(this.profileService, this.dateTimeService,  this._router, this.loadingService) {
    // Queremos que durante la carga se vea la imagen de fondo. Por eso esperamos hasta este punto
    // para cambiarlo.
    querySelector("ng-view").style.backgroundColor = "#FFF";
  }

  void goTo(String routePath) {
    _router.go(routePath, {});
  }

  Router _router;
}