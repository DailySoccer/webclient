library contests_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import "package:webclient/services/prizes_service.dart";
import "package:webclient/models/contest.dart";
import 'package:logging/logging.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/models/soccer_team.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/services/template_service.dart';


@Injectable()
class ContestsService {

  List<Contest> activeContests = new List<Contest>();
  List<Contest> waitingContests = new List<Contest>();
  List<Contest> liveContests = new List<Contest>();
  List<Contest> historyContests = new List<Contest>();

  bool get hasLiveContests    => liveContests     != null && liveContests.isNotEmpty;
  bool get hasWaitingContests => waitingContests  != null && waitingContests.isNotEmpty;
  bool get hasHistoryContests => historyContests  != null && historyContests.isNotEmpty;

  // El ultimo concurso que hemos cargado a traves de refreshContest
  Contest lastContest;

  Contest getContestById(String id) => _contests.containsKey(id) ? _contests[id] : null;

  ContestsService(this._server, this._profileService, this._prizesService);

  Future createContest(Contest contest, List<String> soccerPlayers) {
    // Al crear un contest se nos devuelve el contest recientemente creado
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.createContest(contest, soccerPlayers)])
      .then((List jsonMaps) {
        registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
        return lastContest;
      });
  }

  Future refreshMyCreateContest(String contestId) {
    Completer completer = new Completer();

    // TODO: Actualmente un contest recién creado lo deberíamos haber recibido en la propia query de la creación
    Contest contest = getContestById(contestId);
    if (contest != null) {
      lastContest = contest;
      completer.complete(true);
    }
    else {
      refreshActiveContest(contestId).then((_) {
        completer.complete(true);
      })
      .catchError((_) {
        completer.completeError(false);
      });
    }

    return completer.future;
  }

  Future getActiveTemplateContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getActiveTemplateContests()])
      .then((List jsonMaps) {
        return TemplateContest.loadTemplateContestsFromJsonObject(jsonMaps[1]);
      });
  }

  Future refreshActiveContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getActiveContests()])
      .then((List jsonMaps) {
        _initActiveContests(Contest.loadContestsFromJsonObject(jsonMaps[1]));
        
        // Actualización del UserProfile
        if (_profileService.isLoggedIn)
          _profileService.updateProfile();
      });
  }

  Future refreshActiveContest(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getActiveContest(contestId)])
      .then((List jsonMaps) {
        registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
      });
  }

  Future addContestEntry(String contestId, String formation, List<String> soccerPlayerIds) {
    return _server.addContestEntry(contestId, formation, soccerPlayerIds)
      .then((jsonMap) {
        String contestId = jsonMap["contestId"];

        // Actualizar las listas de activeContests (quitando el contest) y myContests (añadiendo el contest)
        Contest contest = activeContests.firstWhere((contest) => contest.contestId == contestId, orElse: () => null);
        if (contest != null) {
          activeContests.removeWhere((contest) => contest.contestId == contestId);
          _myEnteredActiveContests.add(contest);
        }

        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
        else {
          // Actualización del UserProfile
          if (_profileService.isLoggedIn)
            _profileService.updateProfile();
        }
        return contestId;
      });
  }

  Future refreshContestInfo(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getContestInfo(contestId)])
      .then((List jsonMaps) {
        registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
        _prizesService.loadFromJsonObject(jsonMaps[1]);
      });
  }

  Future cancelContestEntry(String contestEntryId) {
    return _server.cancelContestEntry(contestEntryId)
      .then((jsonMap) {
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
        else {
          // Actualización del UserProfile
          _profileService.updateProfile();
        }

        Logger.root.info("response: " + jsonMap.toString());
      });
  }

  Future editContestEntry(String contestId, String formation, List<String> soccerPlayerIds) {
    return _server.editContestEntry(contestId, formation, soccerPlayerIds)
      .then((jsonMap) {
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
        else {
          // Actualización del UserProfile
          if (_profileService.isLoggedIn)
            _profileService.updateProfile();
        }

        // Logger.root.info("response: " + jsonMap.toString());
      });
  }

  Future changeSoccerPlayer(String contestEntryId, String soccerPlayerId, String soccerPlayerIdNew) {
    return _server.changeSoccerPlayer(contestEntryId, soccerPlayerId, soccerPlayerIdNew)
      .then((jsonMap) {
        registerContest(Contest.loadContestsFromJsonObject(jsonMap).first);
        // Logger.root.info("response: " + jsonMap.toString());
        
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
        else {
          // Actualización del UserProfile
          _profileService.updateProfile();
        }
      });
  }

  Future refreshMyContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyContests()])
        .then((List jsonMaps) {
          _initMyContests(Contest.loadContestsFromJsonObject(jsonMaps[1]));
          _prizesService.loadFromJsonObject(jsonMaps[1]);

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }
          else {
            // Actualización del UserProfile
            if (_profileService.isLoggedIn)
              _profileService.updateProfile();
          }
        });
  }

  Future refreshMyActiveContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyActiveContests()])
        .then((List jsonMaps) {
          waitingContests = Contest.loadContestsFromJsonObject(jsonMaps[1])
            .. forEach((contest) => registerContest(contest));
          _prizesService.loadFromJsonObject(jsonMaps[1]);

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }
          else {
            // Actualización del UserProfile
            if (_profileService.isLoggedIn)
              _profileService.updateProfile();
          }
        });
  }

  Future refreshMyLiveContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyLiveContests()])
        .then((List jsonMaps) {
          liveContests = Contest.loadContestsFromJsonObject(jsonMaps[1])
            .. forEach((contest) => registerContest(contest));
          _prizesService.loadFromJsonObject(jsonMaps[1]);

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }
          else {
            // Actualización del UserProfile
            if (_profileService.isLoggedIn)
              _profileService.updateProfile();
          }
        });
  }

  Future refreshMyHistoryContests() {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyHistoryContests()])
        .then((List jsonMaps) {
          historyContests = Contest.loadContestsFromJsonObject(jsonMaps[1])
            .. forEach((contest) => registerContest(contest));
          _prizesService.loadFromJsonObject(jsonMaps[1]);

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }
          else {
            // Actualización del UserProfile
            if (_profileService.isLoggedIn)
              _profileService.updateProfile();
          }
        });
  }

  Future refreshMyActiveContest(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyActiveContest(contestId)])
        .then((List jsonMaps) {
          registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
        });
  }

  Future refreshMyContestEntry(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyContestEntry(contestId)])
        .then((List jsonMaps) {
          registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
        });
  }

  Future refreshMyLiveContest(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyLiveContest(contestId)])
        .then((List jsonMaps) {
          registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
          _prizesService.loadFromJsonObject(jsonMaps[1]);
        });
  }

  Future refreshMyHistoryContest(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getMyHistoryContest(contestId)])
        .then((List jsonMaps) {
          registerContest(Contest.loadContestsFromJsonObject(jsonMaps[1]).first);
          _prizesService.loadFromJsonObject(jsonMaps[1]);
        });
  }

  Future refreshLiveMatchEvents({String templateContestId: null, String contestId: null}) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), (templateContestId != null
        ? _server.getLiveMatchEventsFromTemplateContest(templateContestId)
        : _server.getLiveMatchEventsFromContest(contestId))])
      .then((List jsonMaps) {
          jsonMaps[1]["content"].forEach((jsonMap) {
            lastContest.matchEvents.firstWhere((matchEvent) => matchEvent.templateMatchEventId == (jsonMap.containsKey("templateMatchEventId") ? jsonMap["templateMatchEventId"] : jsonMap["_id"]))
                .. updateLiveInfo(jsonMap);
          });
      });
  }

  Future refreshLiveContestEntries(String contestId) {
    return Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getLiveContestEntries(contestId)])
      .then((List jsonMaps) {
          lastContest.updateContestEntriesFromJsonObject(jsonMaps[1]);
      });
  }
  
  Future getSoccerPlayersAvailablesToChange(String contestId) {
    var completer = new Completer();

    Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getSoccerPlayersAvailablesToChange(contestId)])
        .then((List jsonMaps) {
          TemplateReferences templateReferences = TemplateService.Instance.references;
          ContestReferences contestReferences = new ContestReferences();
          
          List<InstanceSoccerPlayer> instanceSoccerPlayers = [];

          if (jsonMaps[1].containsKey("instanceSoccerPlayers")) {
            jsonMaps[1]["instanceSoccerPlayers"].forEach((jsonObject) {
              instanceSoccerPlayers.add( new InstanceSoccerPlayer.initFromJsonObject(jsonObject, contestReferences) );
            });
          }

          if (jsonMaps[1].containsKey("soccer_players")) {
            jsonMaps[1]["soccer_players"].map((jsonObject) => new SoccerPlayer.fromJsonObject(jsonObject, templateReferences, contestReferences)).toList();
          }

          if (jsonMaps[1].containsKey("soccer_teams")) {
            jsonMaps[1]["soccer_teams"].map((jsonObject) => new SoccerTeam.fromJsonObject(jsonObject, templateReferences, contestReferences)).toList();
          }

          if (jsonMaps[1].containsKey("match_events")) {
            jsonMaps[1]["match_events"].map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
          }

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }
          else {
            // Actualización del UserProfile
            if (_profileService.isLoggedIn)
              _profileService.updateProfile();
          }

          completer.complete(instanceSoccerPlayers);
      });

    return completer.future;
  }

  Future<num> countMyLiveContests() {
    return _server.countMyLiveContests()
        .then((jsonMap) {
          return jsonMap["count"];
        });
  }

  Contest getAvailableNextContest() {
    if (_myEnteredActiveContests.isNotEmpty) {
      return _myEnteredActiveContests.first;
    }

    return activeContests.isNotEmpty ? activeContests.first : null;
  }

  void registerContest(Contest contest) {
    _contests[contest.contestId] = contest;
    lastContest = contest;
  }

  void _initActiveContests(List<Contest> contests) {
    int userLevel = _profileService.isLoggedIn ? _profileService.user.managerLevel.toInt() : 0;
    int userTrueSkill = _profileService.isLoggedIn ? _profileService.user.trueSkill : 0;

    activeContests = contests.where((contest) => contest.hasLevel(userLevel, userTrueSkill)).toList();
    activeContests.forEach((contest) => registerContest(contest));

    if (_profileService.isLoggedIn) {
      _myEnteredActiveContests = activeContests.where((contest) => contest.containsContestEntryWithUser(_profileService.user.userId)).toList();
      activeContests.removeWhere((contest) => contest.containsContestEntryWithUser(_profileService.user.userId));

      _myEnteredActiveContests.sort((A,B) => A.compareStartDateTo(B));
      activeContests.sort((A,B) => A.compareStartDateTo(B));
    }
  }

  void _initMyContests(List<Contest> contests) {
    contests.forEach((contest) => registerContest(contest));

    waitingContests = contests.where((contest) => contest.isActive).toList();
    liveContests = contests.where((contest) => contest.isLive).toList();
    historyContests = contests.where((contest) => contest.isHistory).toList();
  }

  ServerService _server;
  ProfileService _profileService;
  PrizesService _prizesService;

  List<Contest> _myEnteredActiveContests = new List<Contest>();
  Map<String, Contest> _contests = new Map<String, Contest>();
}