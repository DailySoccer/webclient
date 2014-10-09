library soccer_player;

import "package:json_object/json_object.dart";
import 'package:logging/logging.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player_stats.dart";
//import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  // FieldPos fieldPos;
  int    fantasyPoints;
  int    playedMatches;
  // int    salary;

  // Fantasy Points (actualizado por liveMatchEvent)
  int currentLivePoints = 0;

  // Estadisticas: Nombre del evento segun el enumerado OptaEventType => puntos obtenidos gracias a ese evento
  Map<String, int> currentLivePointsPerOptaEvent = new Map<String, int>();

  List<SoccerPlayerStats> stats = [];

  // Equipo en el que juega
  SoccerTeam soccerTeam;

  SoccerPlayer.referenceInit(this.templateSoccerPlayerId);

  factory SoccerPlayer.fromJsonObject(JsonObject json, ContestReferences references) {
    SoccerPlayer soccerPlayer = references.getSoccerPlayerById(json.containsKey("templateSoccerPlayerId") ? json.templateSoccerPlayerId : json._id);
    return soccerPlayer._initFromJsonObject(json, references);
  }

  SoccerPlayer _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateSoccerPlayerId.isNotEmpty);
    name = json.containsKey("name") ? json.name : "";
    // fieldPos = json.containsKey("fieldPos") ? new FieldPos(json.fieldPos) : null;
    fantasyPoints = json.containsKey("fantasyPoints") ? json.fantasyPoints : 0;
    playedMatches = json.containsKey("playedMatches") ? json.playedMatches : 0;
    // salary = json.containsKey("salary") ? json.salary : 0;

    if (json.containsKey("stats")) {
      stats = [];
      for (var x in json.stats) {
        stats.add(new SoccerPlayerStats.fromJsonObject(x, references));
      }
    }

    soccerTeam = references.getSoccerTeamById(json.templateTeamId);
    soccerTeam.addSoccerPlayer(this);
    return this;
  }

  static String getEventName(String key) {
    if (!_EVENT_KEY_TO_NAME.containsKey(key)) {
      Logger.root.severe("soccer_player:getEventName:$key invalid");
      return key;
    }
    return _EVENT_KEY_TO_NAME[key];
  }

  static final Map<String, String> _EVENT_KEY_TO_NAME = {
    "PASS_SUCCESSFUL"   : "Pase completado",
    "PASS_UNSUCCESSFUL" : "Pase no completado",
    "TAKE_ON"           : "Regate",
    "FOUL_RECEIVED"     : "Falta recibida",
    "TACKLE"            : "Entrada",
    "INTERCEPTION"      : "Intercepción",
    "SAVE_GOALKEEPER"   : "Parada",
    "SAVE_PLAYER"       : "Disparo defendido",
    "CLAIM"             : "Anticipación",
    "CLEARANCE"         : "Despeje",
    "MISS"              : "Disparo fuera",
    "POST"              : "Poste",
    "ATTEMPT_SAVED"     : "Disparo a puerta",
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
    "GOALKEEPER_SAVES_PENALTY"  : "Penalti parado",
    "CLEAN_SHEET"       : "Sin goles encajados",
    "GOAL_CONCEDED"     : "Gol encajado"
  };
}