library contest_references;

import 'dart:collection';

import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";


class ContestReferences {
  HashMap<String, User> refUsers = new HashMap<String, User>();
  HashMap<String, ContestEntry> refContestEntries = new HashMap<String, ContestEntry>();
  HashMap<String, Contest> refContests = new HashMap<String, Contest>();
  HashMap<String, TemplateContest> refTemplateContests = new HashMap<String, TemplateContest>();
  HashMap<String, MatchEvent> refMatchEvents = new HashMap<String, MatchEvent>();
  
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
}