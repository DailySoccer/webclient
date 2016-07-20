library secondary_tab_bar_comp;

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'dart:html';
import 'dart:math';

@Component(
    selector: 'secondary-tab-bar',
    templateUrl: 'packages/webclient/components/navigation/secondary_tab_bar_comp.html',
    useShadowDom: false
)
class SecondaryTabBarComp {

  List get tabs => _appStateService.appSecondaryTabBarState.tabList;
    
  String get nTabsClass {
    if (tabs.length > 6) {
      Logger.root.severe("Too much secondary tabs");
    }
    return "tabs-count-${min(tabs.length, 6)}";
  }
  
  SecondaryTabBarComp(this._appStateService) {}
  
  AppStateService _appStateService;
}