library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';


@Injectable()
class SoccerPlayerService {

  SoccerPlayer soccerPlayer;
  MatchEvent nextMatchEvent;

  SoccerPlayerService(this._server, this._activeContestsService, this._myContestsService);

  // InstanceSoccerPlayer en cualquiera de los ultimos concursos recibidos, tanto Active como My.
  InstanceSoccerPlayer getInstanceSoccerPlayer(String contestId, String instanceSoccerPlayerId) {

    InstanceSoccerPlayer ret = null;

    if (_activeContestsService.lastContest != null && _activeContestsService.lastContest.contestId == contestId) {
      ret = _activeContestsService.lastContest.getInstanceSoccerPlayer(instanceSoccerPlayerId);
    }
    else if (_myContestsService.lastContest != null && _myContestsService.lastContest.contestId == contestId) {
      ret = _myContestsService.lastContest.getInstanceSoccerPlayer(instanceSoccerPlayerId);
    }

    return ret;
  }

  Future refreshSoccerPlayerInfo(String templateSoccerPlayerId) {
    var completer = new Completer();

    _server.getSoccerPlayerInfo(templateSoccerPlayerId)
        .then((jsonMap) {
          ContestReferences contestReferences = new ContestReferences();

          nextMatchEvent = jsonMap.containsKey("match_event") ? new MatchEvent.fromJsonObject(jsonMap["match_event"], contestReferences) : null;
          jsonMap["soccer_teams"].forEach( (jsonTeam) =>
              new SoccerTeam.fromJsonObject(jsonTeam, contestReferences) );
          soccerPlayer = new SoccerPlayer.fromJsonObject(jsonMap["soccer_player"], contestReferences);
          completer.complete();
        });

    return completer.future;
  }

  ServerService _server;

  ActiveContestsService _activeContestsService;
  MyContestsService _myContestsService;
}