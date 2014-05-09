library contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class ContestService {

  Iterable<Contest> activeContests;
  Iterable<MatchEvent> activeMatchEvents;

  ContestService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    Future.wait([_server.getActiveContests(), _server.getActiveMatchEvents()])
        .then((List responses) {
          activeContests = responses[0].content;
          activeMatchEvents = responses[1].content;
          completer.complete();
        });

    return completer.future;
  }

  ServerService _server;
}