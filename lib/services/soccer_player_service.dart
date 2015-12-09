library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/contest.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/services/contests_service.dart';


@Injectable()
class SoccerPlayerService {

  InstanceSoccerPlayer instanceSoccerPlayer;
  SoccerPlayer soccerPlayer;
  MatchEvent nextMatchEvent;

  SoccerPlayerService(this._server, this._contestsService);

  // InstanceSoccerPlayer en cualquiera de los ultimos concursos recibidos
  InstanceSoccerPlayer getInstanceSoccerPlayer(String contestId, String instanceSoccerPlayerId) {

    InstanceSoccerPlayer ret = null;

    Contest contest = _contestsService.getContestById(contestId);
    if (contest != null) {
      ret = contest.getInstanceSoccerPlayer(instanceSoccerPlayerId);
    }

    return ret;
  }

  Future refreshInstancePlayerInfo(String contestId, String instanceSoccerPlayerId) {
    var completer = new Completer();

    _server.getInstancePlayerInfo(contestId, instanceSoccerPlayerId)
        .then((jsonMap) {
          ContestReferences contestReferences = new ContestReferences();

          nextMatchEvent = jsonMap.containsKey("match_event") ? new MatchEvent.fromJsonObject(jsonMap["match_event"], contestReferences) : null;
          jsonMap["soccer_teams"].forEach( (jsonTeam) =>
              new SoccerTeam.fromJsonObject(jsonTeam, contestReferences) );
          soccerPlayer = new SoccerPlayer.fromJsonObject(jsonMap["soccer_player"], contestReferences);
          instanceSoccerPlayer = new InstanceSoccerPlayer.initFromJsonObject(jsonMap["instance_soccer_player"], contestReferences);
          completer.complete();
        });

    return completer.future;
  }

  Future getSoccerPlayersByCompetition(String competitionId) {
    var completer = new Completer();

    _server.getSoccerPlayersByCompetition(competitionId)
        .then((jsonMap) {
          ContestReferences contestReferences = new ContestReferences();
          List<InstanceSoccerPlayer> instanceSoccerPlayers = [];

          if (jsonMap.containsKey("instanceSoccerPlayers")) {
            jsonMap["instanceSoccerPlayers"].forEach((jsonObject) {
              instanceSoccerPlayers.add( new InstanceSoccerPlayer.initFromJsonObject(jsonObject, contestReferences) );
            });
          }

          if (jsonMap.containsKey("soccer_players")) {
            jsonMap["soccer_players"].map((jsonMap) => new SoccerPlayer.fromJsonObject(jsonMap, contestReferences)).toList();
          }

          if (jsonMap.containsKey("soccer_teams")) {
            jsonMap["soccer_teams"].forEach( (jsonTeam) =>
                new SoccerTeam.fromJsonObject(jsonTeam, contestReferences) );
          }

          completer.complete(instanceSoccerPlayers);
        });

    return completer.future;
  }

  ServerService _server;

  ContestsService _contestsService;
}