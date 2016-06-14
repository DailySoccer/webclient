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

  AppTopBarStateConfig get currentState => _appStateService.appTopBarState.activeState;
  Map get configParameters => _appStateService.appTopBarState.configParameters;
  
  String get layoutCssClass => currentState.layout == AppTopBarState.THREE_COLUMNS ? "three-columns" :
                               currentState.layout == AppTopBarState.ONE_COLUMN ? "one-column" : "hidden-bar";
  
  String get leftColumnHTML => currentState.layout == AppTopBarState.THREE_COLUMNS ? _getHtmlModule(currentState.elements[0]) : '';
  String get centerColumnHTML => currentState.layout == AppTopBarState.NONE_COLUMNS? '' : _getHtmlModule(currentState.elements[currentState.layout == AppTopBarState.THREE_COLUMNS? 1 : 0]);
  String get rightColumnHTML => currentState.layout == AppTopBarState.THREE_COLUMNS ? _getHtmlModule(currentState.elements[2]) : '';
  
  TopBarComp(this._appStateService) {}

  // LAYOUT ELEMENTS
  String _backButton([String clas = ""]) {
    return "<button class='back-button $clas'>BACK</button>";
  }
  String _titleLabel([String clas = ""]) {
    return "<div class='title-label $clas'>${configParameters["title"]}</div>";
  }
  String _empty([String clas = ""]) {
    return "<div class='empty-element $clas'></div>";
  }
  String _userCurrencies([String clas = ""]) {
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
  String _createContestButton([String clas = ""]) {
    return "<button class='create-contest $clas'>( + )</button>";
  }
  String _liveContestButton([String clas = ""]) {
    return "<button class='live-contest $clas'>Y</button>";
  }
  
  String _getHtmlModule(String s) {
    Map<String, Function> modules = { AppTopBarState.CREATE_CONTEST_BUTTON: _createContestButton,
                                      AppTopBarState.LIVE_CONTESTS: _liveContestButton,
                                      AppTopBarState.BACK_BUTTON: _backButton,
                                      AppTopBarState.USER_CURRENCIES: _userCurrencies,
                                      AppTopBarState.TITLE_LABEL: _titleLabel,
                                      AppTopBarState.EMPTY: _empty
                                    };
    
    return modules[s]();
  }
  AppStateService _appStateService;
  
}
