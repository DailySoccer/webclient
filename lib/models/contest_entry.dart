library contest_entry;

import "package:json_object/json_object.dart";

class ContestEntry {
  String contestEntryId;

  String userId;
  String contestId;
  
  List<String> soccerIds;

  ContestEntry(this.contestEntryId, this.userId, this.contestId, this.soccerIds);

  ContestEntry.fromJsonObject(JsonObject json) {
    contestEntryId = json._id;
    userId = json.userId;
    contestId = json.contestId;
    soccerIds = json.soccerIds.toList();

    print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
  }

  ContestEntry.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
}