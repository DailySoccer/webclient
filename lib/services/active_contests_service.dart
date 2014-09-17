library active_contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import "package:webclient/models/contest.dart";


@Injectable()
class ActiveContestsService {

  List<Contest> activeContests = new List<Contest>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);

  // El ultimo concurso que hemos cargado a traves de getContest
  Contest lastContest;

  ActiveContestsService(this._server, this._profileService);

  Future refreshActiveContests() {
    return _server.getActiveContests()
      .then((jsonObject) {
        activeContests = Contest.loadContestsFromJsonObject(jsonObject);

        if (_profileService.isLoggedIn) {
          // Quitar los contests en los que esté inscrito el usuario
          activeContests.removeWhere((contest) => contest.containsContestEntryWithUser(_profileService.user.userId));
        }
      });
  }

  Future addContestEntry(String contestId, List<String> soccerPlayerIds) {
    return _server.addContestEntry(contestId, soccerPlayerIds)
      .then((jsonObject) {
        print("response: " + jsonObject.toString());
        return jsonObject.contestId;
      });
  }

  Future refreshContest(String contestId) {
    return _server.getContestInfo(contestId)
      .then((jsonObject) {
        lastContest = Contest.loadContestsFromJsonObject(jsonObject).first;
      });
  }

  ServerService _server;
  ProfileService _profileService;
}