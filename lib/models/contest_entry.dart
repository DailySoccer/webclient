library contest_entry;

import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/models/money.dart';
import 'package:webclient/services/contest_references.dart';

class ContestEntry {
  static const String FORMATION_442 = "442";
  static const String FORMATION_352 = "352";
  static const String FORMATION_433 = "433";
  static const String FORMATION_343 = "343";
  static const String FORMATION_451 = "451";

  String contestEntryId;

  User user;
  Contest contest;

  String formation = FORMATION_442;
  List<InstanceSoccerPlayer> instanceSoccerPlayers = [];
  List<InstanceSoccerPlayer> soccerPlayersPurchased = [];

  int position;
  Money prize;
  int fantasyPoints;

  int get currentLivePoints => instanceSoccerPlayers != null ? instanceSoccerPlayers.fold(0, (prev, instanceSoccerPlayer) => prev + instanceSoccerPlayer.soccerPlayer.currentLivePoints ) : 0;

  int get percentLeft {
    if (instanceSoccerPlayers.isEmpty) {
      return 100;
    }
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

  bool isPurchased(InstanceSoccerPlayer soccerPlayer) => soccerPlayersPurchased != null && soccerPlayersPurchased.contains(soccerPlayer);

  ContestEntry(this.contestEntryId, this.user, this.instanceSoccerPlayers);

  ContestEntry.initFromJsonObject(Map jsonMap, ContestReferences references, Contest theContest) {
    contestEntryId = jsonMap["_id"];
    user = references.getUserById(jsonMap["userId"]);

    formation = (jsonMap.containsKey("formation")) ? jsonMap["formation"] : FORMATION_442;

    // Enviado únicamente cuando se envíe usando jsonView.FullContest
    if (jsonMap.containsKey("soccerIds")) {
      instanceSoccerPlayers = jsonMap["soccerIds"].map((soccerPlayerId) => theContest.getInstanceSoccerPlayer(soccerPlayerId)).toList();
    }

    if (jsonMap.containsKey("playersPurchased") && jsonMap["playersPurchased"] != null) {
      soccerPlayersPurchased = jsonMap["playersPurchased"].map((soccerPlayerId) => theContest.getInstanceSoccerPlayer(soccerPlayerId)).toList();
    }

    position = (jsonMap.containsKey("position")) ? jsonMap["position"] : 0;
    prize = (jsonMap.containsKey("prize")) ? new Money.fromJsonObject(jsonMap["prize"]) : new Money.zero();
    fantasyPoints = (jsonMap.containsKey("fantasyPoints")) ? jsonMap["fantasyPoints"] : 0;

    contest = theContest;

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
  }
}