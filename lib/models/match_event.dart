library match_day;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";

class MatchEvent {
  String matchEventId;

  SoccerTeam soccerTeamA;
  SoccerTeam soccerTeamB;
  DateTime startDate;

  MatchEvent(this.matchEventId, this.soccerTeamA, this.soccerTeamB, this.startDate);

  MatchEvent.fromJsonObject(JsonObject json) {
    matchEventId = json._id;
    soccerTeamA = new SoccerTeam.fromJsonObject(json.soccerTeamA);
    soccerTeamB = new SoccerTeam.fromJsonObject(json.soccerTeamB);
    startDate = new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true);
  }
}
