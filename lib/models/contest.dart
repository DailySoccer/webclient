library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import 'package:webclient/services/contest_references.dart';

class Contest {
  String contestId;

  String name;

  List<ContestEntry> contestEntries;
  int maxEntries;

  TemplateContest templateContest;

  Contest(this.contestId, this.name, this.contestEntries, this.maxEntries, this.templateContest);
  
  Contest.referenceInit(this.contestId);

  /*
   * Carga una LISTA de Contests a partir de JsonObjects
   */
  static List<Contest> loadContestsFromJsonObject(JsonObject jsonRoot) {
    var contests = new List<Contest>();
    
    ContestReferences contestReferences = new ContestReferences();
    
    // 1 Contest? -> 1 TemplateContest
    if (jsonRoot.containsKey("contest")) {
      var templateContest = new TemplateContest.fromJsonObject(jsonRoot.template_contest, contestReferences);
      contests.add(new Contest.fromJsonObject(jsonRoot.contest, contestReferences));
    }
    // >1 Contests!
    else {
      jsonRoot.template_contests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject, contestReferences)).toList();
      contests = jsonRoot.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList();
    }
    
    jsonRoot.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
    
    if (jsonRoot.containsKey("users_info")) {
      jsonRoot.users_info.map((jsonObject) => new User.fromJsonObject(jsonObject, contestReferences)).toList();
    }
    
    return contests;
  }
  
  /*
   * Factorias de creacion de un Contest
   */
  factory Contest.fromJsonObject(JsonObject json, ContestReferences references) {
    return references.getContestById(json._id)._initFromJsonObject(json, references);
  }

  
  /*
   * Inicializacion de los contenidos de un Contest
   */
  Contest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestId.isNotEmpty);
    
    name = json.name;
    contestEntries = json.contestEntries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject, references) .. contest = this ).toList();
    maxEntries = json.maxEntries;
    templateContest = references.getTemplateContestById(json.templateContestId);
     
    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    return this;
  }
}