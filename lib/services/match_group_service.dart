library match_group_service;

import 'dart:async';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';

import "package:webclient/services/match_service.dart";
import "package:webclient/services/server_service.dart";
import "package:webclient/models/match_group.dart";

@Injectable()
class MatchGroupService {

  bool isSynchronized = false;

  // The group starts whenever the first match in the group starts
  String getMatchGroupStartDate(String groupId) => _matchService.getMatchStartDate(_groups[groupId].matchsIds[0]);

  MatchGroupService(this._server, this._matchService);

  Future sync() {
    if (!isSynchronized) {
      return getAllMatchGroups();
    }
    return new Future.value(true);
  }

  Future< List<MatchGroup> > getAllMatchGroups() {
    Logger.root.info("MatchGroup: all");

    return _matchService.sync()
        .then((_) => _server.getAllMatchGroups())
        .then((response) {
          isSynchronized = true;

          Logger.root.info("response: $response");

          // Inicialización del mapa de grupos de partidos
          _groups = new Map<String, MatchGroup>();
          for (var x in response) {
            Logger.root.info("group: ${x.id}: $x");
            _groups[x.id] = new MatchGroup.fromJsonObject(x);
          }

          // Devolver el map en formato lista
          // TODO: ¿usar _matchGroups.values?
          var list = new List<MatchGroup>();
          _groups.forEach((k,v) => list.add(v));
          return list;
        });
  }

  ServerService _server;
  MatchService  _matchService;
  var _groups;
}