library soccer_player;

import 'package:logging/logging.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player_stats.dart";
//import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';

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
    "PASS_SUCCESSFUL"           : StringUtils.Translate("successpass", "scoringrules"),
    "PASS_UNSUCCESSFUL"         : StringUtils.Translate("unsuccesspass", "scoringrules"),
    "TAKE_ON"                   : StringUtils.Translate("takeon", "scoringrules"),
    "FOUL_RECEIVED"             : StringUtils.Translate("foulreceived", "scoringrules"),
    "TACKLE"                    : StringUtils.Translate("tackle", "scoringrules"),
    "INTERCEPTION"              : StringUtils.Translate("interception", "scoringrules"),
    "SAVE_GOALKEEPER"           : StringUtils.Translate("save", "scoringrules"),
    "SAVE_PLAYER"               : StringUtils.Translate("shaveshot", "scoringrules"),
    "CLAIM"                     : StringUtils.Translate("claim", "scoringrules"),
    "CLEARANCE"                 : StringUtils.Translate("clearance", "scoringrules"),
    "MISS"                      : StringUtils.Translate("miss", "scoringrules"),
    "POST"                      : StringUtils.Translate("post", "scoringrules"),
    "ATTEMPT_SAVED"             : StringUtils.Translate("asaved", "scoringrules"),
    "YELLOW_CARD"               : StringUtils.Translate("ycard", "scoringrules"),
    "PUNCH"                     : StringUtils.Translate("punch", "scoringrules"),
    "DISPOSSESSED"              : StringUtils.Translate("dispossessed", "scoringrules"),
    "ERROR"                     : StringUtils.Translate("error", "scoringrules"),
    "DECISIVE_ERROR"            : StringUtils.Translate("decisiveerror", "scoringrules"),
    "ASSIST"                    : StringUtils.Translate("assist", "scoringrules"),
    "TACKLE_EFFECTIVE"          : StringUtils.Translate("tacklecomplete", "scoringrules"),
    "GOAL_SCORED_BY_GOALKEEPER" : StringUtils.Translate("goalbygk", "scoringrules"),
    "GOAL_SCORED_BY_DEFENDER"   : StringUtils.Translate("goalbydef", "scoringrules"),
    "GOAL_SCORED_BY_MIDFIELDER" : StringUtils.Translate("goalbymid", "scoringrules"),
    "GOAL_SCORED_BY_FORWARD"    : StringUtils.Translate("goalbyfor", "scoringrules"),
    "OWN_GOAL"                  : StringUtils.Translate("owngoal", "scoringrules"),
    "FOUL_COMMITTED"            : StringUtils.Translate("foulcommiter", "scoringrules"),
    "SECOND_YELLOW_CARD"        : StringUtils.Translate("ycard2", "scoringrules"),
    "RED_CARD"                  : StringUtils.Translate("rcard", "scoringrules"),
    "CAUGHT_OFFSIDE"            : StringUtils.Translate("offside", "scoringrules"),
    "PENALTY_COMMITTED"         : StringUtils.Translate("penaltyconceded", "scoringrules"),
    "PENALTY_FAILED"            : StringUtils.Translate("penaltyfailed", "scoringrules"),
    "GOALKEEPER_SAVES_PENALTY"  : StringUtils.Translate("penaltysaved", "scoringrules"),
    "CLEAN_SHEET"               : StringUtils.Translate("clean", "scoringrules"),
    "GOAL_CONCEDED"             : StringUtils.Translate("goalconceded", "scoringrules")
  };
}