library group;

import "package:json_object/json_object.dart";

class MatchGroup {
  String matchGroupId;
  List<String> matchEventIds;

  MatchGroup(this.matchGroupId, this.matchEventIds);

  MatchGroup.fromJsonObject(JsonObject json) {
    matchGroupId = json.matchGroupId;
    matchEventIds = json.matchEventIds;
  }
}