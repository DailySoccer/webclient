library contest_references;

import 'dart:collection';

import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";


class ContestReferences {
  HashMap<String, Contest> refContests = new HashMap<String, Contest>();
  HashMap<String, TemplateContest> refTemplateContests = new HashMap<String, TemplateContest>();
  HashMap<String, MatchEvent> refMatchEvents = new HashMap<String, MatchEvent>();
  
  ContestReferences() {
  }
  
  Contest getContestById(String id) {
    Contest contest = null;
    if (refContests.containsKey(id)) {
      contest = refContests[id];
    }
    else {
      refContests[id] = contest = new Contest.referenceInit(id);
    }
    return contest;
  }
  
  TemplateContest getTemplateContestById(String id) {
    TemplateContest templateContest = null;
    if (refTemplateContests.containsKey(id)) {
      templateContest = refTemplateContests[id];
    }
    else {
      refTemplateContests[id] = templateContest = new TemplateContest.referenceInit(id);
    }
    return templateContest;
  }
  
  MatchEvent getMatchEventById(String id) { 
    MatchEvent matchEvent = null;
    if (refMatchEvents.containsKey(id)) {
      matchEvent = refMatchEvents[id];
    }
    else {
      refMatchEvents[id] = matchEvent = new MatchEvent.referenceInit(id);
    }
    return matchEvent;
  }
}