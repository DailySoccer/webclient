library active_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";

import 'package:webclient/services/contest_references.dart';

@Injectable()
class ActiveContestService {

  List<Contest> activeContests = new List<Contest>();
  
  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  
  ActiveContestService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    _server.getActiveContests()
        .then((jsonObject) {
          activeContests = jsonObject.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject)).toList();
         
          new ContestReferences.fromContests(
              activeContests, 
              jsonObject.template_contests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject)).toList(), 
              jsonObject.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject)).toList()
          );
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
   
  ServerService _server;
}