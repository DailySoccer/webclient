library instance_soccer_player;

import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:logging/logging.dart';
import 'package:webclient/models/money.dart';

class InstanceSoccerPlayer {
  static List<int> LEVEL_SALARY = [
      6100, 6500, 6900, 7300, 8000, 100000, 100000, 100000, 100000, 100000, 100000
    ];

  static List<int> LEVEL_PRICE = [
      0, 3, 7, 15, 30, 59, 63, 63, 63, 63, 63
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

  Money moneyToBuy(num managerLevel) {
    Money result = new Money.from(Money.CURRENCY_GOLD, 0);
    if (managerLevel < level) {
      // Diferencia de nivel * precio del nivel
      result.amount += (level - managerLevel.toInt()) * LEVEL_PRICE[level];
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