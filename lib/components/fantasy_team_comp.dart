library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';
import 'dart:async';
import 'dart:math';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    List<dynamic> slots = null;

    String get owner => isOpponent? "opponent" : "me";

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {
      // Si nos mandan cambiar de ContestEntry, tenemos que resetear los slots
      if (_contestEntry != value)
        slots = null;

      _contestEntry = value;
      _refreshTeam();
    }

    @NgOneWay("watch")
    set watch(dynamic value) {
      _refreshTeam();
    }

    @NgOneWay("is-opponent")
    bool isOpponent = false;

    @NgOneWay("show-close-button")
    bool showCloseButton = false;

    @NgCallback('on-close')
    Function onClose;

    String get userPosition => (_contestEntry != null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft} min." : "-";

    FantasyTeamComp(this._viewContestCtrl);

    void onShadowRoot(var shadowRoot) {
      _rootElement = shadowRoot as HtmlElement;
    }

    void _refreshTeam() {
      if (_rootElement == null || _contestEntry == null)
        return;

      if (slots == null) {
        _createSlots();
      }
      else {
        _refreshSlots();
      }
    }

    void _createSlots() {

      slots = new List<dynamic>();

      _contestEntry.soccers.forEach((soccerPlayer) {
        String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
        String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
        var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)?
                             "<strong>$shortNameTeamA</strong> - $shortNameTeamB" :
                             "$shortNameTeamA - <strong>$shortNameTeamB<strong>";

        slots.add({
            "id" : soccerPlayer.templateSoccerPlayerId,
            "fieldPos": soccerPlayer.fieldPos,
            "fullName": soccerPlayer.name,
            "matchEventName": matchEventName,
            "percentOfUsersThatOwn": _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer),
            "score": soccerPlayer.printableCurrentLivePoints,
            "stats": soccerPlayer.printableLivePointsPerOptaEvent
        });
      });
    }

    void _refreshSlots() {

      var random = new Random();

      _contestEntry.soccers.forEach((soccerPlayer) {

        // Para el score refrescamos solo el texto y lanzamos una animacion (fade-in/out por ejemplo)
        Element scoreElement = _rootElement.querySelector("[data-id='${soccerPlayer.templateSoccerPlayerId}'] .column-score span");

        if (scoreElement != null && scoreElement.innerHtml != soccerPlayer.printableCurrentLivePoints) {

          // Un pequeño efecto visual: como que nos vienen unas antes que otras
          int startDelay = random.nextInt(4000);

          new Timer(new Duration(milliseconds: startDelay), () {
            scoreElement.innerHtml = soccerPlayer.printableCurrentLivePoints;

            // Refrescamos el array completo de stats. A medida que lleguen nuevas stats se iran rellenando nuevas rows.
            slots.firstWhere((slot) => slot['id'] == soccerPlayer.templateSoccerPlayerId)["stats"] = soccerPlayer.printableLivePointsPerOptaEvent;

            scoreElement.classes.add("changed");
            new Timer(new Duration(seconds: 1), () => scoreElement.classes.remove("changed"));
          });
        }
      });
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;

    ContestEntry _contestEntry;
    ViewContestCtrl _viewContestCtrl;

    String _mode;

    Map collapsables = {};

    final Map<String, String> eventKeyToName = {
      "PASS_SUCCESSFUL"   : "Pase completado",
      "PASS_UNSUCCESSFUL" : "Pase no completado",
      "TAKE_ON"           : "Regate",
      "FOUL_RECEIVED"     : "Falta recibida",
      "TACKLE"            : "Entrada",
      "INTERCEPTION"      : "Intercepción",
      "SAVE"              : "Parada",
      "CLAIM"             : "Anticipación",
      "CLEARANCE"         : "Despeje",
      "MISS"              : "Disparo fallado",
      "POST"              : "Disparo al poste",
      "ATTEMPT_SAVED"     : "Disparo detenido por el contrario",
      "YELLOW_CARD"       : "Tarjeta amarilla",
      "PUNCH"             : "Despeje de puño",
      "DISPOSSESSED"      : "Pérdida de balón",
      "ERROR"             : "Error",
      "ASSIST"            : "Asistencia",
      "TACKLE_EFFECTIVE"  : "Entrada exitosa",
      "GOAL_SCORED_BY_GOALKEEPER" : "Gol",
      "GOAL_SCORED_BY_DEFENDER"   : "Gol",
      "GOAL_SCORED_BY_MIDFIELDER" : "Gol",
      "GOAL_SCORED_BY_FORWARD"    : "Gol",
      "OWN_GOAL"          : "Gol en propia meta",
      "FOUL_COMMITTED"    : "Falta cometida",
      "SECOND_YELLOW_CARD": "Segunda tarjeta amarilla",
      "RED_CARD"          : "Tarjeta roja",
      "CAUGHT_OFFSIDE"    : "Fuera de juego",
      "PENALTY_COMMITTED" : "Penalti cometido",
      "PENALTY_FAILED"    : "Penalti fallado",
      "GOALKEEPER_SAVES_PENALTY"  : "Penalti detenido",
      "CLEAN_SHEET"       : "Sin goles encajados",
      "GOAL_CONCEDED"     : "Gol concedido"
    };

}
