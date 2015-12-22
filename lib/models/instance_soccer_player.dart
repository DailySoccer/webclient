library instance_soccer_player;

import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:logging/logging.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/models/contest.dart';

class InstanceSoccerPlayer {
  static List<int> LEVEL_SALARY = [
    5600, 5700, 5800, 5900, 6000, 6200, 6400, 6700, 7500, 8000, 13000
    ];

  static List<int> LEVEL_PRICE = [
    0, 7, 16, 28, 43, 74, 135, 228, 350, 534, 903
    ];

  static List<num> LEVEL_MULTIPLIER = [
    0, 0.04378283713, 0.05429071804, 0.06654991243, 0.08143607706, 0.09894921191, 0.1204028021,  0.1457968476,  0.1760070053,  0.2127845884
    ];

  SoccerPlayer soccerPlayer;
  SoccerTeam soccerTeam;

  FieldPos fieldPos;
  int salary;

  int _level = -1;
  set level(lvl) => _level = lvl;
  int get level {
    // Si no se ha calculado el nivel del futbolista, lo calculamos
    if (_level < 0) {
      for (_level = 0; _level<LEVEL_SALARY.length && salary>LEVEL_SALARY[_level]; _level++) {
      }
    }
    return _level;
  }

  Money moneyToBuy(Contest contest, num managerLevel) {
    Money result = new Money.from(Money.CURRENCY_GOLD, 0);
    if (managerLevel < level) {
      num prize = contest.prizeMin.amount - contest.entryFee.amount;
      num sum = 0;
      for (int i=0; i<level; i++) {
        sum += LEVEL_MULTIPLIER[i] * prize;
      }
      result.amount = (contest.entryFee.amount + sum).round();
    }
    return result;
  }

  String get id => soccerPlayer.templateSoccerPlayerId;

  String get printableCurrentLivePoints => (soccerTeam.matchEvent.isStarted) ? StringUtils.parseFantasyPoints(soccerPlayer.currentLivePoints) : "-";

  List<Map> get printableLivePointsPerOptaEvent {
    List<Map> stats = new List<Map>();
    soccerPlayer.currentLivePointsPerOptaEvent.forEach((key, LiveEventInfo value) => stats.add({'name': SoccerPlayer.getEventName(key), 'count': value.count, 'points': StringUtils.parseFantasyPoints(value.points)}));
    stats.sort((elem0, elem1) => elem0["name"].compareTo(elem1["name"]) );
    return stats;
  }

  InstanceSoccerPlayer.initFromJsonObject(Map jsonMap, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(jsonMap["templateSoccerPlayerId"]);
    fieldPos = jsonMap.containsKey("fieldPos") ? new FieldPos(StringUtils.translate(jsonMap["fieldPos"].toString().toLowerCase(), "soccerplayerpositions")) : null;
    salary = jsonMap.containsKey("salary") ? jsonMap["salary"] : 0;
    soccerTeam = references.getSoccerTeamById(jsonMap["templateSoccerTeamId"]);
  }

  InstanceSoccerPlayer.init(String templateSoccerPlayerId, String templateSoccerTeamId, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(templateSoccerPlayerId);
    soccerTeam = references.getSoccerTeamById(templateSoccerTeamId);
  }
}