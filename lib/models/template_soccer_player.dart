library template_soccer_player;

import 'package:logging/logging.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/soccer_player_stats.dart';
import 'package:webclient/services/template_references.dart';

class StatsCompetition {
  int num;
  int fantasyPoints;
}

class TemplateSoccerPlayer {
  static String UNKNOWN = "<unknown>";
  
  String templateSoccerPlayerId;
  String name = UNKNOWN;
  int    fantasyPoints = 0;
  
  List<SoccerPlayerStats> stats = [];
  Map<String, StatsCompetition> competitions = {};

  int getFantasyPointsForCompetition(String competitionId) {
    if (competitions.containsKey(competitionId)) {
      return competitions[competitionId].fantasyPoints;
    }
    List matchsForCompetition = stats.where((stat) => stat.isCurrentSeason(competitionId)).toList();
    return matchsForCompetition.isNotEmpty ? matchsForCompetition.fold(0, (prev, stat) => prev + stat.fantasyPoints ) ~/ matchsForCompetition.length : 0;
  }

  int getPlayedMatchesForCompetition(String competitionId) {
    if (competitions.containsKey(competitionId)) {
      return competitions[competitionId].num;
    }
    return stats.where((stat) => stat.isCurrentSeason(competitionId)).length;
  }
  
  TemplateSoccerPlayer.referenceInit(this.templateSoccerPlayerId);

  factory TemplateSoccerPlayer.fromJsonObject(Map jsonMap, TemplateReferences references) {
    TemplateSoccerPlayer soccerPlayer = references.getTemplateSoccerPlayerById(jsonMap.containsKey("templateSoccerPlayerId") ? jsonMap["templateSoccerPlayerId"] : jsonMap["_id"]);
    return soccerPlayer._initFromJsonObject(jsonMap, references);
  }

  TemplateSoccerPlayer _initFromJsonObject(Map jsonMap, TemplateReferences references) {
    assert(templateSoccerPlayerId.isNotEmpty);
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    fantasyPoints = jsonMap.containsKey("fantasyPoints") ? jsonMap["fantasyPoints"] : 0;

    loadStatsFromJsonObject(jsonMap, references);
    return this;
  }
  
  void loadStatsFromJsonObject(Map jsonMap, TemplateReferences references) {
    if (jsonMap.containsKey("stats")) {
      stats = [];
      for (var x in jsonMap["stats"]) {
        stats.add(new SoccerPlayerStats.fromJsonObject(x, references));
      }
      // Eliminar las estadísticas vacías
      stats.removeWhere((stat) => !stat.hasPlayed());
    }
    
    if (jsonMap.containsKey("competitions")) {
      for (var competitionId in jsonMap["competitions"].keys) {
        var x = jsonMap["competitions"][competitionId];
        StatsCompetition competition = new StatsCompetition();
        competition.num = x["num"];
        competition.fantasyPoints = x["fantasyPoints"];
        competitions[competitionId] = competition;
      }
    }
  }
}