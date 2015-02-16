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
    "PASS_SUCCESSFUL"   : "Successful pass",
    "PASS_UNSUCCESSFUL" : "Unsuccessful pass",
    "TAKE_ON"           : "Take-on",
    "FOUL_RECEIVED"     : "Foul received",
    "TACKLE"            : "Tackle",
    "INTERCEPTION"      : "Interception",
    "SAVE_GOALKEEPER"   : "Save",
    "SAVE_PLAYER"       : "Saved shot",
    "CLAIM"             : "Anticipation",
    "CLEARANCE"         : "Clearance",
    "MISS"              : "Missed shot",
    "POST"              : "Post",
    "ATTEMPT_SAVED"     : "Attempted shot",
    "YELLOW_CARD"       : "Yellow Card",
    "PUNCH"             : "Punch",
    "DISPOSSESSED"      : "Dispossessed",
    "ERROR"             : "Error",
    "DECISIVE_ERROR"    : "Decisive Error",
    "ASSIST"            : "Assist",
    "TACKLE_EFFECTIVE"  : "Tackle effective",
    "GOAL_SCORED_BY_GOALKEEPER" : "Goal",
    "GOAL_SCORED_BY_DEFENDER"   : "Goal",
    "GOAL_SCORED_BY_MIDFIELDER" : "Goal",
    "GOAL_SCORED_BY_FORWARD"    : "Goal",
    "OWN_GOAL"          : "Own Goal",
    "FOUL_COMMITTED"    : "Foul committed",
    "SECOND_YELLOW_CARD": "Second Yellow Card",
    "RED_CARD"          : "Red Card",
    "CAUGHT_OFFSIDE"    : "Offside",
    "PENALTY_COMMITTED" : "Penalty committed",
    "PENALTY_FAILED"    : "Penalty failed",
    "GOALKEEPER_SAVES_PENALTY"  : "Penalty saved",
    "CLEAN_SHEET"       : "Clean sheet",
    "GOAL_CONCEDED"     : "Goal Conceded"
  };
}