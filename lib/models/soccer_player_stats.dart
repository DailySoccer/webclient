library soccer_player_stats;
import 'dart:core';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/utils/string_utils.dart';

class SoccerPlayerStats {
  DateTime startDate;
  SoccerTeam opponentTeam;
  String optaCompetitionId;

  int fantasyPoints;
  int playedMinutes;

  Map<String, int> soccerPlayerStatValues = {};

  List get names => [
    getCodeData("keyplayedminutes"),
    getCodeData("keyfantasypoints") ,
    getCodeData("keygoals"),
    getCodeData("keyshots"),
    getCodeData("keypasses"),
    getCodeData("keychancescreated"),
    getCodeData("keytakeons") ,
    getCodeData("keyrecovers"),
    getCodeData("keyposslost"),
    getCodeData("keyfoulsconceded"),
    getCodeData("keyfoulscommited"),
    getCodeData("keyyellowcards"),
    getCodeData("keyredcards"),
    getCodeData("keygoalsconceded"),
    getCodeData("keysaves"),
    getCodeData("keyclearances"),
    getCodeData("keypenaltiessaved")
  ];

  static String getCodeData(String key) {
    return StringUtils.translate(key, "soccerplayerstats");
  }

  SoccerPlayerStats.fromJsonObject(Map jsonMap, ContestReferences references) {
    startDate = jsonMap.containsKey("startDate") ? DateTimeService.fromMillisecondsSinceEpoch(jsonMap["startDate"]) : DateTimeService.now;
    optaCompetitionId = jsonMap.containsKey("optaCompetitionId") && (jsonMap["optaCompetitionId"] != null) ? jsonMap["optaCompetitionId"] : "";
    opponentTeam = jsonMap.containsKey("opponentTeamId") ? references.getSoccerTeamById(jsonMap["opponentTeamId"]) : null;

    fantasyPoints = jsonMap.containsKey("fantasyPoints") && (jsonMap["fantasyPoints"]!=null)? jsonMap["fantasyPoints"] : 0;
    playedMinutes = jsonMap.containsKey("playedMinutes") && (jsonMap["playedMinutes"]!=null)? jsonMap["playedMinutes"] : 0;

    int _getIntValue(String key) => (jsonMap.containsKey("statsCount") && jsonMap["statsCount"].containsKey(key)) ? jsonMap["statsCount"][key] : 0;

    names.forEach((name) {

      soccerPlayerStatValues[name] = _getIntValue(name);
    });
  }

  bool hasPlayed() => (playedMinutes > 0) || (fantasyPoints != 0);
  bool hasPlayedInCompetition(String competitionId) => (optaCompetitionId == competitionId) && hasPlayed();
}