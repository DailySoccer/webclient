library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class SoccerPlayerService {

  SoccerPlayer soccerPlayer;
  MatchEvent nextMatchEvent;

  SoccerPlayerService(this._server);

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
}