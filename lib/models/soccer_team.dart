library soccer_team;

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

  factory SoccerTeam.fromJsonObject(Map jsonMap, ContestReferences references) {
    SoccerTeam soccerTeam = references.getSoccerTeamById(jsonMap.containsKey("templateSoccerTeamId") ? jsonMap["templateSoccerTeamId"] : jsonMap["_id"]);
    return soccerTeam._initFromJsonObject(jsonMap, references);
  }

  SoccerTeam _initFromJsonObject(Map jsonMap, ContestReferences references) {
    assert(templateSoccerTeamId.isNotEmpty);
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    shortName = jsonMap.containsKey("shortName") ? jsonMap["shortName"] : "";

    if (jsonMap.containsKey("soccerPlayers")) {
      for (var x in jsonMap["soccerPlayers"]) {
        SoccerPlayer soccerPlayer = references.getSoccerPlayerById(x)
          .. soccerTeam = this;

        addSoccerPlayer(soccerPlayer);
      }
    }
    return this;
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    return soccerPlayers.firstWhere( (soccer) => soccer.templateSoccerPlayerId == soccerPlayerId, orElse: () => null );
  }

  void addSoccerPlayer(SoccerPlayer soccerPlayer) {
    soccerPlayers.add(soccerPlayer);
  }
}