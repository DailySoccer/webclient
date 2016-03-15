library template_soccer_player;

import 'package:logging/logging.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/soccer_player_stats.dart';
import 'package:webclient/services/template_references.dart';

class TemplateSoccerPlayer {
  String templateSoccerPlayerId;
  String name;
  int    fantasyPoints;
  
  List<SoccerPlayerStats> stats = [];

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
  }
}