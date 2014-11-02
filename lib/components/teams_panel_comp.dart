library teams_panel_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/active_contests_service.dart';

@Component(
    selector: 'teams-panel',
    templateUrl: 'packages/webclient/components/teams_panel_comp.html',
    useShadowDom: false
)
class TeamsPanelComp implements DetachAware {
  List<String> matchesInvolved = [];
  List<MatchEvent> matchEventsSorted = [];

  ScreenDetectorService scrDet;

  @NgOneWay('collapsable')
  bool get isCollapsable => _collapsable;
  void set isCollapsable(bool value) {
    _collapsable = value;

    if(_collapsable && _isTeamsPanelOpen) {
      toggleTeamsPanel();
    }
  }

  @NgOneWay("contest")
  Contest get contest => _contest;
  void set contest(Contest value) {
    if (value != null) {
      if(_contestId == value.contestId) {
        _contest = value;
        generateMatchesList();
      }
    }
  }

  // Cuando nos pasan el contestId, ya podemos empezar a mostrar informacion antes de que quien sea (enter_contest, view_contest...)
  // refresque su informacion de concurso (que siempre es mas completa que muchas (o todas) las cosas que necesitamos mostrar aqui)
  @NgOneWay("contest-id")
  void set contestId(String value) {
    if (value != null) {
      _contestId = value;
      _contest = _activeContestsService.getContestById(value);
      generateMatchesList();
    }
  }

  TeamsPanelComp(this.scrDet, this._activeContestsService) {
    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);
  }

  /** Methods **/
  void generateMatchesList() {
    if(contest == null) {
      return;
    }

    // generamos los partidos para el filtro de partidos
    matchesInvolved.clear();
    matchEventsSorted = new List<MatchEvent>.from(contest.matchEvents)
    .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
    .. forEach( (match) {
      matchesInvolved.add(match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName +
      "<br>" + DateTimeService.formatDateTimeShort(match.startDate) + "<br>");
   });
  }

  String getMatchAndPeriodInfo(int id, String teamsInfo) {
    if (matchEventsSorted == null || matchEventsSorted.isEmpty) {
      return '';
    }

    String content = "";
    MatchEvent match = matchEventsSorted[id];

    if (match != null) {
      if (!match.isStarted) {
        content = 'No jugado';
      }
      else {
        if (match.isFinished) {
          content = 'Finalizado';
        }
        else {
          content = (match.isFirstHalf ? '1ª Parte - ' : match.isSecondHalf ? '2ª Parte - ' : '-Err-') + match.minutesPlayed.toString() + "'";
        }
      }
    }

    return "${teamsInfo}<div class=period>${content}</div>";
  }

  void toggleTeamsPanel() {
    if (!_togglerEventsInitialized) {
      JsUtils.runJavascript('#teamsPanel', 'on', {'shown.bs.collapse': onOpenTeamsPanel});
      JsUtils.runJavascript('#teamsPanel', 'on', {'hidden.bs.collapse': onCloseTeamsPanel});
      _togglerEventsInitialized = true;
    }

    // Abrimos el menú si está cerrado
    if (_isTeamsPanelOpen) {
      JsUtils.runJavascript('#teamsPanel', 'collapse', "hide");
    }
    else {
      JsUtils.runJavascript('#teamsPanel', 'collapse', "show");
    }
  }

  /** Handlers **/
  // Handle que recibe cual es la nueva mediaquery que se aplica.
  void onScreenWidthChange(String msg) {
    if (msg == "xs") {
      _togglerEventsInitialized = false;
    }
  }

  void detach() {
    _streamListener.cancel();
  }

  void onOpenTeamsPanel(dynamic sender) {
    _isTeamsPanelOpen = true;
    querySelector('#teamsToggler').classes.remove('toggleOff');
    querySelector('#teamsToggler').classes.add('toggleOn');
  }

  void onCloseTeamsPanel(dynamic sender) {
    _isTeamsPanelOpen = false;
    querySelector('#teamsToggler').classes.remove('toggleOn');
    querySelector('#teamsToggler').classes.add('toggleOff');

  }

  bool _isTeamsPanelOpen  = false;
  bool _togglerEventsInitialized = false;
  var _streamListener;
  Contest _contest;
  String _contestId = '';
  bool _collapsable = false;

  ActiveContestsService _activeContestsService;
}