library contest_references;

import 'dart:collection';

import "package:webclient/models/user.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/template_contest.dart';

class ContestReferences {
  var refUsers = new HashMap<String, User>();
  var refTemplateContests = new HashMap<String, TemplateContest>();
  var refContests = new HashMap<String, Contest>();
  var refMatchEvents = new HashMap<String, MatchEvent>();
  var refSoccerTeams = new HashMap<String, SoccerTeam>();
  var refSoccerPlayers = new HashMap<String, SoccerPlayer>();

  ContestReferences();

  User getUserById(String id) {
    return refUsers.containsKey(id) ? refUsers[id]
                                    : refUsers[id] = new User.referenceInit(id);
  }

  TemplateContest getTemplateContestById(String id) {
    return refTemplateContests.containsKey(id)  ? refTemplateContests[id]
                                                : refTemplateContests[id] = new TemplateContest.referenceInit(id);
  }

  Contest getContestById(String id) {
    return refContests.containsKey(id) ? refContests[id]
                                       : refContests[id] = new Contest.referenceInit(id);
  }

  MatchEvent getMatchEventById(String id) {
    return refMatchEvents.containsKey(id) ? refMatchEvents[id]
                                          : refMatchEvents[id] = new MatchEvent.referenceInit(id);
  }

  SoccerTeam getSoccerTeamById(String id) {
    return refSoccerTeams.containsKey(id) ? refSoccerTeams[id]
                                          : refSoccerTeams[id] = new SoccerTeam.referenceInit(id);
  }

  SoccerPlayer getSoccerPlayerById(String id) {
    return refSoccerPlayers.containsKey(id) ? refSoccerPlayers[id]
                                            : refSoccerPlayers[id] = new SoccerPlayer.referenceInit(id);
  }
}