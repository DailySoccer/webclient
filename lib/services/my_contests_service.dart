library my_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/contest_entry.dart';

import 'package:webclient/services/contest_references.dart';

@Injectable()
class MyContestsService {

  List<Contest> waitingContests = new List<Contest>();
  List<Contest> liveContests = new List<Contest>();
  List<Contest> historyContests = new List<Contest>();
  
  // Informacion relacionada con un unico Contest
  Contest lastContest;
  List<MatchEvent> liveMatchEvents = new List<MatchEvent>();
  
  Contest getContestById(String id) {
    return waitingContests.firstWhere((contest) => contest.contestId == id,
        orElse: () => liveContests.firstWhere((contest) => contest.contestId == id, 
        orElse: () => historyContests.firstWhere((contest) => contest.contestId == id,
        orElse: () => null)));
  }

  MyContestsService(this._server);
  
  Future refreshMyContests() {
    var completer = new Completer();

    _server.getMyContests()
        .then((jsonObject) {
          _initContests (Contest.loadContestsFromJsonObject(jsonObject));
          completer.complete();
        });

    return completer.future;
  }

  Future getMyContests() {
    var completer = new Completer();

    _server.getMyContests()
        .then((jsonObject) {
          _initContests (Contest.loadContestsFromJsonObject(jsonObject));
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getContest(String contestId) {
    var completer = new Completer();

    _server.getContest(contestId)
        .then((jsonObject) {
          lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getLiveContests() {
    var completer = new Completer();

    _server.getLiveContests()
        .then((jsonObject) {
          print("liveContests: response: " + jsonObject.toString());
          completer.complete(jsonObject);
        });

    return completer.future;
  }
  
  Future getLiveContest(String contestId) {
    var completer = new Completer();

    _server.getLiveContest(contestId)
        .then((jsonObject) {
          lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
          completer.complete(jsonObject);
        });

    return completer.future;
  }

  Future getLiveMatchEvents(String templateContestId) {
    var completer = new Completer();

    _server.getLiveMatchEventsFromTemplateContest(templateContestId)
      .then((jsonObject) {
        print("liveMatchEvents: response: " + jsonObject.toString());
      
        ContestReferences contestReferences = new ContestReferences();
        liveMatchEvents = jsonObject.content.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
      
        // No asociamos el contest y el templateContest a los partidos live
        // new ContestReferences.fromContest(contest, templateContest, liveMatchEvents);
        completer.complete(jsonObject);
      });
    
    return completer.future;    
  }
  
  int getSoccerPlayerScore(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;
    
    // Buscar en la lista de partidos del contest
    for (MatchEvent match in liveMatchEvents) {
      soccerPlayer = match.soccerTeamA.findSoccerPlayer(soccerPlayerId);
      if (soccerPlayer == null) {
        soccerPlayer = match.soccerTeamB.findSoccerPlayer(soccerPlayerId);
      }
      
      // Lo hemos encontrado?
      if (soccerPlayer != null)
        break;
    }
    
    return (soccerPlayer!=null) ? soccerPlayer.fantasyPoints : 0;
  }
  
  int getUserScore(ContestEntry contestEntry) {
    return contestEntry.soccers.fold(0, (prev, soccerPlayer) => prev + getSoccerPlayerScore(soccerPlayer.templateSoccerPlayerId) );
  }
  
  void _initContests(List<Contest> contests) {
    waitingContests = contests.where((contest) => contest.templateContest.isActive).toList();
    liveContests = contests.where((contest) => contest.templateContest.isLive).toList();
    historyContests = contests.where((contest) => contest.templateContest.isHistory).toList();
  }
  
  ServerService _server;
}