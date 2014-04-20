library soccer_team;

import "package:json_object/json_object.dart";

import "soccer_player.dart";

class SoccerTeam {
  String id;
  String name;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  SoccerTeam.initFromJSONObject(JsonObject json) {
    id   = json.id;
    name = json.name;

    for (var x in json.soccers) {
      soccerPlayers.add(new SoccerPlayer.initFromJSONObject(x));
    }

    print("new SoccerTeam: $json");
  }
}