library contest_entry;

import "package:json_object/json_object.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/contest.dart";
import 'package:webclient/services/contest_references.dart';

class ContestEntry {
  String contestEntryId;

  User user;
  Contest contest;
  String contestId;
  
  List<SoccerPlayer> soccers;

  ContestEntry(this.contestEntryId, this.user, this.contestId, this.soccers);

  ContestEntry.referenceInit(this.contestEntryId);

  factory ContestEntry.fromJsonObject(JsonObject json, ContestReferences references) {
    ContestEntry contestEntry = references.getContestEntryById(json._id);
    return contestEntry._initFromJsonObject(json, references);
  }
  
  ContestEntry _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestEntryId.isNotEmpty);
    user = references.getUserById(json.userId);
    soccers = json.soccerIds.map((soccerPlayerId) => references.getSoccerPlayerById(soccerPlayerId)).toList();

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
    return this;
  }
}