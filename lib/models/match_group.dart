library group;

import "package:json_object/json_object.dart";

class MatchGroup {
  String id;
  List<String> matchListIds;

  MatchGroup(this.id, this.matchListIds);

  MatchGroup.initFromJSONObject(JsonObject json) {
    _initFromJSONObject(json);
  }

  _initFromJSONObject(JsonObject json) {
    id           = json.id;
    matchListIds = json.matchListIds;
  }
}