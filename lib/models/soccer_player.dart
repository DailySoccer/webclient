library soccer_player;

import "package:json_object/json_object.dart";

class SoccerPlayer {
  String name;
  String fieldPos;
  int    salary;

  SoccerPlayer.fromJsonObject(JsonObject json) {
    name = json.name;
    fieldPos = json.fieldPos;
    salary = json.salary;
  }
}