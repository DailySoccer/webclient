library my_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";


@Injectable()
class MyContestsService {

  List<Contest> waitingContests = new List<Contest>();
  List<Contest> liveContests = new List<Contest>();
  List<Contest> historyContests = new List<Contest>();

  // El ultimo concurso que hemos cargado a traves de getContest
  Contest lastContest;

  Contest getContestById(String id) {
    return waitingContests.firstWhere((contest) => contest.contestId == id,
        orElse: () => liveContests.firstWhere((contest) => contest.contestId == id,
        orElse: () => historyContests.firstWhere((contest) => contest.contestId == id,
        orElse: () => null)));
  }

  MyContestsService(this._server);


  Future refreshMyContests() {
    var completer = new Completer();

    Future.wait([_server.getMyNextContests(), _server.getMyLiveContests(), _server.getMyHistoryContests()])
        .then((List responses) {
          waitingContests = Contest.loadContestsFromJsonObject(responses[0]);
          liveContests = Contest.loadContestsFromJsonObject(responses[1]);
          historyContests = Contest.loadContestsFromJsonObject(responses[2]);
          completer.complete(responses);
        });

    return completer.future;
  }

  Future refreshContest(String contestId) {
    var completer = new Completer();

    _server.getContest(contestId)
        .then((jsonObject) {
          lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
          completer.complete(jsonObject);
        });

    return completer.future;
  }

  Future refreshLiveMatchEvents(String templateContestId) {
    var completer = new Completer();

    _server.getLiveMatchEventsFromTemplateContest(templateContestId)
      .then((jsonObject) {
        jsonObject.content.forEach((jsonObject) {
            lastContest.templateContest.matchEvents.firstWhere((matchEvent) => matchEvent.templateMatchEventId == jsonObject.templateMatchEventId)
                .. updateLiveInfo(jsonObject);
        });
        completer.complete(jsonObject);
      });

    return completer.future;
  }

  ServerService _server;
}