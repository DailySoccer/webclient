library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_contest.dart";
import 'package:webclient/services/contest_references.dart';

class Contest {
  String contestId;

  String name;

  List<String> currentUserIds;
  int maxEntries;

  TemplateContest templateContest;

  Contest(this.contestId, this.name, this.currentUserIds, this.maxEntries, this.templateContest);
  
  Contest.referenceInit(this.contestId);
  
  factory Contest.fromJsonObject(JsonObject json, ContestReferences references) {
    Contest contest = references.getContestById(json._id);
    return contest._initFromJsonObject(json, references);
  }
  
  factory Contest.fromJsonString(String json, ContestReferences references) {
    return new Contest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }
  
  Contest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestId.isNotEmpty);
    
    name = json.name;
    currentUserIds = json.currentUserIds;
    maxEntries = json.maxEntries;
    templateContest = references.getTemplateContestById(json.templateContestId);
     
    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    return this;
  }
}