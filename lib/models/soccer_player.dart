library soccer_player;

import 'package:logging/logging.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player_stats.dart";
//import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';

class LiveEventInfo {
  int count;
  int points;

  LiveEventInfo.initFromJsonObject(Map jsonMap) {
    count = jsonMap["count"];
    points = jsonMap["points"];
  }
}

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  // FieldPos fieldPos;
  int    fantasyPoints;
  int    playedMatches;
  // int    salary;

  // Fantasy Points (actualizado por liveMatchEvent)
  int currentLivePoints = 0;

  int getFantasyPointsForCompetition(String competitionId) {
    List matchsForCompetition = stats.where((stat) => stat.hasPlayedInCompetition(competitionId)).toList();
    return matchsForCompetition.isNotEmpty ? matchsForCompetition.fold(0, (prev, stat) => prev + stat.fantasyPoints ) ~/ matchsForCompetition.length : 0;
  }

  int getPlayedMatchesForCompetition(String competitionId) {
    return stats.where((stat) => stat.hasPlayedInCompetition(competitionId)).length;
  }

  // Estadisticas: Nombre del evento segun el enumerado OptaEventType => puntos obtenidos gracias a ese evento
  Map<String, LiveEventInfo> currentLivePointsPerOptaEvent = new Map<String, LiveEventInfo>();

  List<SoccerPlayerStats> stats = [];

  // Equipo en el que juega
  SoccerTeam soccerTeam;

  SoccerPlayer.referenceInit(this.templateSoccerPlayerId);

  factory SoccerPlayer.fromJsonObject(Map jsonMap, ContestReferences references) {
    SoccerPlayer soccerPlayer = references.getSoccerPlayerById(jsonMap.containsKey("templateSoccerPlayerId") ? jsonMap["templateSoccerPlayerId"] : jsonMap["_id"]);
    return soccerPlayer._initFromJsonObject(jsonMap, references);
  }

  SoccerPlayer _initFromJsonObject(Map jsonMap, ContestReferences references) {
    assert(templateSoccerPlayerId.isNotEmpty);
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    // fieldPos = jsonMap.containsKey("fieldPos") ? new FieldPos(json["fieldPos"]) : null;
    fantasyPoints = jsonMap.containsKey("fantasyPoints") ? jsonMap["fantasyPoints"] : 0;
    playedMatches = jsonMap.containsKey("playedMatches") ? jsonMap["playedMatches"] : 0;
    // salary = jsonMap.containsKey("salary") ? jsonMap["salary"] : 0;

    if (jsonMap.containsKey("stats")) {
      stats = [];
      for (var x in jsonMap["stats"]) {
        stats.add(new SoccerPlayerStats.fromJsonObject(x, references));
      }
      // Eliminar las estadísticas vacías
      stats.removeWhere((stat) => !stat.hasPlayed());
    }

    soccerTeam = references.getSoccerTeamById(jsonMap["templateTeamId"]);
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
    "POST"              : "Disparo al poste",
    "ATTEMPT_SAVED"     : "Disparo a puerta",
    "YELLOW_CARD"       : "Tarjeta amarilla",
    "PUNCH"             : "Despeje de puño",
    "DISPOSSESSED"      : "Pérdida de balón",
    "ERROR"             : "Error",
    "DECISIVE_ERROR"    : "Error grave",
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