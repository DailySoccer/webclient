library soccer_team;

import "package:json_object/json_object.dart";
import "soccer_player.dart";

class SoccerTeam {
  String name;
  String shortName;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  SoccerTeam.fromJsonObject(JsonObject json) {
    name = json.name;
    shortName = json.shortName;

    for (var x in json.soccerPlayers) {
      soccerPlayers.add(new SoccerPlayer.fromJsonObject(x));
    }
  }
}