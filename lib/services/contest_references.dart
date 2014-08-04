library contest_references;

import 'dart:collection';

import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";


class ContestReferences {
  var refUsers = new HashMap<String, User>();
  var refContestEntries = new HashMap<String, ContestEntry>();
  var refContests = new HashMap<String, Contest>();
  var refTemplateContests = new HashMap<String, TemplateContest>();
  var refMatchEvents = new HashMap<String, MatchEvent>();
  var refSoccerTeams = new HashMap<String, SoccerTeam>();
  var refSoccerPlayers = new HashMap<String, SoccerPlayer>();

  ContestReferences();

  User getUserById(String id) {
    return refUsers.containsKey(id) ? refUsers[id]
                                    : refUsers[id] = new User.referenceInit(id);
  }

  ContestEntry getContestEntryById(String id) {
    return refContestEntries.containsKey(id)  ? refContestEntries[id]
                                              : refContestEntries[id] = new ContestEntry.referenceInit(id);
  }

  Contest getContestById(String id) {
    return refContests.containsKey(id) ? refContests[id]
                                       : refContests[id] = new Contest.referenceInit(id);
  }

  TemplateContest getTemplateContestById(String id) {
    return refTemplateContests.containsKey(id) ? refTemplateContests[id]
                                               : refTemplateContests[id] = new TemplateContest.referenceInit(id);
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