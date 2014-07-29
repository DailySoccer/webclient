library soccer_player_info;

import "package:json_object/json_object.dart";

class SoccerPlayerInfo {
  String name;
  String fieldPos;
  int    fantasyPoints;
  int    salary;

  List<SoccerPlayerStats> stats;

  SoccerPlayerInfo.fromJsonObject(JsonObject json) {
    name = json.name;
    fieldPos = json.fieldPos;
    fantasyPoints = json.fantasyPoints;
    salary = json.salary;

    stats = new List();
    for (var x in json.stats) {
      stats.add(new SoccerPlayerStats.fromJsonObject(x));
    }
  }
}

class SoccerPlayerStats {
  int fantasyPoints;
  int playedMinutes;
  Map<int, int> events = new Map<int, int>();

  SoccerPlayerStats.fromJsonObject(JsonObject json) {
    fantasyPoints = json.fantasyPoints;
    playedMinutes = json.playedMinutes;
  }
}