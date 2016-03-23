library deprecated_version_screen_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';
import 'package:webclient/utils/game_metrics.dart';

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
    GameMetrics.logEvent(GameMetrics.REQUEST_VERSION_UPDATE, {"store": "iOS"});
    window.open("itms-apps://itunes.apple.com/app/$marketAppId", "_system");
  }
  
  bool _show = false;
  
  void set show(bool aValue) {
    if (_show != aValue) {
      _show = aValue;
      
      if (_show) {
        GameMetrics.logEvent(GameMetrics.DEPRECATED_VERSION, {"store": "iOS"});
      }
    }
  }
  
  bool get show => _show;
  
  String marketAppId; //id1091515990
  
  static DeprecatedVersionScreenComp _instance;
}
