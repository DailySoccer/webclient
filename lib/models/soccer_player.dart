library soccer_player;

import 'package:logging/logging.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player_stats.dart";
//import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/localization.dart';

class LiveEventInfo {
  int count;
  int points;

  LiveEventInfo.initFromJsonObject(Map jsonMap) {
    count = jsonMap["count"];
    points = jsonMap["points"];
  }
}

class SoccerPlayer {
  static Localization get T => Localization.instance;

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
    "PASS_SUCCESSFUL"   : T.eventPassSuccessful,
    "PASS_UNSUCCESSFUL" : T.eventPassUnsuccessful,
    "TAKE_ON"           : T.eventTakeOn,
    "FOUL_RECEIVED"     : T.eventFoulReceived,
    "TACKLE"            : T.eventTackle,
    "INTERCEPTION"      : T.eventInterception,
    "SAVE_GOALKEEPER"   : T.eventSaveGoalkeeper,
    "SAVE_PLAYER"       : T.eventSavePlayer,
    "CLAIM"             : T.eventClaim,
    "CLEARANCE"         : T.eventClearance,
    "MISS"              : T.eventMiss,
    "POST"              : T.eventPost,
    "ATTEMPT_SAVED"     : T.eventAttemptSaved,
    "YELLOW_CARD"       : T.eventYellowCard,
    "PUNCH"             : T.eventPunch,
    "DISPOSSESSED"      : T.eventDispossessed,
    "ERROR"             : T.eventError,
    "DECISIVE_ERROR"    : T.eventDecisiveError,
    "ASSIST"            : T.eventAssist,
    "TACKLE_EFFECTIVE"  : T.eventTackleEffective,
    "GOAL_SCORED_BY_GOALKEEPER" : T.eventGoal,
    "GOAL_SCORED_BY_DEFENDER"   : T.eventGoal,
    "GOAL_SCORED_BY_MIDFIELDER" : T.eventGoal,
    "GOAL_SCORED_BY_FORWARD"    : T.eventGoal,
    "OWN_GOAL"          : T.eventOwnGoal,
    "FOUL_COMMITTED"    : T.eventFoulCommitted,
    "SECOND_YELLOW_CARD": T.eventSecondYellowCard,
    "RED_CARD"          : T.eventRedCard,
    "CAUGHT_OFFSIDE"    : T.eventCaughtOffside,
    "PENALTY_COMMITTED" : T.eventPenaltyCommitted,
    "PENALTY_FAILED"    : T.eventPenaltyFailed,
    "GOALKEEPER_SAVES_PENALTY"  : T.eventGoalkeeperSavesPenalty,
    "CLEAN_SHEET"       : T.eventCleanSheet,
    "GOAL_CONCEDED"     : T.eventGoalConceded
  };
}