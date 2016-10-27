library contest_entry;

import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/models/money.dart';
import 'package:webclient/services/contest_references.dart';
import 'package:logging/logging.dart';

class ContestEntry {
  static const num MAX_CHANGES = 3;
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
  List<String> soccerPlayersChanged = [];

  num get numChanges => soccerPlayersChanged.length;
  num get numAvailableChanges => MAX_CHANGES - numChanges;
  
  int position;
  Money prize;
  int fantasyPoints;

  static Money DEFAULT_PRICE =  new Money.from(Money.CURRENCY_GOLD, 0);
  static List<Money> CHANGES_PRICE = [ new Money.from(Money.CURRENCY_GOLD, 0), 
                                       new Money.from(Money.CURRENCY_GOLD, 0), 
                                       new Money.from(Money.CURRENCY_GOLD, 0), 
                                       DEFAULT_PRICE
                                      ];
  
  Money changePrice() {
    int pricesIndex = numChanges;
    if (pricesIndex >= CHANGES_PRICE.length || pricesIndex < 0) {
      Logger.root.severe("WTF - 3535 - SoccerPlayer changes is requesting unknown change-price: index=$pricesIndex, MAX_CHANGES=$MAX_CHANGES, numChanges=$numChanges");
      return DEFAULT_PRICE;
    }
    return CHANGES_PRICE[pricesIndex];
  }

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

  bool isPurchased(InstanceSoccerPlayer instanceSoccerPlayer) => soccerPlayersPurchased != null 
      && soccerPlayersPurchased.any((instancePurchased) => instancePurchased.soccerPlayer.templateSoccerPlayerId == instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId);

  //ContestEntry(this.contestEntryId, this.user, this.instanceSoccerPlayers);

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

    if (jsonMap.containsKey("substitutions") && jsonMap["substitutions"] != null) {
      jsonMap["substitutions"].forEach((substitution) => soccerPlayersChanged.add("${substitution['source']} => ${substitution['target']}"));
    }

    position = (jsonMap.containsKey("position")) ? jsonMap["position"] : 0;
    prize = (jsonMap.containsKey("prize")) ? new Money.fromJsonObject(jsonMap["prize"]) : new Money.zero();
    fantasyPoints = (jsonMap.containsKey("fantasyPoints")) ? jsonMap["fantasyPoints"] : 0;

    contest = theContest;

    // print("ContestEntry: id($contestEntryId) userId($userId) contestId($contestId) soccerIds($soccerIds)");
  }
}