library matches_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'dart:async';


@Component(
    selector: 'matches-filter',
    templateUrl: 'packages/webclient/components/enter_contest/matches_filter_comp.html',
    useShadowDom: false)
class MatchesFilterComp {

  ScreenDetectorService srcDet;
  List<Map<String, String>> matchEvents = [];

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
    matchEvents.add({"id": _ALL_MATCHES, "texto": "Todos los<br>partidos", "textoSelector": "Todos los partidos", "isTransparent": false});

    if (theContest == null) {
      return;
    }

    int timeDelay = 300;
    for (MatchEvent match in theContest.matchEvents) {
      var dynamicMatch = {"id": match.templateMatchEventId,
                          "texto": match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate),
                          "textoSelector": match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName,
                          "isTransparent": !srcDet.isXsScreen};

      matchEvents.add(dynamicMatch);

      // En Xs se pinta el selector en vez de los botones, asi que como no queremos cargar el movil evitamos los timers con este if
      if (!srcDet.isXsScreen) {
        new Timer(new Duration(milliseconds: timeDelay), () => dynamicMatch["isTransparent"] = false);
        timeDelay += 300;
      }
    }
  }

  // La idea es esconder ALL_MATCHES aqui dentro. Siempre que seleccionamos ALL_MATCHES desde fuera se vera null.
  String get optionsSelectorValue => selectedOption == null? _ALL_MATCHES : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == _ALL_MATCHES)? null : val;  }

  MatchesFilterComp(this.srcDet);

  static final String _ALL_MATCHES = "all";
  String _selectedOption;
}