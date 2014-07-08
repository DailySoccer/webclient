library soccer_team;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";

class SoccerTeam {
  String templateSoccerTeamId;
  String name;
  String shortName;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  // Partido en el que juega
  MatchEvent matchEvent;
  
  SoccerTeam.fromJsonObject(JsonObject json) {
    templateSoccerTeamId = json.templateSoccerTeamId;
    name = json.name;
    shortName = json.shortName;

    for (var x in json.soccerPlayers) {
      SoccerPlayer soccerPlayer = new SoccerPlayer.fromJsonObject(x)
        .. team = this;
      
      soccerPlayers.add(soccerPlayer);
    }
  }
}