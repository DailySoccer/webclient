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

  List<SoccerPlayer> soccers;

  int get currentLivePoints => soccers.fold(0, (prev, soccerPlayer) => prev + soccerPlayer.currentLivePoints );

  ContestEntry(this.contestEntryId, this.user, this.soccers);

  ContestEntry.referenceInit(this.contestEntryId);

  factory ContestEntry.fromJsonObject(JsonObject json, ContestReferences references) {
    ContestEntry contestEntry = references.getContestEntryById(json._id);
    return contestEntry._initFromJsonObject(json, references);
  }

  ContestEntry _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestEntryId.isNotEmpty);
    user = references.getUserById(json.userId);

    // Enviado únicamente cuando se envíe usando jsonView.FullContest
    if (json.containsKey("soccerIds")) {
      soccers = json.soccerIds.map((soccerPlayerId) => references.getSoccerPlayerById(soccerPlayerId)).toList();
    }

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
    return this;
  }
}