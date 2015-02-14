library matches_filter_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';



@Component(
    selector: 'matches-filter',
    templateUrl: 'packages/webclient/components/enter_contest/matches_filter_comp.html',
    useShadowDom: false)
class MatchesFilterComp implements ShadowRootAware {

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

    if (theContest == null) {
      return;
    }

    matchEvents.clear();
    matchEvents.add({"id": _ALL_MATCHES, "texto": "All<br>matches", "textoSelector": "All matches"});

    theContest.matchEvents.forEach((match) => _addMatchEvent(match));
    runAnimation();
  }

  @override onShadowRoot(emulatedRoot) {
    runAnimation();
  }

  void runAnimation() {
    if (srcDet.isDesktop && matchEvents.length > 1) {
      _view.domRead(() {
        var filterButtons = querySelector(".matches-filter-buttons");

        if (filterButtons != null && !filterButtons.classes.contains("animate-once")) {
          filterButtons.classes.add("animate animate-once");

          // No queremos que cuando cambiemos de tab, vuelva a animar
          filterButtons.on["animationend"].listen((data) {
            filterButtons = querySelector(".matches-filter-buttons");

            if (filterButtons != null) {
              filterButtons.classes.remove("animate");
            }
          });
        }
      });
    }
  }

  Map _addMatchEvent(MatchEvent match) {
    var ret = {"id": match.templateMatchEventId,
               "texto": match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate),
               "textoSelector": match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName};

    matchEvents.add(ret);

    return ret;
  }

  // La idea es esconder ALL_MATCHES aqui dentro. Siempre que seleccionamos ALL_MATCHES desde fuera se vera null.
  String get optionsSelectorValue => selectedOption == null? _ALL_MATCHES : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == _ALL_MATCHES)? null : val;  }

  MatchesFilterComp(this.srcDet, this._view);

  View _view;
  static final String _ALL_MATCHES = "all";
  String _selectedOption;
}