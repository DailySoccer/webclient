library contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/soccer_player.dart";

import 'package:webclient/services/contest_references.dart';

@Injectable()
class MyContestService {

  List<Contest> activeContests = new List<Contest>();
  List<TemplateContest> activeTemplateContests = new List<TemplateContest>();
  List<MatchEvent> activeMatchEvents = new List<MatchEvent>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  TemplateContest getTemplateContestById(String id) => activeTemplateContests.firstWhere((templateContest) => templateContest.templateContestId == id, orElse: () => null);
  MatchEvent getMatchEventById(String id) => activeMatchEvents.firstWhere((matchEvent) => matchEvent.matchEventId == id, orElse: () => null);
  
  SoccerPlayer getSoccerPlayerInContest(String contestId, String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;
    
    Contest contest = getContestById(contestId);
    TemplateContest templateContest = getTemplateContestById(contest.templateContestId);
    
    // Buscar en la lista de partidos del contest
    List<MatchEvent> matchEvents = getMatchEventsForTemplateContest(templateContest);
    for (MatchEvent match in matchEvents) {
      SoccerPlayer soccer = match.soccerTeamA.findSoccerPlayer(soccerPlayerId);
      if (soccer == null) {
        soccer = match.soccerTeamB.findSoccerPlayer(soccerPlayerId);
      }
      
      // Lo hemos encontrado?
      if (soccer != null) {
        soccerPlayer = soccer;
        break;
      }
    }
    
    return soccerPlayer;
  }

  int getSalaryCapForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.salaryCap : -1;
  }

  int getEntryFeeForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.entryFee : -1;
  }

  String getPrizeTypeForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.prizeType : "<>";
  }

  List<MatchEvent> getMatchEventsForTemplateContest(TemplateContest template) {
    // Cached value (pq "Observer reaction functions should not change model.")
    if (!_templateMatchEvents.containsKey(template.templateContestId)) {
      _templateMatchEvents[template.templateContestId] = template.templateMatchEventIds.map((matchEventId) => getMatchEventById(matchEventId)).toList();
    }
    return _templateMatchEvents[template.templateContestId];
  }

  List<MatchEvent> getMatchEventsForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? getMatchEventsForTemplateContest(template) : null;
   }

  DateTime getContestStartDate(Contest contest) {
    return getMatchEventsForContest(contest).map((matchEvent) => matchEvent.startDate)
                                            .reduce((val, elem) => val.isBefore(elem)? val : elem);
  }

  MyContestService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    _server.getActiveContests()
        .then((jsonObject) {
          activeMatchEvents = jsonObject.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject)).toList();
          activeTemplateContests = jsonObject.template_contests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject)).toList();
          activeContests = jsonObject.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject)).toList();
          
          new ContestReferences.fromContests(activeContests, activeTemplateContests, activeMatchEvents);
          completer.complete();
        });

    return completer.future;
  }
  
  Future addContestEntry(String contestId, List<String> soccerPlayerIds) {
    var completer = new Completer();
    
    _server.addContestEntry(contestId, soccerPlayerIds)
      .then((jsonObject) {
        print("response: " + jsonObject.toString());
        completer.complete();
      });
    
    return completer.future;
  }
  
  Future getUserContests() {
    var completer = new Completer();

    _server.getUserContests()
        .then((jsonObject) {
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getContest(String contestId) {
    var completer = new Completer();

    _server.getContest(contestId)
        .then((jsonObject) {
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getLiveContests() {
    var completer = new Completer();

    _server.getLiveContests()
        .then((jsonObject) {
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getLiveContest(String contestId) {
    var completer = new Completer();

    _server.getLiveContest(contestId)
        .then((jsonObject) {
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getLiveContestEntries(String contestId) {
    var completer = new Completer();
    
    _server.getLiveContestEntries(contestId)
      .then((jsonObject) {
        print("liveContestEntries: response: " + jsonObject.toString());
        completer.complete(jsonObject);
      });
    
    return completer.future;    
  }
  
  Future getLiveMatchEvents(String templateContestId) {
    var completer = new Completer();

    _server.getLiveMatchEventsFromTemplateContest(templateContestId)
      .then((jsonObject) {
        print("liveMatchEvents: response: " + jsonObject.toString());
        completer.complete(jsonObject);
      });
    
    return completer.future;    
  }
  

  var _templateMatchEvents = new Map<String, List<MatchEvent>>();
  ServerService _server;
}