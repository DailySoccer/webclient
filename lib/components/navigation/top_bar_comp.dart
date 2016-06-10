library top_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'dart:html';

@Component(
    selector: 'top-bar',
    templateUrl: 'packages/webclient/components/navigation/top_bar_comp.html',
    useShadowDom: false
)
class TopBarComp {

  // LAYOUTS
  static const String THREE_COLUMNS = "THREE_COLUMNS";
  static const String ONE_COLUMN = "ONE_COLUMN";
  static const String NONE_COLUMNS = "NONE";

  // LAYOUT ELEMENTS
  String backButton([String clas = ""]) {
    return "<button class='back-button $clas'>BACK</button>";
  }
  String titleLabel([String clas = ""]) {
    return "<div class='title-label $clas'>${configParameters["title"]}</div>";
  }
  String empty([String clas = ""]) {
    return "<div class='empty-element $clas'></div>";
  }
  String userCurrencies([String clas = ""]) {
    return '''
              <div class='user-currencies $clas'>
                <div class="energy-currency currency">
                  <span class="enery-icon">E</span>
                  <span class="enery-counter">12</span>
                </div>
                <div class="gold-currency currency">
                  <span class="gold-icon">G</span>
                  <span class="gold-counter">14</span>
                </div>
                <div class="manager-level currency">
                  <span class="manager-icon">M</span>
                  <span class="manager-counter">10</span>
                </div>
              </div>
          ''';
  }
  String createContestButton([String clas = ""]) {
    return "<button class='create-contest $clas'>( + )</button>";
  }
  String liveContestButton([String clas = ""]) {
    return "<button class='live-contest $clas'>Y</button>";
  }
  
  // 
  static const Map HIDDEN_CONFIG     = const { "layout"  : NONE_COLUMNS,
                                               "elements": const[] };
                                               
  Map get LOBBY_CONFIG      => { "layout"  : THREE_COLUMNS, 
                                 "elements": [createContestButton, userCurrencies, liveContestButton] };
  Map get SUBSECTION_CONFIG => { "layout"  : THREE_COLUMNS, 
                                 "elements": [backButton, titleLabel, empty] };
  Map get SECTION_CONFIG    => { "layout"  : ONE_COLUMN,
                                 "elements": [titleLabel] };
  
  Map configParameters = { "title" : "FURBORCUATRO" };
  Map _currentConfig = HIDDEN_CONFIG;
  Map get currentConfig => LOBBY_CONFIG;
  
  String get layoutCssClass => currentConfig["layout"] == THREE_COLUMNS ? "three-columns" :
                               currentConfig["layout"] == ONE_COLUMN ? "one-column" : "hidden-bar";
  
  String get leftColumnHTML => currentConfig["layout"] == THREE_COLUMNS ? currentConfig['elements'][0]() : '';
  String get centerColumnHTML => currentConfig["layout"] == NONE_COLUMNS? '' : currentConfig['elements'][currentConfig["layout"] == THREE_COLUMNS? 1 : 0]();
  String get rightColumnHTML => currentConfig["layout"] == THREE_COLUMNS ? currentConfig['elements'][2]() : '';
  
  TopBarComp(/*this._router, this._loadingService, this._view, this._rootElement, 
              this._dateTimeService, this._profileService, this._templateService, 
              this._catalogService, this._appStateService*/) {
    
    
  }
  
  
}
