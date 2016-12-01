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
  
  static const String OUTDATED_VERSION    = "outdated_version";
  static const String DEPRECATED_VERSION  = "deprecated_version";
  String updateType = "";

  bool OutdatedVersionDelayed = false;
  
  DeprecatedVersionScreenComp() {
    _instance = this;
    updateType = OUTDATED_VERSION;
  }

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "deprecatedVersion", substitutions);
  }
  
  void delayVersion() {
    _show = false;
    OutdatedVersionDelayed = true;
  } 
  
  void goShop() {
    //TODO: Meter enlaces de Macías 
    //https://play.google.com/store/apps/details?id=com.epiceleven.futbolcuatro&referrer=utm_source%3Dappupdate
    //https://itunes.apple.com/app/apple-store/id1091515990?pt=117969002&ct=appupdate&mt=8
    
    GameMetrics.actionEvent(GameMetrics.ACTION_DEPRECATED_VERSION_GO_SHOP, GameMetrics.SCREEN_DEPRECATED_VERSION);
    
    String linkToStore = HostServer.isAndroidPlatform ? "market://details?id=${marketAppId}&referrer=utm_source%3Dappupdate" : "itms-apps://itunes.apple.com/app/${marketAppId}?pt=117969002&ct=appupdate&mt=8";
    window.open(linkToStore, "_system");
  }
  
  bool _show = false;
  
  void showUpdate(bool aValue, String uType) {
    updateType = uType;
    if (_show != aValue  && !OutdatedVersionDelayed) {
      _show = aValue;
      
      if (_show) {
        GameMetrics.screenVisitEvent(GameMetrics.SCREEN_DEPRECATED_VERSION);
      }
    }
  }
  
  bool get show => _show; 
  
  /*
  void show(bool aValue, String type) {
    if (_show != aValue) {
        _show = aValue;
        
        if (_show) {
          GameMetrics.screenVisitEvent(GameMetrics.SCREEN_DEPRECATED_VERSION);
        }
      }
  }
  */
  
  
  
  
  
  String marketAppId; //id1091515990
  
  static DeprecatedVersionScreenComp _instance;
}
