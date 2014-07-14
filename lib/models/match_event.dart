library match_day;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class MatchEvent {
  String matchEventId;

  SoccerTeam soccerTeamA;
  SoccerTeam soccerTeamB;
  DateTime startDate;

  MatchEvent(this.matchEventId, this.soccerTeamA, this.soccerTeamB, this.startDate);

  MatchEvent.referenceInit(this.matchEventId);
  
  /*
  MatchEvent.fromJsonObject(JsonObject json) {
    matchEventId = json._id;
    soccerTeamA = new SoccerTeam.fromJsonObject(json.soccerTeamA)
      .. matchEvent = this;
    
    soccerTeamB = new SoccerTeam.fromJsonObject(json.soccerTeamB)
      .. matchEvent = this;
    
    startDate = new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true);
  }
  */
  
  factory MatchEvent.fromJsonObject(JsonObject json, ContestReferences references) {
    MatchEvent matchEvent = references.getMatchEventById(json._id);
    
    // matchEventId = json._id;
    matchEvent.soccerTeamA = new SoccerTeam.fromJsonObject(json.soccerTeamA)
      .. matchEvent = matchEvent;
    
    matchEvent.soccerTeamB = new SoccerTeam.fromJsonObject(json.soccerTeamB)
      .. matchEvent = matchEvent;
    
    matchEvent.startDate = new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true);
    
    return matchEvent;
  }
  
  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = soccerTeamA.findSoccerPlayer(soccerPlayerId);
    if (soccerPlayer == null) {
      soccerPlayer = soccerTeamB.findSoccerPlayer(soccerPlayerId);
    }
    return soccerPlayer;
  }
}
