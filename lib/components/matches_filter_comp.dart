library matches_filter_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';


@Component(
    selector: 'matches-filter',
    templateUrl: 'packages/webclient/components/matches_filter_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class MatchesFilterComp {

  final String ALL_MATCHES = "all";

  List<Map<String, String>> availableMatchEvents = [];
  List<Map<String, String>> availableMatchEventsSelect = [];

  @NgTwoWay("selected-option")
  String get selectedOption => _selectedOption;
  void   set selectedOption(String val) {
    if (val != _selectedOption) {
      _selectedOption = val;
      _setMatchFilterClass(_selectedOption);
    }
  }

  @NgOneWay("contest")
  void set contest(Contest theContest) {

    availableMatchEvents.clear();
    availableMatchEventsSelect.clear();

    if (theContest == null) {
      return;
    }

    for (MatchEvent match in theContest.matchEvents) {
      availableMatchEvents.add({"id": match.templateMatchEventId,
                                "texto": match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate)
                               });
    }

    availableMatchEventsSelect.add({"id": ALL_MATCHES, "texto": "Todos los partidos"});
    for (MatchEvent match in theContest.matchEvents) {
      availableMatchEventsSelect.add({"id": match.templateMatchEventId, "texto": match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName});
    }
  }

  void _setMatchFilterClass(String buttonId) {

    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-team");
    buttonsFilter.forEach((element) {
      element.classes.remove('active');
    });

    List<ButtonElement> button = querySelectorAll("#match-$buttonId");
    button.forEach((element) => element.classes.add("active"));
  }

  String _selectedOption;
}