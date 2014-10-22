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

  void clear() {
    waitingContests.clear();
    liveContests.clear();
    historyContests.clear();
  }

  Future cancelContestEntry(String contestEntryId) {
    var completer = new Completer();

    _server.cancelContestEntry(contestEntryId)
      .then((jsonObject) {
        print("response: " + jsonObject.toString());
        completer.complete();
      });

    return completer.future;
  }

  Future editContestEntry(String contestId, List<String> soccerPlayerIds) {
    var completer = new Completer();

    _server.editContestEntry(contestId, soccerPlayerIds)
      .then((jsonObject) {
        print("response: " + jsonObject.toString());
        completer.complete();
      });

    return completer.future;
  }

  Future refreshMyContests() {
    var completer = new Completer();

    _server.getMyContests()
        .then((jsonObject) {
          _initContests (Contest.loadContestsFromJsonObject(jsonObject));
          completer.complete(jsonObject);
        });

    return completer.future;
  }

  Future refreshMyContest(String contestId) {
    var completer = new Completer();

    _server.getMyContest(contestId)
        .then((jsonObject) {
          lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
          completer.complete(jsonObject);
        });

    return completer.future;
  }

  Future refreshFullContest(String contestId) {
    var completer = new Completer();

    _server.getFullContest(contestId)
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
            lastContest.matchEvents.firstWhere((matchEvent) => matchEvent.templateMatchEventId == (jsonObject.containsKey("templateMatchEventId") ? jsonObject.templateMatchEventId : jsonObject["_id"]))
                .. updateLiveInfo(jsonObject);
        });
        completer.complete(jsonObject);
      });

    return completer.future;
  }

  void _initContests(List<Contest> contests) {
    waitingContests = contests.where((contest) => contest.isActive).toList();
    liveContests = contests.where((contest) => contest.isLive).toList();
    historyContests = contests.where((contest) => contest.isHistory).toList();
  }

  ServerService _server;
}