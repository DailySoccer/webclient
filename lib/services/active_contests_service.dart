library active_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class ActiveContestsService {

  List<Contest> activeContests = new List<Contest>();
  
  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  
  ActiveContestsService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    _server.getActiveContests()
        .then((jsonObject) {
          activeContests = Contest.loadContestsFromJsonObject(jsonObject);
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