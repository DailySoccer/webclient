library teams_filter_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/js_utils.dart';



@Component(
    selector: 'teams-filter',
    templateUrl: 'packages/webclient/components/scouting/teams_filter_comp.html',
    useShadowDom: false)
class TeamsFilterComp {
  List<dynamic> _teamList = [];
  bool isTeamsPanelOpen = true;
  
  @NgTwoWay("selected-option")
  String get selectedOption => _selectedOption;
  void   set selectedOption(String val) {
    if (val != _selectedOption) {
      _selectedOption = val;
    }
  }

  @NgOneWay("team-list")
  void set teamList(List<dynamic> teams) {
    _teamList.clear();
    _teamList.add({"id": _ALL_MATCHES, "name": getLocalizedText("all-teams"), "shortName": ''});

    _teamList.addAll(teams);
  }
  
  String idSufix = '';
  @NgOneWay('id-sufix')
  void set identifier(String id) {
    idSufix = id;
  }
  
  
  String get buttonText => getLocalizedText(isTeamsPanelOpen? "hide-teams" : "show-teams");
  List<dynamic> get teamList => _teamList;
  String teamHTML(team) { return "${team['name']}<br>${team['shortName']}"; }
  
  void toggleTeamsPanel() {
    isTeamsPanelOpen = !isTeamsPanelOpen;
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "teamsfilter");
  }
  
  // La idea es esconder ALL_MATCHES aqui dentro. Siempre que seleccionamos ALL_MATCHES desde fuera se vera null.
  String get optionsSelectorValue => selectedOption == null? _ALL_MATCHES : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == _ALL_MATCHES)? null : val;  }

  TeamsFilterComp(this._view);

  bool _togglerEventsInitialized = false;
  View _view;
  static final String _ALL_MATCHES = StringUtils.translate("all", "matchesfilter");
  String _selectedOption;
}