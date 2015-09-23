library restricted_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'restricted-comp',
    templateUrl: 'packages/webclient/components/legalese_and_help/restricted_comp.html',
    useShadowDom: false
)
class RestrictedComp {

  String GetLocalizedText(key) {
    return StringUtils.Translate(key, "restricted");
  }

  RestrictedComp(this._router);

  void backToLobby() {
    _router.go("lobby", {});
  }
  void gotoTerminus() {
    _router.go('terminus_info', {});
  }

  Router _router;
}
