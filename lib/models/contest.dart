library contest;

import "package:json_object/json_object.dart";

class Contest {
  String contestId;

  String name;

  int currentEntries;
  int maxEntries;

  int salaryCap;
  int entryFee;
  String prizeType;

  List<String> matchEventIds;

  Contest(this.contestId, this.name, this.currentEntries, this.maxEntries,
          this.salaryCap, this.entryFee, this.prizeType, this.matchEventIds);

  Contest.fromJsonObject(JsonObject json) {
     contestId = json._id;
     name = json.name;
     currentEntries = json.currentEntries;
     maxEntries = json.maxEntries;
     salaryCap = json.salaryCap;
     entryFee = json.entryFee;
     prizeType = json.prizeType;
     matchEventIds = json.matchEventIds;
  }

  Contest.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
}