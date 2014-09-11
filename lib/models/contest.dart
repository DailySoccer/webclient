library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_contest.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';

class Contest {
  String contestId;

  String get name => templateContest.name;

  List<ContestEntry> contestEntries;
  int numEntries;

  int get maxEntries => templateContest.maxEntries;

  TemplateContest templateContest;

  String get description => "${templateContest.tournamentTypeName}: ${numEntries} de ${maxEntries} jugadores - LIM. SAL.: ${templateContest.salaryCap}";

  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  Contest(this.contestId, this.contestEntries, this.templateContest);

  Contest.referenceInit(this.contestId);

  ContestEntry getContestEntry(String contestEntryId) {
    return contestEntries.firstWhere( (entry) => entry.contestEntryId == contestEntryId, orElse: () => null );
  }

  ContestEntry getContestEntryWithUser(String userId) {
    return contestEntries.firstWhere( (entry) => entry.user.userId == userId, orElse: () => null );
  }

  int getUserPosition(ContestEntry contestEntry) {
    List<ContestEntry> contestsEntries = contestEntriesOrderByPoints;
    for (int i=0; i<contestsEntries.length; i++) {
      if (contestsEntries[i].contestEntryId == contestEntry.contestEntryId)
        return i+1;
    }
    return -1;
  }

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

    // Contest Entries?
    if (jsonRoot.containsKey("contest_entries")) {
      jsonRoot.contest_entries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject, contestReferences)).toList();
    }

    if (jsonRoot.containsKey("match_events")) {
      jsonRoot.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
    }
    else {
      // Aceptamos múltiples listas de partidos (con mayor o menor información)
      for (int view=0; view<10 && jsonRoot.containsKey("match_events_$view"); view++) {
          jsonRoot["match_events_$view"].map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
      }
    }

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

    contestEntries = json.containsKey("contestEntries") ? json.contestEntries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject, references) .. contest = this ).toList() : [];
    numEntries = json.containsKey("numEntries") ? json.numEntries : contestEntries.length;

    templateContest = references.getTemplateContestById(json.templateContestId);

    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    return this;
  }

  int compareNameTo(Contest cont){
    int comp = StringUtils.normalize(name).compareTo(StringUtils.normalize(cont.name));
    return comp != 0 ? comp : contestId.compareTo(cont.contestId);
  }

  int compareEntryFeeTo(Contest cont){
    int comp = templateContest.entryFee.compareTo(cont.templateContest.entryFee);
    return comp != 0 ? comp : contestId.compareTo(cont.contestId);
  }

  int compareStartDateTo(Contest cont){
    int comp = templateContest.startDate.compareTo(cont.templateContest.startDate);
    return comp != 0 ? comp : contestId.compareTo(cont.contestId);
  }
}