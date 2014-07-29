library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/soccer_player_info.dart";


@Injectable()
class SoccerPlayerService {

  SoccerPlayerInfo soccerPlayerInfo;

  SoccerPlayerService(this._server);

  Future refreshSoccerPlayerInfo(String templateSoccerPlayerId) {
    var completer = new Completer();

    _server.getSoccerPlayerInfo(templateSoccerPlayerId)
        .then((jsonObject) {
          soccerPlayerInfo = new SoccerPlayerInfo.fromJsonObject(jsonObject);
          completer.complete();
        });

    return completer.future;
  }

  ServerService _server;
}