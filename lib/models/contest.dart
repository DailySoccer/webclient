library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/services/contest_references.dart';

class Contest {
  String contestId;

  String name;

  List<String> currentUserIds;
  int maxEntries;

  TemplateContest templateContest;

  Contest(this.contestId, this.name, this.currentUserIds, this.maxEntries, this.templateContest);
  
  Contest.referenceInit(this.contestId);

  /*
   * Carga 1 Contest a partir de JsonObjects  (1 Contest <- 1 TemplateContest <- * MatchEvent)
   */
  static Contest loadContestFromJsonObjects(JsonObject jsonContest, JsonObject jsonTemplateContest, List<JsonObject> jsonMatchEvents) {
    ContestReferences contestReferences = new ContestReferences();
    // Carga las referencias de TemplateContest y MatchEvents
    var templateContest = new TemplateContest.fromJsonObject(jsonTemplateContest, contestReferences);
    var matchEvents = jsonMatchEvents.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
    // Devuelve los Contests que contiene referenciado/referenciado a su TemplateContest
    return new Contest.fromJsonObject(jsonContest, contestReferences);
  }
  
  static Contest loadContestFromJsonRoot(JsonObject jsonRoot) {
    return loadContestFromJsonObjects(jsonRoot.contest, jsonRoot.template_contest, jsonRoot.match_events);
  }
  
  /*
   * Carga una LISTA de Contests a partir de JsonObjects
   */
  static List<Contest> loadContestsFromJsonObjects(List<JsonObject> jsonContests, List<JsonObject> jsonTemplateContests, List<JsonObject> jsonMatchEvents) {
    ContestReferences contestReferences = new ContestReferences();
    // Carga las referencias de TemplateContests y MatchEvents
    jsonTemplateContests.map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject, contestReferences)).toList();
    jsonMatchEvents.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
    // Devuelve los Contests (que contienen referenciados/incrustados a sus TemplateContests)
    return jsonContests.map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList();
  }
  
  static List<Contest> loadContestsFromJsonRoot(JsonObject jsonRoot) {
    return loadContestsFromJsonObjects(jsonRoot.contests, jsonRoot.template_contests, jsonRoot.match_events);
  }
  
  /*
   * Factorias de creacion de un Contest
   */
  factory Contest.fromJsonObject(JsonObject json, ContestReferences references) {
    Contest contest = references.getContestById(json._id);
    return contest._initFromJsonObject(json, references);
  }
  
  factory Contest.fromJsonString(String json, ContestReferences references) {
    return new Contest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }
  
  /*
   * Inicializacion de los contenidos de un Contest
   */
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