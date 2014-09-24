library soccer_player;

import "package:json_object/json_object.dart";
import 'package:logging/logging.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  FieldPos fieldPos;
  int    fantasyPoints;
  int    playedMatches;
  int    salary;

  // Fantasy Points (actualizado por liveMatchEvent)
  int currentLivePoints = 0;
  String get printableCurrentLivePoints => (team.matchEvent.isStarted) ? currentLivePoints.toString() : "-";

  // Estadisticas: Nombre del evento segun el enumerado OptaEventType => puntos obtenidos gracias a ese evento
  Map<String, int> currentLivePointsPerOptaEvent = new Map<String, int>();

  List<Map> get printableLivePointsPerOptaEvent {
    List<Map> stats = new List<Map>();
    currentLivePointsPerOptaEvent.forEach((key, value) => stats.add({'name': getEventName(key), 'points': value}));
    stats.sort((elem0, elem1) => elem0["name"].compareTo(elem1["name"]) );
    return stats;
  }

  // Equipo en el que juega
  SoccerTeam team;

  SoccerPlayer.referenceInit(this.templateSoccerPlayerId);

  factory SoccerPlayer.fromJsonObject(JsonObject json, ContestReferences references) {
    SoccerPlayer soccerPlayer = references.getSoccerPlayerById(json.templateSoccerPlayerId);
    return soccerPlayer._initFromJsonObject(json, references);
  }

  SoccerPlayer _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateSoccerPlayerId.isNotEmpty);
    name = json.containsKey("name") ? json.name : "";
    fieldPos = json.containsKey("fieldPos") ? new FieldPos(json.fieldPos) : null;
    fantasyPoints = json.containsKey("fantasyPoints") ? json.fantasyPoints : 0;
    playedMatches = json.containsKey("playedMatches") ? json.playedMatches : 0;
    salary = json.containsKey("salary") ? json.salary : 0;
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
    "SAVE_PLAYER"       : "Bloquea un disparo",
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