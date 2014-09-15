library active_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";


@Injectable()
class ActiveContestsService {

  List<Contest> activeContests = new List<Contest>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);

  // El ultimo concurso que hemos cargado a traves de getContest
  Contest lastContest;

  ActiveContestsService(this._server);

  Future refreshActiveContests() {
    return _server.getActiveContests()
      .then((jsonObject) {
        activeContests = Contest.loadContestsFromJsonObject(jsonObject);
      });
  }

  Future addContestEntry(String contestId, List<String> soccerPlayerIds) {
    return _server.addContestEntry(contestId, soccerPlayerIds)
      .then((jsonObject) {
        print("response: " + jsonObject.toString());
      });
  }

  Future refreshContest(String contestId) {
    return _server.getContestInfo(contestId)
      .then((jsonObject) {
        lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
      });
  }

  ServerService _server;
}