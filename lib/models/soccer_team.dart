library soccer_team;

import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/models/template_soccer_team.dart';

class SoccerTeam {
  String templateSoccerTeamId;
  TemplateSoccerTeam templateSoccerTeam;
  
  String get name => templateSoccerTeam.name;
  String get shortName => templateSoccerTeam.shortName;
  
  List<SoccerPlayer> soccerPlayers = new List<SoccerPlayer>();
  Map<String, SoccerPlayer> soccerPlayersMap = new Map<String, SoccerPlayer>();

  // Partido en el que juega
  MatchEvent matchEvent;

  // Nº de goles marcados en el partido
  int score = -1;

  bool get hasFullInformation => name != null;
  
  SoccerTeam.referenceInit(this.templateSoccerTeamId);

  factory SoccerTeam.fromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    SoccerTeam soccerTeam = contestReferences.getSoccerTeamById(jsonMap.containsKey("templateSoccerTeamId") ? jsonMap["templateSoccerTeamId"] : jsonMap["_id"]);
    return soccerTeam._initFromJsonObject(jsonMap, templateReferences, contestReferences);
  }

  factory SoccerTeam.fromId(String templateSoccerTeamId, TemplateReferences templateReferences, ContestReferences contestReferences) {
    SoccerTeam soccerTeam = contestReferences.getSoccerTeamById(templateSoccerTeamId);
    return soccerTeam._initFromJsonObject(null, templateReferences, contestReferences);
  }
  
  SoccerTeam _initFromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    assert(templateSoccerTeamId.isNotEmpty);
    
    templateSoccerTeam = templateReferences.getTemplateSoccerTeamById(templateSoccerTeamId);

    if (jsonMap != null && jsonMap.containsKey("soccerPlayers")) {
      for (var x in jsonMap["soccerPlayers"]) {
        SoccerPlayer soccerPlayer = contestReferences.getSoccerPlayerById(x)
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