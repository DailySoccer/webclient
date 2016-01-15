library xs_not_available_screen_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'xs-not-available-screen',
    templateUrl: 'packages/webclient/components/navigation/xs_not_available_screen_comp.html',
    useShadowDom: false
)
class XsNotAvailableScreenComp {

  XsNotAvailableScreenComp();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "XsNotAvailable", substitutions);
  }
}
