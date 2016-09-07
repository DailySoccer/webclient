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

  static const String STATE_NOT_PLAYED = "NOT PLAYED";
  static const String STATE_PLAYING = "PLAYING";
  static const String STATE_PLAYED = "PLAYED";
  
  static List<int> LEVEL_SALARY = [
    5600, 5700, 5800, 5900, 6000, 6200, 6400, 6700, 7500, 8000, 13000
    ];

  static List<num> LEVEL_BASE = [
    0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.7, 0.8, 0.9, 1.0
    ];
  
  static List<num> LEVEL_MULTIPLIER = [
    0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
    ];

  SoccerPlayer soccerPlayer;
  SoccerTeam soccerTeam;

  FieldPos fieldPos;
  int salary;
  
  String playState = STATE_NOT_PLAYED;

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
      result.amount = contest.entryFee.amount * LEVEL_BASE[managerLevel.toInt()] * LEVEL_MULTIPLIER[level - managerLevel.toInt()];
      result.amount = (result.amount).round();
    }
    return result;
  }

  String get id => soccerPlayer.templateSoccerPlayerId;

  bool get hasFullInformation => soccerPlayer.hasFullInformation && soccerTeam.hasFullInformation;
  
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
    soccerTeam.addSoccerPlayer(soccerPlayer);
  }

  InstanceSoccerPlayer.init(String templateSoccerPlayerId, String templateSoccerTeamId, ContestReferences references) {
    soccerPlayer = references.getSoccerPlayerById(templateSoccerPlayerId);

    soccerTeam = references.getSoccerTeamById(templateSoccerTeamId);
    soccerTeam.addSoccerPlayer(soccerPlayer);
  }
}