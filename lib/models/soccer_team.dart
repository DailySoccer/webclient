library soccer_team;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerTeam {
  String templateSoccerTeamId;
  String name;
  String shortName;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();

  // Partido en el que juega
  MatchEvent matchEvent;

  SoccerTeam.referenceInit(this.templateSoccerTeamId);

  factory SoccerTeam.fromJsonObject(JsonObject json, ContestReferences references) {
    SoccerTeam soccerTeam = references.getSoccerTeamById(json.containsKey("templateSoccerTeamId") ? json.templateSoccerTeamId : json._id);
    return soccerTeam._initFromJsonObject(json, references);
  }

  SoccerTeam _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateSoccerTeamId.isNotEmpty);
    name = json.containsKey("name") ? json.name : "";
    shortName = json.containsKey("shortName") ? json.shortName : "";

    if (json.containsKey("soccerPlayers")) {
      for (var x in json.soccerPlayers) {
        SoccerPlayer soccerPlayer = new SoccerPlayer.fromJsonObject(x, references)
          .. team = this;

        soccerPlayers.add(soccerPlayer);
      }
    }
    return this;
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    return soccerPlayers.firstWhere( (soccer) => soccer.templateSoccerPlayerId == soccerPlayerId, orElse: () => null );
  }
}