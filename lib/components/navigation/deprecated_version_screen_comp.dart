library deprecated_version_screen_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'deprecated-version-screen',
    templateUrl: 'packages/webclient/components/navigation/deprecated_version_screen_comp.html',
    useShadowDom: false
)
class DeprecatedVersionScreenComp {

  DeprecatedVersionScreenComp();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "deprecatedVersion", substitutions);
  }
  
  void goShop() {
    
  }
  
  bool get show => false;
}
