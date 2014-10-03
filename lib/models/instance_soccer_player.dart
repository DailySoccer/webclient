library instance_soccer_player;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/field_pos.dart";

class InstanceSoccerPlayer {
  String templateSoccerPlayerId;
  FieldPos fieldPos;
  int    salary;
  String templateSoccerTeamId;

  InstanceSoccerPlayer.initFromJsonObject(JsonObject json) {
    templateSoccerPlayerId = json.templateSoccerPlayerId;
    fieldPos = json.containsKey("fieldPos") ? new FieldPos(json.fieldPos) : null;
    salary = json.containsKey("salary") ? json.salary : 0;
    templateSoccerTeamId = json.templateSoccerTeamId;
  }

  void applyOn(SoccerPlayer soccerPlayer) {
    soccerPlayer.salary = salary;
    soccerPlayer.fieldPos = soccerPlayer.fieldPos;
  }
}