library contests_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import "package:webclient/models/contest.dart";


@Injectable()
class ContestsService {

  List<Contest> activeContests = new List<Contest>();
  List<Contest> waitingContests = new List<Contest>();
  List<Contest> liveContests = new List<Contest>();
  List<Contest> historyContests = new List<Contest>();

  // El ultimo concurso que hemos cargado a traves de refreshContest
  Contest lastContest;

  Contest getContestById(String id) => _contests.containsKey(id) ? _contests[id] : null;

  ContestsService(this._server, this._profileService);

  void clear() {
    activeContests.clear();
    waitingContests.clear();
    liveContests.clear();
    historyContests.clear();
    _myEnteredActiveContests.clear();
  }

  Future refreshActiveContests() {
    return _server.getActiveContests()
      .then((jsonMap) {
        activeContests = Contest.loadContestsFromJsonObject(jsonMap);
        activeContests.forEach((contest) => _registerContest(contest));

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

  Future refreshPublicContest(String contestId) {
    return _server.getPublicContest(contestId)
      .then((jsonMap) {
        _registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
      });
  }

  Future cancelContestEntry(String contestEntryId) {
    var completer = new Completer();

    _server.cancelContestEntry(contestEntryId)
      .then((jsonMap) {
        print("response: " + jsonMap.toString());
        completer.complete();
      });

    return completer.future;
  }

  Future editContestEntry(String contestId, List<String> soccerPlayerIds) {
    var completer = new Completer();

    _server.editContestEntry(contestId, soccerPlayerIds)
      .then((jsonMap) {
        print("response: " + jsonMap.toString());
        completer.complete();
      });

    return completer.future;
  }

  Future refreshMyContests() {
    var completer = new Completer();

    _server.getMyContests()
        .then((jsonMap) {
          _initContests (Contest.loadContestsFromJsonObject(jsonMap));
          completer.complete(jsonMap);
        });

    return completer.future;
  }

  Future refreshMyContest(String contestId) {
    var completer = new Completer();

    _server.getMyContest(contestId)
        .then((jsonMap) {
          _registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
          completer.complete(jsonMap);
        });

    return completer.future;
  }

  Future refreshMyContestEntry(String contestId) {
    var completer = new Completer();

    _server.getMyContestEntry(contestId)
        .then((jsonMap) {
          _registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
          completer.complete(jsonMap);
        });

    return completer.future;
  }

  Future refreshFullContest(String contestId) {
    var completer = new Completer();

    _server.getFullContest(contestId)
        .then((jsonMap) {
          _registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
          completer.complete(jsonMap);
        });

    return completer.future;
  }

  Future refreshViewContest(String contestId) {
    var completer = new Completer();

    _server.getViewContest(contestId)
        .then((jsonMap) {
          _registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
          completer.complete(jsonMap);
        });

    return completer.future;
  }

  Future refreshLiveMatchEvents(String templateContestId) {
    var completer = new Completer();

    _server.getLiveMatchEventsFromTemplateContest(templateContestId)
      .then((jsonMap) {
          jsonMap["content"].forEach((jsonMap) {
            lastContest.matchEvents.firstWhere((matchEvent) => matchEvent.templateMatchEventId == (jsonMap.containsKey("templateMatchEventId") ? jsonMap["templateMatchEventId"] : jsonMap["_id"]))
                .. updateLiveInfo(jsonMap);
        });
        completer.complete(jsonMap);
      });

    return completer.future;
  }

  Contest getAvailableNextContest() {
    if (_myEnteredActiveContests.isNotEmpty) {
      return _myEnteredActiveContests.first;
    }

    return activeContests.isNotEmpty ? activeContests.first : null;
  }

  void _initContests(List<Contest> contests) {
    waitingContests = contests.where((contest) => contest.isActive).toList();
    liveContests = contests.where((contest) => contest.isLive).toList();
    historyContests = contests.where((contest) => contest.isHistory).toList();
  }

  void _registerContest(Contest contest) {
    _contests[contest.contestId] = contest;
    lastContest = contest;
  }

  ServerService _server;
  ProfileService _profileService;

  List<Contest> _myEnteredActiveContests = new List<Contest>();
  Map<String, Contest> _contests = new Map<String, Contest>();
}