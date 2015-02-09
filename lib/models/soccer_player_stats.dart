library soccer_player_stats;
import 'dart:core';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contest_references.dart';

class SoccerPlayerStats {
  DateTime startDate;
  SoccerTeam opponentTeam;
  String optaCompetitionId;

  int fantasyPoints;
  int playedMinutes;

  Map<String, int> soccerPlayerStatValues = {};

  List names = ["PLAYED_MINUTED", "FANTASY_POINTS" ,"GOLES", "TIROS", "PASES", "ASISTENCIAS", "REGATES", "RECUPERACIONES", "PERDIDAS_BALON", "FALTAS_RECIBIDAS", "FALTAS_COMETIDAS", "TARJETAS_AMARILLAS", "TARJETAS_ROJAS", "GOLES_ENCAJADOS", "PARADAS", "DESPEJES", "PENALTIS_DETENIDOS"];
/*
  int goles;
  int tiros;
  int pases;
  int asistencias;
  int regates;
  int recuperaciones;
  int perdidasBalon;
  int faltasRecibidas;
  int faltasCometidas;
  int tarjetasAmarillas;
  int tarjetasRojas;
  int golesEncajados;
  int paradas;
  int despejes;
  int penaltisDetenidos;
*/
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
/*
    goles = _getIntValue("GOLES");
    tiros = _getIntValue("TIROS");
    pases = _getIntValue("PASES");
    asistencias = _getIntValue("ASISTENCIAS");
    regates = _getIntValue("REGATES");
    recuperaciones = _getIntValue("RECUPERACIONES");
    perdidasBalon = _getIntValue("PERDIDAS_BALON");
    faltasRecibidas = _getIntValue("FALTAS_RECIBIDAS");
    faltasCometidas = _getIntValue("FALTAS_COMETIDAS");
    tarjetasAmarillas = _getIntValue("TARJETAS_AMARILLAS");
    tarjetasRojas = _getIntValue("TARJETAS_ROJAS");
    golesEncajados = _getIntValue("GOLES_ENCAJADOS");
    paradas = _getIntValue("PARADAS");
    despejes = _getIntValue("DESPEJES");
    penaltisDetenidos = _getIntValue("PENALTIS_DETENIDOS");
*/
  }

  bool hasPlayed() => (playedMinutes > 0) || (fantasyPoints != 0);
  bool hasPlayedInCompetition(String competitionId) => (optaCompetitionId == competitionId) && hasPlayed();
}