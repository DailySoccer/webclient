library instance_soccer_player;

import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';

class InstanceSoccerPlayer {
  SoccerPlayer soccerPlayer;
  SoccerTeam soccerTeam;

  FieldPos fieldPos;
  int salary;

  String get id => soccerPlayer.templateSoccerPlayerId;

  String get printableCurrentLivePoints => (soccerTeam.matchEvent.isStarted) ? StringUtils.parseFantasyPoints(soccerPlayer.currentLivePoints) : "-";

  List<Map> get printableLivePointsPerOptaEvent {
    List<Map> stats = new List<Map>();
    soccerPlayer.currentLivePointsPerOptaEvent.forEach((key, LiveEventInfo value) => stats.add({'name': SoccerPlayer.getEventName(key), 'count': value.count, 'points': StringUtils.parseFantasyPoints(value.points)}));
    stats.sort((elem0, elem1) => elem0["name"].compareTo(elem1["name"]) );
    return stats;
  }

  InstanceSoccerPlayer.initFromJsonObject(Map jsonMap, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(jsonMap["templateSoccerPlayerId"]);
    fieldPos = jsonMap.containsKey("fieldPos") ? new FieldPos(StringUtils.translate(jsonMap["fieldPos"].toString().toLowerCase(), "soccerplayerpositions")) : null;
    salary = jsonMap.containsKey("salary") ? jsonMap["salary"] : 0;
    soccerTeam = references.getSoccerTeamById(jsonMap["templateSoccerTeamId"]);
  }
}