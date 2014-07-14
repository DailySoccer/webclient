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
class ActiveContestService {

  List<Contest> activeContests = new List<Contest>();
  List<TemplateContest> activeTemplateContests = new List<TemplateContest>();
  List<MatchEvent> activeMatchEvents = new List<MatchEvent>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  
  ActiveContestService(this._server);

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
  
  ServerService _server;
}