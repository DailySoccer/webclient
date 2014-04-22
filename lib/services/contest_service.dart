library contest_service;

import 'dart:async';
import "package:json_object/json_object.dart";

import "package:webclient/services/server_service.dart";
import "package:webclient/services/match_group_service.dart";
import "package:webclient//models/contest.dart";

class ContestService {

  bool isSynchronized = false;

  Contest getContest(String contestId) => _contests[contestId];
  String getContestStartDate(String contestId) => _matchGroupService.getMatchGroupStartDate(_contests[ contestId ].groupId);

  ContestService(this._server, this._matchGroupService);

  Future< Iterable<Contest> > getAllContests() {
    print("ContestManager: all");

    return _matchGroupService.sync()
      .then((_) => _server.getAllContests())
      .then((response) {
        isSynchronized = true;

        print("response: $response");

        // Inicialización del mapa de partidos
        _contests = new Map<String, Contest>();
        for (var x in response) {
          print("contest: ${x.id}: $x");

          var contest = new Contest.fromJsonObject(x);

          // Generación automática del nombre (si está vacio)
          if (contest.name.isEmpty) {
            String date = _matchGroupService.getMatchGroupStartDate(contest.groupId);
            contest.name = "Mundial - Salary Cap ${contest.capSalary} - $date";
            // print("name: ${contest.name}");
          }

          _contests[x.id] = contest;
        }

        // Devolver el map en formato lista
        // REVIEW: ¿usar _contests.values?
        var list = new List<Contest>();
        _contests.forEach((k,v) => list.add(v));
        return list;
      });
  }

  ServerService _server;
  MatchGroupService _matchGroupService;
  var _contests;
}