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
  
  Contest.referenceInit(this.contestId);
  
  factory Contest.fromJsonObject(JsonObject json, ContestReferences references) {
    Contest contest = references.getContestById(json._id);
    
    // contest.contestId = json._id;
    contest.name = json.name;
    contest.currentUserIds = json.currentUserIds;
    contest.maxEntries = json.maxEntries;
    contest.templateContestId = json.templateContestId;
    contest.templateContest = references.getTemplateContestById(json.templateContestId);
    
    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    
    return contest;
  }
  
  factory Contest.fromJsonString(String json, ContestReferences references) {
    return new Contest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }
}