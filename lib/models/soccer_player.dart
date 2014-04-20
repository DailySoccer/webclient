library soccer;

import "package:json_object/json_object.dart";

class SoccerPlayer {
  String id;
  String name;
  String teamId;
  String position;
  int    points;
  num    salary;

  SoccerPlayer.initFromJSONObject(JsonObject json) {
    _initFromJSONObject(json);
  }

  _initFromJSONObject(JsonObject json) {
      id   = json.id;
      name = json.name;

      print("new SoccerPlayer: $json");
  }
}