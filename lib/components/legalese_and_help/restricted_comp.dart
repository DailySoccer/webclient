library restricted_comp;

import 'package:angular/angular.dart';

@Component(
    selector: 'restricted-comp',
    templateUrl: 'packages/webclient/components/legalese_and_help/restricted_comp.html',
    useShadowDom: false
)
class RestrictedComp {
  RestrictedComp(this._router);

  void backToLobby() {
    _router.go("lobby", {});
  }
  void gotoTerminus() {
    _router.go('terminus_info', {});
  }

  Router _router;
}
