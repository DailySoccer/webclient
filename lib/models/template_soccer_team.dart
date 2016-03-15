library template_soccer_team;

import 'package:webclient/services/template_references.dart';

class TemplateSoccerTeam {
  String templateSoccerTeamId;
  String name;
  String shortName;

  TemplateSoccerTeam.referenceInit(this.templateSoccerTeamId);

  factory TemplateSoccerTeam.fromJsonObject(Map jsonMap, TemplateReferences references) {
    TemplateSoccerTeam soccerTeam = references.getTemplateSoccerTeamById(jsonMap.containsKey("templateSoccerTeamId") ? jsonMap["templateSoccerTeamId"] : jsonMap["_id"]);
    return soccerTeam._initFromJsonObject(jsonMap, references);
  }

  TemplateSoccerTeam _initFromJsonObject(Map jsonMap, TemplateReferences references) {
    assert(templateSoccerTeamId.isNotEmpty);
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    shortName = jsonMap.containsKey("shortName") ? jsonMap["shortName"] : "";
    return this;
  }
}