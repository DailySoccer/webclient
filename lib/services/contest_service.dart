library contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/contests_pack.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class ContestService {

  ContestsPack activeContestsPack;

  ContestService(this._server);

  Future<ContestsPack> refreshActiveContests() {
    var completer = new Completer<ContestsPack>();

    _server.getActiveContestsPack()
        .then((response) {
          activeContestsPack = new ContestsPack.fromJsonObject(response);
          completer.complete(activeContestsPack);
        });

    return completer.future;
  }

  ServerService _server;
}