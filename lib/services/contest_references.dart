library contest_references;

import 'dart:collection';

import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";


class ContestReferences {
  HashMap<String, Contest> refContests = new HashMap<String, Contest>();
  HashMap<String, TemplateContest> refTemplateContests = new HashMap<String, TemplateContest>();
  HashMap<String, MatchEvent> refMatchEvents = new HashMap<String, MatchEvent>();
  
  ContestReferences.embedInContests(List<Contest> contests, List<TemplateContest> templateContests, List<MatchEvent> matchEvents) {
    // Registrar los ids para su posterior query
    contests.forEach( (contest) => refContests[contest.contestId] = contest );
    templateContests.forEach( (templateContest) => refTemplateContests[templateContest.templateContestId] = templateContest );
    matchEvents.forEach( (matchEvent) => refMatchEvents[matchEvent.matchEventId] = matchEvent );
    
    // Solicitar a cada objeto que actualice sus referencias
    contests.forEach( (contest) => contest.linkReferences(this) );
    templateContests.forEach( (templateContest) => templateContest.linkReferences(this) );
    matchEvents.forEach( (matchEvent) => matchEvent.linkReferences(this) );
  }
  
  ContestReferences.embedInContest(Contest contest, TemplateContest templateContest, List<MatchEvent> matchEvents) {
    // Registrar los ids para su posterior query
    refContests[contest.contestId] = contest;
    refTemplateContests[templateContest.templateContestId] = templateContest;
    matchEvents.forEach( (matchEvent) => refMatchEvents[matchEvent.matchEventId] = matchEvent );
    
    // Solicitar a cada objeto que actualice sus referencias
    contest.linkReferences(this);
    templateContest.linkReferences(this);
    matchEvents.forEach( (matchEvent) => matchEvent.linkReferences(this) );
  }
  
  Contest getContestById(String id) => refContests[id];
  TemplateContest getTemplateContestById(String id) => refTemplateContests[id];
  MatchEvent getMatchEventById(String id) => refMatchEvents[id];
}