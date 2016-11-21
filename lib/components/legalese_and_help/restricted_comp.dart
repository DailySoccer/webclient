library restricted_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'restricted-comp',
    templateUrl: 'restricted_comp.html'
)
class RestrictedComp {

  String getLocalizedText(key) {
    return StringUtils.translate(key, "restricted");
  }

  RestrictedComp(this._router);

  void backToLobby() {
    _router.navigate(["lobby", {}]);
  }
  void gotoTerminus() {
    _router.navigate(['terminus_info', {}]);
  }

  Router _router;
}
