library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    var slots = new List();

    String get owner => isOpponent? "opponent" : "me";

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {
      _contestEntry = value;
      if (value != null)
        _refreshTeam();
    }

    @NgOneWay("watch")
    set watch(dynamic value) {
      backUpStatistics();
      _refreshTeam();
    }

    @NgOneWay("is-opponent")
    bool isOpponent = false;

    @NgOneWay("show-close-button")
    bool showCloseButton = false;

    @NgCallback('on-close')
    Function onClose;

    String soccerPlayerIdModal;
    dynamic soccerPlayerEventsModal;

    String get userPosition => (_contestEntry != null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft} min." : "-";

    FantasyTeamComp(this._viewContestCtrl);

    // A pesar de que useShadowDom es false, sigue llegando este mensaje y es el primer momento donde podemos hacer un querySelector.
    // Hemos probado attach y el constructor, pero alli parece que todavia no estan creados los hijos. Tiene que ser var y no ShadowRoot
    // pq nos esta llegando un HtmlElement (es logico puesto que useShadowRoot es false)
    void onShadowRoot(var shadowRoot) {
      _rootElement = shadowRoot as HtmlElement;
    }

    void _refreshTeam() {
      slots.clear();

      if (_contestEntry != null) {
        //TODO: actualizar los datos de la lista de slots, sin recrearla de nuevo. Buscar los jugadores y actualizar buscandolo por ID.

        _contestEntry.soccers.forEach((soccerPlayer) {
          String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
          String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
          var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
              ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
              : "$shortNameTeamA - <strong>$shortNameTeamB<strong>";

          List<Map> soccerPlayerStats = [];

          soccerPlayer.eventLivePoints.forEach((key,value) {
            if (eventKeyToName.containsKey(key)) {
              soccerPlayerStats.add({'name':eventKeyToName[key], 'points':value});
            }
            else {
              soccerPlayerStats.add({'name':"???", 'points':value});
            }
          });

          slots.add({
              "id" : soccerPlayer.templateSoccerPlayerId,
              "fieldPos": soccerPlayer.fieldPos,
              "fullName": soccerPlayer.name,
              "matchEventName": matchEventName,
              "percentOfUsersThatOwn": _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer),
              "score": (soccerPlayer.team.matchEvent.isStarted) ? soccerPlayer.currentLivePoints : "-",
              "stats": soccerPlayerStats
          });

          // Actualizar los datos que ofrecemos en la ventana Modal
          if (soccerPlayer.templateSoccerPlayerId == soccerPlayerIdModal) {
            soccerPlayerEventsModal = soccerPlayerStats;
          }
        });
      }
    }

    void backUpStatistics() {
      collapsables.clear();
      var coll = document.getElementsByClassName('soccer-player-statistics collapse');
      coll.forEach((Element element) {
        var classes = element.classes.toString();
        var style = element.style;
        var id = element.id;

        Map css = { id : {"classes" : classes.toString(), "height" : style.height} };
        collapsables.addAll(css);
      });
    }

    String restoreStatisticsCss(String id) {
      String retorno = "";
      if (collapsables.isNotEmpty) {
        Map css = collapsables[id];
        if (css != null){
          if (css["classes"] != null) {
            retorno =  css["classes"];
          }
        }
      }
      return retorno;
    }


    void onRow(dynamic soccerPlayerData) {}

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;

    ContestEntry _contestEntry;
    ViewContestCtrl _viewContestCtrl;

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
      "POST"              : "Poste",
      "ATTEMPT_SAVED"     : "Disparo detenido",
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
