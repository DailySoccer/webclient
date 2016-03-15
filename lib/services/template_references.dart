library template_references;

import 'dart:collection';

import 'package:webclient/models/template_soccer_player.dart';
import 'package:webclient/models/template_soccer_team.dart';

class TemplateReferences {

  var refTemplateSoccerPlayers = new HashMap<String, TemplateSoccerPlayer>();
  var refTemplateSoccerTeams = new HashMap<String, TemplateSoccerTeam>();

  TemplateReferences();

  TemplateSoccerTeam getTemplateSoccerTeamById(String id) {
    return refTemplateSoccerTeams.containsKey(id) ? refTemplateSoccerTeams[id]
                                                  : refTemplateSoccerTeams[id] = new TemplateSoccerTeam.referenceInit(id);
  }

  TemplateSoccerPlayer getTemplateSoccerPlayerById(String id) {
    return refTemplateSoccerPlayers.containsKey(id) ? refTemplateSoccerPlayers[id]
                                                    : refTemplateSoccerPlayers[id] = new TemplateSoccerPlayer.referenceInit(id);
  }
}