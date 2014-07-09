library soccer_player;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  String fieldPos;
  int    fantasyPoints;
  int    playedMatches;
  int    salary;

  // Equipo en el que juega
  SoccerTeam team;  
  
  SoccerPlayer.fromJsonObject(JsonObject json) {
    templateSoccerPlayerId = json.templateSoccerPlayerId;
    name = json.name;
    fieldPos = json.fieldPos;
    fantasyPoints = json.fantasyPoints;
    playedMatches = json.playedMatches;
    salary = json.salary;
  }
}