library template_contest;

import "package:json_object/json_object.dart";
import 'package:webclient/models/template_match_event.dart';
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class TemplateContest {
  String templateContestId;

  String state;
  String name;

  int maxEntries;

  int salaryCap;
  int entryFee;
  String prizeType;

  List<TemplateMatchEvent> templateMatchEvents;

  TemplateContest(this.templateContestId, this.name, this.maxEntries,
          this.salaryCap, this.entryFee, this.prizeType, this.templateMatchEvents);

  TemplateContest.referenceInit(this.templateContestId);

  bool get isActive => state == "ACTIVE";
  bool get isLive => state == "LIVE";
  bool get isHistory => state == "HISTORY";

  DateTime get startDate => templateMatchEvents.map((matchEvent) => matchEvent.startDate)
                                               .reduce((val, elem) => val.isBefore(elem)? val : elem);

  factory TemplateContest.fromJsonObject(JsonObject json, ContestReferences references) {
    return references.getTemplateContestById(json._id)._initFromJsonObject(json, references);
  }

  factory TemplateContest.fromJsonString(String json, ContestReferences references) {
    return new TemplateContest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;

    // Buscar en la lista de partidos del contest
    for (TemplateMatchEvent match in templateMatchEvents) {
      soccerPlayer = match.findSoccerPlayer(soccerPlayerId);

      // Lo hemos encontrado?
      if (soccerPlayer != null)
        break;
    }

    return soccerPlayer;
  }

  TemplateContest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateContestId.isNotEmpty);
    state = json.state;
    name = json.name;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    templateMatchEvents = json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();

    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
    return this;
  }
}