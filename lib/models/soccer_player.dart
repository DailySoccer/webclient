library soccer_player;

import "package:json_object/json_object.dart";

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  String fieldPos;
  int    salary;

  SoccerPlayer.fromJsonObject(JsonObject json) {
    templateSoccerPlayerId = json.templateSoccerPlayerId;
    name = json.name;
    fieldPos = json.fieldPos;
    salary = json.salary;
  }
}