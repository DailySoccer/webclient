library contest;

import "package:json_object/json_object.dart";

class Contest {
  String id;
  String name;
  String groupId;
  int    maxPlayers;
  num    capSalary;
  List<String> playersListIds;

  Contest(this.id, this.name, this.groupId, this.maxPlayers, this.capSalary, this.playersListIds);

  Contest.initFromJSONObject(JsonObject json) {
    _initFromJSONObject(json);
  }

  Contest.initFromJSON(String json) {
    _initFromJSONObject(new JsonObject.fromJsonString(json));
  }

  _initFromJSONObject(JsonObject json) {
    id         = json.id;
    name       = json.name;
    groupId    = json.groupId;
    maxPlayers = json.maxPlayers;
    capSalary  = json.capSalary;

    print( "New Contest: $json" );
  }
}