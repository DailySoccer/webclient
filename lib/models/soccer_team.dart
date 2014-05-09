library soccer_team;

import "package:json_object/json_object.dart";
import "soccer_player.dart";

class SoccerTeam {
  String name;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  SoccerTeam.fromJsonObject(JsonObject json) {
    name = json.name;

    for (var x in json.soccerPlayers) {
      soccerPlayers.add(new SoccerPlayer.fromJsonObject(x));
    }
  }
}