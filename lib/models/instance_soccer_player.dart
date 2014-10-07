library instance_soccer_player;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';

class InstanceSoccerPlayer {
  SoccerPlayer soccerPlayer;
  SoccerTeam soccerTeam;

  FieldPos fieldPos;
  int salary;

  String get printableCurrentLivePoints => (soccerTeam.matchEvent.isStarted) ? soccerPlayer.currentLivePoints.toString() : "-";

  List<Map> get printableLivePointsPerOptaEvent {
    List<Map> stats = new List<Map>();
    soccerPlayer.currentLivePointsPerOptaEvent.forEach((key, value) => stats.add({'name': SoccerPlayer.getEventName(key), 'points': value}));
    stats.sort((elem0, elem1) => elem0["name"].compareTo(elem1["name"]) );
    return stats;
  }

  InstanceSoccerPlayer.initFromJsonObject(JsonObject json, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(json.templateSoccerPlayerId);
    fieldPos = json.containsKey("fieldPos") ? new FieldPos(json.fieldPos) : null;
    salary = json.containsKey("salary") ? json.salary : 0;
    soccerTeam = references.getSoccerTeamById(json.templateSoccerTeamId);
  }
}