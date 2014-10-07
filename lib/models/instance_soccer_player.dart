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

  InstanceSoccerPlayer.initFromJsonObject(JsonObject json, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(json.templateSoccerPlayerId);
    fieldPos = json.containsKey("fieldPos") ? new FieldPos(json.fieldPos) : null;
    salary = json.containsKey("salary") ? json.salary : 0;
    soccerTeam = references.getSoccerTeamById(json.templateSoccerTeamId);
  }
}