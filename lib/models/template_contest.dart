library template_contest;

import "package:json_object/json_object.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class TemplateContest {
  String templateContestId;

  String state;
  String name;
  String postName;

  int maxEntries;

  int salaryCap;
  int entryFee;
  String prizeType;

  List<MatchEvent> templateMatchEvents;

  TemplateContest(this.templateContestId, this.name, this.postName, this.maxEntries,
          this.salaryCap, this.entryFee, this.prizeType, this.templateMatchEvents);

  TemplateContest.referenceInit(this.templateContestId);
  
  bool get isActive => state == "ACTIVE";
  bool get isLive => state == "LIVE";
  bool get isHistory => state == "HISTORY";
  
  DateTime get startDate => templateMatchEvents.map((matchEvent) => matchEvent.startDate)
                                               .reduce((val, elem) => val.isBefore(elem)? val : elem);

  factory TemplateContest.fromJsonObject(JsonObject json, ContestReferences references) {
    TemplateContest templateContest = references.getTemplateContestById(json._id);
    return templateContest._initFromJsonObject(json, references);
  }
  
  factory TemplateContest.fromJsonString(String json, ContestReferences references) {
    return new TemplateContest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }
  
  TemplateContest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateContestId.isNotEmpty);
    state = json.state;
    name = json.name;
    postName = json.postName;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    templateMatchEvents = json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();
    
    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
    return this;
  }
}