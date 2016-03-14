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
  // int    playedMatches;
  // int    salary;

  // Fantasy Points (actualizado por liveMatchEvent)
  int currentLivePoints = 0;

  int getFantasyPointsForCompetition(String competitionId) {
    List matchsForCompetition = stats.where((stat) => stat.isCurrentSeason(competitionId)).toList();
    return matchsForCompetition.isNotEmpty ? matchsForCompetition.fold(0, (prev, stat) => prev + stat.fantasyPoints ) ~/ matchsForCompetition.length : 0;
  }

  int getPlayedMatchesForCompetition(String competitionId) {
    return stats.where((stat) => stat.isCurrentSeason(competitionId)).length;
  }

  // Estadisticas: Nombre del evento segun el enumerado OptaEventType => puntos obtenidos gracias a ese evento
  Map<String, LiveEventInfo> currentLivePointsPerOptaEvent = new Map<String, LiveEventInfo>();

  List<SoccerPlayerStats> stats = [];

  // Equipo en el que juega
  SoccerTeam soccerTeam;

  bool get hasFullInformation => soccerTeam != null;
  
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
    // playedMatches = jsonMap.containsKey("playedMatches") ? jsonMap["playedMatches"] : 0;
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
    "PASS_SUCCESSFUL"           : StringUtils.translate("successpass", "scoringrules"),
    "PASS_UNSUCCESSFUL"         : StringUtils.translate("unsuccesspass", "scoringrules"),
    "TAKE_ON"                   : StringUtils.translate("takeon", "scoringrules"),
    "FOUL_RECEIVED"             : StringUtils.translate("foulreceived", "scoringrules"),
    "TACKLE"                    : StringUtils.translate("tackle", "scoringrules"),
    "INTERCEPTION"              : StringUtils.translate("interception", "scoringrules"),
    "SAVE_GOALKEEPER"           : StringUtils.translate("save", "scoringrules"),
    "SAVE_PLAYER"               : StringUtils.translate("saveshot", "scoringrules"),
    "CLAIM"                     : StringUtils.translate("claim", "scoringrules"),
    "CLEARANCE"                 : StringUtils.translate("clearance", "scoringrules"),
    "MISS"                      : StringUtils.translate("miss", "scoringrules"),
    "POST"                      : StringUtils.translate("post", "scoringrules"),
    "ATTEMPT_SAVED"             : StringUtils.translate("asaved", "scoringrules"),
    "YELLOW_CARD"               : StringUtils.translate("ycard", "scoringrules"),
    "PUNCH"                     : StringUtils.translate("punch", "scoringrules"),
    "DISPOSSESSED"              : StringUtils.translate("dispossessed", "scoringrules"),
    "ERROR"                     : StringUtils.translate("error", "scoringrules"),
    "DECISIVE_ERROR"            : StringUtils.translate("decisiveerror", "scoringrules"),
    "ASSIST"                    : StringUtils.translate("assist", "scoringrules"),
    "TACKLE_EFFECTIVE"          : StringUtils.translate("tacklecomplete", "scoringrules"),
    "GOAL_SCORED_BY_GOALKEEPER" : StringUtils.translate("goalbygk", "scoringrules"),
    "GOAL_SCORED_BY_DEFENDER"   : StringUtils.translate("goalbydef", "scoringrules"),
    "GOAL_SCORED_BY_MIDFIELDER" : StringUtils.translate("goalbymid", "scoringrules"),
    "GOAL_SCORED_BY_FORWARD"    : StringUtils.translate("goalbyfor", "scoringrules"),
    "OWN_GOAL"                  : StringUtils.translate("owngoal", "scoringrules"),
    "FOUL_COMMITTED"            : StringUtils.translate("foulcommited", "scoringrules"),
    "SECOND_YELLOW_CARD"        : StringUtils.translate("ycard2", "scoringrules"),
    "RED_CARD"                  : StringUtils.translate("rcard", "scoringrules"),
    "CAUGHT_OFFSIDE"            : StringUtils.translate("offside", "scoringrules"),
    "PENALTY_COMMITTED"         : StringUtils.translate("penaltyconceded", "scoringrules"),
    "PENALTY_FAILED"            : StringUtils.translate("penaltyfailed", "scoringrules"),
    "GOALKEEPER_SAVES_PENALTY"  : StringUtils.translate("penaltysaved", "scoringrules"),
    "CLEAN_SHEET"               : StringUtils.translate("clean", "scoringrules"),
    "GOAL_CONCEDED"             : StringUtils.translate("goalconceded", "scoringrules")
  };
}