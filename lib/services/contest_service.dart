library contest_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";


@Injectable()
class ContestService {

  List<Contest> activeContests = new List<Contest>();
  List<TemplateContest> activeTemplateContests = new List<TemplateContest>();
  List<MatchEvent> activeMatchEvents = new List<MatchEvent>();

  Contest getContestById(String id) => activeContests.firstWhere((contest) => contest.contestId == id, orElse: () => null);
  TemplateContest getTemplateContestById(String id) => activeTemplateContests.firstWhere((templateContest) => templateContest.templateContestId == id, orElse: () => null);
  MatchEvent getMatchEventById(String id) => activeMatchEvents.firstWhere((matchEvent) => matchEvent.matchEventId == id, orElse: () => null);

  int getSalaryCapForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.salaryCap : -1;
  }

  int getEntryFeeForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.entryFee : -1;
  }

  String getPrizeTypeForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? template.prizeType : "<>";
  }

  List<MatchEvent> getMatchEventsForTemplateContest(TemplateContest template) {
    // Cached value (pq "Observer reaction functions should not change model.")
    if (!_templateMatchEvents.containsKey(template.templateContestId)) {
      _templateMatchEvents[template.templateContestId] = template.templateMatchEventIds.map((matchEventId) => getMatchEventById(matchEventId)).toList();
    }
    return _templateMatchEvents[template.templateContestId];
  }

  List<MatchEvent> getMatchEventsForContest(Contest contest) {
    var template = getTemplateContestById(contest.templateContestId);
    return (template != null) ? getMatchEventsForTemplateContest(template) : null;
   }

  DateTime getContestStartDate(Contest contest) {
    return getMatchEventsForContest(contest).map((matchEvent) => matchEvent.startDate)
                                            .reduce((val, elem) => val.isBefore(elem)? val : elem);
  }

  ContestService(this._server);

  Future refreshActiveContests() {
    var completer = new Completer();

    _server.getActiveContests()
        .then((jsonObject) {
          activeMatchEvents = jsonObject.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject)).toList();
          activeTemplateContests = jsonObject.template_contests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject)).toList();
          activeContests = jsonObject.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject)).toList();
          completer.complete();
        });

    return completer.future;
  }

  var _templateMatchEvents = new Map<String, List<MatchEvent>>();
  ServerService _server;
}