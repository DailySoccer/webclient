library contest_entry;

import "package:json_object/json_object.dart";
import 'package:webclient/services/contest_references.dart';

class ContestEntry {
  String contestEntryId;

  String userId;
  String contestId;
  
  List<String> soccerIds;

  ContestEntry(this.contestEntryId, this.userId, this.contestId, this.soccerIds);

  ContestEntry.referenceInit(this.contestEntryId);

  factory ContestEntry.fromJsonObject(JsonObject json, ContestReferences references) {
    ContestEntry contestEntry = references.getContestEntryById(json._id);
    return contestEntry._initFromJsonObject(json, references);
  }
  
  ContestEntry _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestEntryId.isNotEmpty);
    userId = json.userId;
    contestId = json.contestId;
    soccerIds = json.soccerIds.toList();

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
    return this;
  }
}