library deprecated_version_screen_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/host_server.dart';

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
    GameMetrics.actionEvent(GameMetrics.ACTION_DEPRECATED_VERSION_GO_SHOP, GameMetrics.SCREEN_DEPRECATED_VERSION);
    
    String linkToStore = HostServer.isAndroidPlatform ? "market://details?id=$marketAppId" : "itms-apps://itunes.apple.com/app/$marketAppId";
    window.open(linkToStore, "_system");
  }
  
  bool _show = false;
  
  void set show(bool aValue) {
    if (_show != aValue) {
      _show = aValue;
      
      if (_show) {
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_DEPRECATED_VERSION);
      }
    }
  }
  
  bool get show => _show;
  
  String marketAppId; //id1091515990
  
  static DeprecatedVersionScreenComp _instance;
}
