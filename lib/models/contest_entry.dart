library contest_entry;

import "package:json_object/json_object.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/services/contest_references.dart';

class ContestEntry {
  String contestEntryId;

  User user;
  Contest contest;

  List<SoccerPlayer> soccers;

  int position;
  int prize;
  int fantasyPoints;

  int get currentLivePoints => soccers != null ? soccers.fold(0, (prev, soccerPlayer) => prev + soccerPlayer.currentLivePoints ) : 0;

  int get timeLeft {
    // Buscar los partidos en los que participan nuestro fantasyTeam
    Set<MatchEvent> matchEvents = new Set<MatchEvent>();
    for (SoccerPlayer soccerPlayer in soccers) {
      matchEvents.add(soccerPlayer.team.matchEvent);
    }
    // Calcular cuántas "media partes" quedan...
    return matchEvents.fold(0, (prev, matchEvent) => prev + matchEvent.halfTimesLeft);
  }

  bool contains(SoccerPlayer soccerPlayer) => soccers.any( (elem) => elem.templateSoccerPlayerId == soccerPlayer.templateSoccerPlayerId );

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

    position = (json.containsKey("position")) ? json.position : 0;
    prize = (json.containsKey("prize")) ? json.prize : 0;
    fantasyPoints = (json.containsKey("fantasyPoints")) ? json.fantasyPoints : 0;

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
    return this;
  }
}