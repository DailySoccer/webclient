library deprecated_version_screen_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';

@Component(
    selector: 'deprecated-version-screen',
    templateUrl: 'packages/webclient/components/navigation/deprecated_version_screen_comp.html',
    useShadowDom: false
)
class DeprecatedVersionScreenComp {

  static DeprecatedVersionScreenComp get Instance => _instance; 
  
  DeprecatedVersionScreenComp() {
    _instance = this;
  }

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "deprecatedVersion", substitutions);
  }
  
  void goShop() {
    window.open("itms-apps://itunes.apple.com/app/$marketAppId", "_system");
  }
  
  bool show = false;
  String marketAppId; //id1091515990
  
  static DeprecatedVersionScreenComp _instance;
}
