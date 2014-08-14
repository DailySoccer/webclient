library soccer_player;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  FieldPos fieldPos;
  int    fantasyPoints;
  int    playedMatches;
  int    salary;

  // Fantasy Points (actualizado por liveMatchEvent)
  int    currentLivePoints = 0;

  // Equipo en el que juega
  SoccerTeam team;

  SoccerPlayer.referenceInit(this.templateSoccerPlayerId);

  factory SoccerPlayer.fromJsonObject(JsonObject json, ContestReferences references) {
    SoccerPlayer soccerPlayer = references.getSoccerPlayerById(json.templateSoccerPlayerId);
    return soccerPlayer._initFromJsonObject(json, references);
  }

  SoccerPlayer _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateSoccerPlayerId.isNotEmpty);
    name = json.name;
    fieldPos = new FieldPos(json.fieldPos);
    fantasyPoints = json.fantasyPoints;
    playedMatches = json.playedMatches;
    salary = json.salary;
    return this;
  }
}