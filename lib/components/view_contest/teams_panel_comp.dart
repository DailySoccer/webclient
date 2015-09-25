library teams_panel_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/soccer_team.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'teams-panel',
    templateUrl: 'packages/webclient/components/view_contest/teams_panel_comp.html',
    useShadowDom: false
)
class TeamsPanelComp implements DetachAware {
  List<String> matchesInvolved = [];
  List<MatchEvent> matchEventsSorted = [];

  ScreenDetectorService scrDet;

  @NgOneWay("contest")
  Contest get contest => _contest;
  void set contest(Contest value) {
    if (value != null) {
      _contest = value;
      generateMatchesList();
    }
  }

  // Cuando nos pasan el contestId, ya podemos empezar a mostrar informacion antes de que quien sea (enter_contest, view_contest...)
  // refresque su informacion de concurso (que siempre es mas completa que muchas (o todas) las cosas que necesitamos mostrar aqui)
  @NgOneWay("contest-id")
  void set contestId(String value) {
    if (value != null) {
      _contestId = value;
      _contest = _contestsService.getContestById(value);
      generateMatchesList();
    }
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "teamspanel");
  }

  TeamsPanelComp(this.scrDet, this._contestsService, this._routeProvider) {
    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);
  }

  /** Methods **/
  void generateMatchesList() {
    if(contest == null) {
      return;
    }

    matchesInvolved.clear();
    matchEventsSorted = new List<MatchEvent>.from(contest.matchEvents)
      .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
      .. forEach( (match) {
        matchesInvolved.add('''<span> ${match.soccerTeamA.shortName} </span> <div class="score-wrapper">@scoreTeamA</div><span> - </span><div class="score-wrapper">@scoreTeamB</div><span> ${match.soccerTeamB.shortName} </span>''');
     });
  }

  String getMatchAndPeriodInfo(int id) {
    if (matchEventsSorted == null || matchEventsSorted.isEmpty) {
      return '';
    }

    String content = "";
    MatchEvent match = matchEventsSorted[id];
    if(contest.state == "LIVE") {
      if (match != null) {
        if (match.isStarted) {
          if (match.isFinished) {
            content = getLocalizedText("finished");
          }
          else {
            content = (match.isFirstHalf ? getLocalizedText("firsthalf") : match.isSecondHalf ? getLocalizedText("secondhalf") : getLocalizedText("error")) + match.minutesPlayed.toString() + "'";
          }
        }
      }
    }

    String teamsAndScores;
    teamsAndScores = matchesInvolved[id].replaceAll("@scoreTeamA", getTeamScore(match.soccerTeamA));
    //teamsAndScores = match.soccerTeamA.score > -1 ? teamsAndScores.replaceAll("@separator", " - ") : teamsAndScores.replaceAll("@separator", "");
    teamsAndScores = teamsAndScores.replaceAll("@scoreTeamB", ' ' + getTeamScore(match.soccerTeamB));

    String infoBox = teamsAndScores + '''<br>''' + (content != "" ?  "<div class=period>${content}</div>" : '''<div class="match-date"> ${DateTimeService.formatDateTimeShort(match.startDate)}</div>''');

    return infoBox;
  }

  String getTeamScore(SoccerTeam team) {
     return team.score >= 0 ? '''<span class="team-score">${team.score.toString()}</span>''' : '';
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
  RouteProvider _routeProvider;

  ContestsService _contestsService;
}