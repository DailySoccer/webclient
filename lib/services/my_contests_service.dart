library my_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/template_match_event.dart";
import "package:webclient/models/live_match_event.dart";
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/models/contest_entry.dart';

import 'package:webclient/services/contest_references.dart';

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

    _server.getMyContests()
        .then((jsonObject) {
          _initContests (Contest.loadContestsFromJsonObject(jsonObject));
          completer.complete(jsonObject);
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

  Future refreshLiveContests() {
    var completer = new Completer();

    _server.getLiveContests()
        .then((jsonObject) {
          completer.complete(jsonObject);
        });

    return completer.future;
  }

  Future refreshLiveContest(String contestId) {
    var completer = new Completer();

    _server.getLiveContest(contestId)
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
        jsonObject.content.map((jsonObject) => new LiveMatchEvent.fromJsonObject(jsonObject))
          .toList()
          .forEach( (liveMatchEvent) =>
              liveMatchEvent.updateFantasyPoints(lastContest.templateContest.templateMatchEvents.firstWhere((matchEvent) => matchEvent.templateMatchEventId == liveMatchEvent.templateMatchEventId)) );

        completer.complete(jsonObject);
      });

    return completer.future;
  }

  void _initContests(List<Contest> contests) {
    waitingContests = contests.where((contest) => contest.templateContest.isActive).toList();
    liveContests = contests.where((contest) => contest.templateContest.isLive).toList();
    historyContests = contests.where((contest) => contest.templateContest.isHistory).toList();
  }

  ServerService _server;
}