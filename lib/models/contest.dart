library contest;

import "package:json_object/json_object.dart";
import "template_contest.dart";

class Contest {
  String contestId;

  String name;

  List<String> currentUserIds;
  int maxUsers;

  String templateContestId;

  Contest(this.contestId, this.name, this.currentUserIds, this.maxUsers, this.templateContestId);

  Contest.fromJsonObject(JsonObject json) {
     contestId = json._id;
     name = json.name;
     currentUserIds = json.currentUserIds;
     maxUsers = json.maxUsers;
     templateContestId = json.templateContestId;
     
     // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
  }

  Contest.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
}