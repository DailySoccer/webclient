library scoring_rules_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:json_object/json_object.dart';


@Injectable()
class ScoringRulesService {

  Map<String, int> scoringRules = new Map<String, int>();

  ScoringRulesService(this._server);

  Future refreshScoringRules() {
    return _server.getScoringRules()
      .then((jsonRoot) {
          initFromJsonObject(jsonRoot.scoring_rules);
        });
  }

  void initFromJsonObject(List<JsonObject> jsonRoot) {
    scoringRules = new Map.fromIterable(jsonRoot, key: (v) => v.eventName, value: (v) => v.points);
  }

  ServerService _server;
}