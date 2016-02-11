library soccer_team;

import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerTeam {
  String templateSoccerTeamId;
  String name;
  String shortName;
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();
  Map<String, SoccerPlayer> soccerPlayersMap = new Map<String, SoccerPlayer>();

  // Partido en el que juega
  MatchEvent matchEvent;

  // Nº de goles marcados en el partido
  int score = -1;

  bool get hasFullInformation => name != null;
  
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
    return soccerPlayersMap.containsKey(soccerPlayerId) ? soccerPlayersMap[soccerPlayerId] : null;
  }

  void addSoccerPlayer(SoccerPlayer soccerPlayer) {
    if (!soccerPlayersMap.containsKey(soccerPlayer.templateSoccerPlayerId)) {
      soccerPlayersMap[soccerPlayer.templateSoccerPlayerId] = soccerPlayer;
      soccerPlayers.add(soccerPlayer);
    }
  }
}