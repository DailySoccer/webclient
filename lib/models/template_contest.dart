library template_contest;

import "package:json_object/json_object.dart";

class TemplateContest {
  String templateContestId;

  String name;
  String postName;

  int maxEntries;

  int salaryCap;
  int entryFee;
  String prizeType;

  List<String> templateMatchEventIds;

  TemplateContest(this.templateContestId, this.name, this.postName, this.maxEntries, this.salaryCap, this.entryFee, this.prizeType, this.templateMatchEventIds);

  TemplateContest.fromJsonObject(JsonObject json) {
    templateContestId = json._id;
    name = json.name;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    templateMatchEventIds = json.templateMatchEventIds;
    
    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
  }

  TemplateContest.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
}