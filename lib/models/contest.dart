library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_contest.dart";
import 'package:webclient/services/contest_references.dart';

class Contest {
  String contestId;

  String name;

  List<String> currentUserIds;
  int maxEntries;

  String templateContestId;
  TemplateContest templateContest;

  Contest(this.contestId, this.name, this.currentUserIds, this.maxEntries, this.templateContestId);
  
  Contest.fromJsonObject(JsonObject json) {
    contestId = json._id;
    name = json.name;
    currentUserIds = json.currentUserIds;
    maxEntries = json.maxEntries;
    templateContestId = json.templateContestId;
    // templateContest = references.getTemplateContestById(json.templateContestId);
    
    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
  }
  
  Contest.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
  
  void linkReferences(ContestReferences references) {
    templateContest = references.getTemplateContestById(templateContestId);
  }
}