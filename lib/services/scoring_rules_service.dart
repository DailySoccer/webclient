library scoring_rules_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";


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
        .then((jsonMapRoot) {
            initFromJsonObject(jsonMapRoot["scoring_rules"]);
            completer.complete();
          });
    }

    return completer.future;
  }

  void initFromJsonObject(List<Map> jsonMapRoot) {
    scoringRules = new Map.fromIterable(jsonMapRoot, key: (v) => v["eventName"], value: (v) => v["points"]);
  }

  ServerService _server;
}