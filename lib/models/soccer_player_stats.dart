library soccer_player_stats;

import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/services/datetime_service.dart';

class SoccerPlayerStats {
  DateTime startDate;
  SoccerTeam opponentTeam;
  String optaCompetitionId;

  int fantasyPoints;
  int playedMinutes;

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

  SoccerPlayerStats.fromJsonObject(Map jsonMap, ContestReferences references) {
    startDate = jsonMap.containsKey("startDate") ? DateTimeService.fromMillisecondsSinceEpoch(jsonMap["startDate"]) : DateTimeService.now;
    optaCompetitionId = jsonMap.containsKey("optaCompetitionId") && (jsonMap["optaCompetitionId"] != null) ? jsonMap["optaCompetitionId"] : "";
    opponentTeam = jsonMap.containsKey("opponentTeamId") ? references.getSoccerTeamById(jsonMap["opponentTeamId"]) : null;

    fantasyPoints = jsonMap["fantasyPoints"];
    playedMinutes = jsonMap["playedMinutes"];

    int _getIntValue(String key) => (jsonMap.containsKey("statsCount") && jsonMap["statsCount"].containsKey(key)) ? jsonMap["statsCount"][key] : 0;

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
  }

}