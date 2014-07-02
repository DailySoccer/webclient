library soccer_team;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_player.dart";

class SoccerTeam {
  String templateSoccerTeamId;
  String name;
  String shortName;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  SoccerTeam.fromJsonObject(JsonObject json) {
    templateSoccerTeamId = json.templateSoccerTeamId;
    name = json.name;
    shortName = json.shortName;

    for (var x in json.soccerPlayers) {
      soccerPlayers.add(new SoccerPlayer.fromJsonObject(x));
    }
  }
}