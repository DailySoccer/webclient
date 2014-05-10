library contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class ContestService {

  List<Contest> activeContests = new List<Contest>();
  List<MatchEvent> activeMatchEvents = new List<MatchEvent>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  MatchEvent getMatchEventById(String id) => activeMatchEvents.firstWhere((matchEvent) => matchEvent.matchEventId == id, orElse: () => null);

  List<MatchEvent> getMatchEventsForContest(Contest contest) => contest.matchEventIds.map((matchEventId) => getMatchEventById(matchEventId)).toList();

  DateTime getContestStartDate(Contest contest) {
    return getMatchEventsForContest(contest).map((matchEvent) => matchEvent.startDate)
                                            .reduce((val, elem) => val.isBefore(elem)? val : elem);
  }

  ContestService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    Future.wait([_server.getActiveContests(), _server.getActiveMatchEvents()])
        .then((List responses) {
          activeContests = responses[0].content.map((jsonObject) => new Contest.fromJsonObject(jsonObject)).toList();
          activeMatchEvents = responses[1].content.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject)).toList();
          completer.complete();
        });

    return completer.future;
  }

  ServerService _server;
}