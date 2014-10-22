library matches_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';


@Component(
    selector: 'matches-filter',
    templateUrl: 'packages/webclient/components/enter_contest/matches_filter_comp.html',
    useShadowDom: false
)
class MatchesFilterComp {

  final String ALL_MATCHES = "all";

  List<Map<String, String>> matchEvents = [];

  String getClassForMatchId(String matchId) => optionsSelectorValue == matchId? "active" : "";

  @NgTwoWay("selected-option")
  String get selectedOption => _selectedOption;
  void   set selectedOption(String val) {
    if (val != _selectedOption) {
      _selectedOption = val;
    }
  }

  @NgOneWay("contest")
  void set contest(Contest theContest) {

    matchEvents.clear();

    if (theContest == null) {
      return;
    }

    matchEvents.add({"id": ALL_MATCHES, "texto": "Todos los<br>partidos", "textoSelector": "Todos los partidos"});

    for (MatchEvent match in theContest.matchEvents) {
      matchEvents.add({"id": match.templateMatchEventId,
                       "texto": match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate),
                       "textoSelector": match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName
                      });
    }
  }

  // La idea es esconder ALL_MATCHES aqui dentro. Siempre que seleccionamos ALL_MATCHES desde fuera se vera null.
  String get optionsSelectorValue => selectedOption == null? ALL_MATCHES : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == ALL_MATCHES)? null : val;  }

  String _selectedOption;
}