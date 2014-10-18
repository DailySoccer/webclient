library contest_entry;

import "package:json_object/json_object.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/services/contest_references.dart';

class ContestEntry {
  String contestEntryId;

  User user;
  Contest contest;

  List<InstanceSoccerPlayer> instanceSoccerPlayers;

  int position;
  int prize;
  int fantasyPoints;

  int get currentLivePoints => instanceSoccerPlayers != null ? instanceSoccerPlayers.fold(0, (prev, instanceSoccerPlayer) => prev + instanceSoccerPlayer.soccerPlayer.currentLivePoints ) : 0;

  int get percentLeft {
    final int TOTAL = instanceSoccerPlayers.length * 90;
    int time = timeLeft;
    int percent = (time * 100) ~/ TOTAL;
    return (percent > 0) ? percent
                         : (time > 0) ? 1 : 0;
  }

  int get timeLeft {
    return instanceSoccerPlayers.fold(0, (prev, instanceSoccerPlayer) => prev + instanceSoccerPlayer.soccerTeam.matchEvent.minutesLeft);
  }

  bool contains(SoccerPlayer soccerPlayer) => instanceSoccerPlayers.any( (elem) => elem.soccerPlayer.templateSoccerPlayerId == soccerPlayer.templateSoccerPlayerId );

  ContestEntry(this.contestEntryId, this.user, this.instanceSoccerPlayers);

  ContestEntry.initFromJsonObject(JsonObject json, ContestReferences references, Contest theContest) {
    contestEntryId = json["_id"];
    user = references.getUserById(json.userId);

    // Enviado únicamente cuando se envíe usando jsonView.FullContest
    if (json.containsKey("soccerIds")) {
      instanceSoccerPlayers = json.soccerIds.map((soccerPlayerId) => theContest.getInstanceSoccerPlayer(soccerPlayerId)).toList();
    }

    position = (json.containsKey("position")) ? json.position : 0;
    prize = (json.containsKey("prize")) ? json.prize : 0;
    fantasyPoints = (json.containsKey("fantasyPoints")) ? json.fantasyPoints : 0;

    contest = theContest;

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
  }
}