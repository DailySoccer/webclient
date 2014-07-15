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

  TemplateContest.fromJsonObject(JsonObject json) {
    templateContestId = json._id;
    name = json.name;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    templateMatchEventIds = json.templateMatchEventIds;
    // templateMatchEvents = json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();
    
    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
  }
  
  TemplateContest.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
  
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
  
  void linkReferences(ContestReferences references) {
    templateMatchEvents = templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();
  }
}