library my_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/contest_entry.dart';

import 'package:webclient/services/contest_references.dart';

@Injectable()
class MyContestsService {

  List<Contest> activeContests = new List<Contest>();
  List<MatchEvent> liveMatchEvents = new List<MatchEvent>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);

  MyContestsService(this._server);

  Future refreshMyContests() {
    var completer = new Completer();

    _server.getActiveContests()
        .then((jsonObject) {
          ContestReferences contestReferences = new ContestReferences();
          activeContests = jsonObject.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList();
          var templateContests = jsonObject.template_contests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject, contestReferences)).toList();
          var matchEvents = jsonObject.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
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
    int points = 0;
    for (String soccerPlayerId in contestEntry.soccerIds) {
      points += getSoccerPlayerScore(soccerPlayerId);
    }
    return points;
  }
  
  var _templateMatchEvents = new Map<String, List<MatchEvent>>();
  ServerService _server;
}