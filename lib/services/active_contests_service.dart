library active_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import "package:webclient/models/contest.dart";


@Injectable()
class ActiveContestsService {

  List<Contest> activeContests = new List<Contest>();

  // El ultimo concurso que hemos cargado a traves de refreshContest
  Contest lastContest;

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);

  ActiveContestsService(this._server, this._profileService);

  void clear() {
    activeContests.clear();
    _myEnteredActiveContests.clear();
  }

  Future refreshActiveContests() {
    return _server.getActiveContests()
      .then((jsonMap) {
        activeContests = Contest.loadContestsFromJsonObject(jsonMap);

        if (_profileService.isLoggedIn) {
          _myEnteredActiveContests = activeContests.where((contest) => contest.containsContestEntryWithUser(_profileService.user.userId)).toList();
          activeContests.removeWhere((contest) => contest.containsContestEntryWithUser(_profileService.user.userId));

          _myEnteredActiveContests.sort((A,B) => A.compareStartDateTo(B));
          activeContests.sort((A,B) => A.compareStartDateTo(B));
        }
      });
  }

  Future addContestEntry(String contestId, List<String> soccerPlayerIds) {
    return _server.addContestEntry(contestId, soccerPlayerIds)
      .then((jsonMap) {
        String contestId = jsonMap["contestId"];

        // Actualizar las listas de activeContests (quitando el contest) y myContests (añadiendo el contest)
        Contest contest = activeContests.firstWhere((contest) => contest.contestId == contestId, orElse: null);
        if (contest != null) {
          activeContests.removeWhere((contest) => contest.contestId == contestId);
          _myEnteredActiveContests.add(contest);
        }

        return contestId;
      });
  }

  Future refreshContest(String contestId) {
    return _server.getPublicContest(contestId)
      .then((jsonMap) {
        lastContest = Contest.loadContestsFromJsonObject(jsonMap).first;
      });
  }

  Contest getAvailableNextContest() {
    if (_myEnteredActiveContests.isNotEmpty) {
      return _myEnteredActiveContests.first;
    }

    return activeContests.isNotEmpty ? activeContests.first : null;
  }

  ServerService _server;
  ProfileService _profileService;

  List<Contest> _myEnteredActiveContests = new List<Contest>();
}