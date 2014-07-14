library template_contest;

import "package:json_object/json_object.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class TemplateContest {
  String templateContestId;

  String name;
  String postName;

  int maxEntries;

  int salaryCap;
  int entryFee;
  String prizeType;

  List<String> templateMatchEventIds;
  List<MatchEvent> templateMatchEvents;

  TemplateContest(this.templateContestId, this.name, this.postName, this.maxEntries,
          this.salaryCap, this.entryFee, this.prizeType, this.templateMatchEventIds);

  TemplateContest.referenceInit(this.templateContestId);
  
  factory TemplateContest.fromJsonObject(JsonObject json, ContestReferences references) {
    TemplateContest templateContest = references.getTemplateContestById(json._id);
    
    // templateContestId = json._id;
    templateContest.name = json.name;
    templateContest.maxEntries = json.maxEntries;
    templateContest.salaryCap = json.salaryCap;
    templateContest.entryFee = json.entryFee;
    templateContest.prizeType = json.prizeType;
    templateContest.templateMatchEventIds = json.templateMatchEventIds;
    templateContest.templateMatchEvents = json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();
    
    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
    
    return templateContest;
  }
  
  factory TemplateContest.fromJsonString(String json, ContestReferences references) {
    return new TemplateContest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }
  
  DateTime getStartDate() {
    return templateMatchEvents.map((matchEvent) => matchEvent.startDate)
                              .reduce((val, elem) => val.isBefore(elem)? val : elem);
  }
  
  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;
    
    // Buscar en la lista de partidos del contest
    for (MatchEvent match in templateMatchEvents) {
      SoccerPlayer soccer = match.findSoccerPlayer(soccerPlayerId);
      if (soccer != null) {
        soccerPlayer = soccer;
        break;
      }
    }
    
    return soccerPlayer;
  }
}