library scoring_rules_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:json_object/json_object.dart';


@Injectable()
class ScoringRulesService {

  Map<String, int> scoringRules = null;

  ScoringRulesService(this._server);

  Future refreshScoringRules() {
    var completer = new Completer();

    // Tenemos cargada la tabla de puntos?
    if (scoringRules != null) {
      completer.complete();
    }
    else {
      // Solicitamos al server la tabla de puntos
      _server.getScoringRules()
        .then((jsonRoot) {
            initFromJsonObject(jsonRoot.scoring_rules);
            completer.complete();
          });
    }

    return completer.future;
  }

  void initFromJsonObject(List<JsonObject> jsonRoot) {
    scoringRules = new Map.fromIterable(jsonRoot, key: (v) => v.eventName, value: (v) => v.points);
  }

  ServerService _server;
}