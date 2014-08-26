library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player_info.dart";


@Injectable()
class SoccerPlayerService {

  SoccerPlayerInfo soccerPlayerInfo;

  SoccerPlayerService(this._server);

  Future refreshSoccerPlayerInfo(String templateSoccerPlayerId) {
    var completer = new Completer();

    _server.getSoccerPlayerInfo(templateSoccerPlayerId)
        .then((jsonObject) {
          ContestReferences contestReferences = new ContestReferences();
          jsonObject.soccerTeams.forEach( (jsonTeam) =>
              new SoccerTeam.fromJsonObject(jsonTeam, contestReferences) );
          soccerPlayerInfo = new SoccerPlayerInfo.fromJsonObject(jsonObject.soccerPlayer, contestReferences);
          completer.complete();
        });

    return completer.future;
  }

  ServerService _server;
}