library match_day;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";

class MatchEvent {
  String id;
  SoccerTeam  teamA;
  SoccerTeam  teamB;
  String date;

  MatchEvent(this.id, this.teamA, this.teamB, this.date);

  MatchEvent.fromJsonObject(JsonObject json) {
    id        = json.id;
    teamA     = new SoccerTeam.fromJsonObject( json.teamA );
    teamB     = new SoccerTeam.fromJsonObject( json.teamB );
    date      = json.date;
  }
}
