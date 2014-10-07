library soccer_player_stats;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/services/datetime_service.dart';

class SoccerPlayerStats {
  DateTime startDate;
  SoccerTeam opponentTeam;

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

  SoccerPlayerStats.fromJsonObject(JsonObject json, ContestReferences references) {
    startDate = json.containsKey("startDate") ? DateTimeService.fromMillisecondsSinceEpoch(json.startDate) : DateTimeService.now;
    opponentTeam = json.containsKey("opponentTeamId") ? references.getSoccerTeamById(json.opponentTeamId) : "???";

    fantasyPoints = json.fantasyPoints;
    playedMinutes = json.playedMinutes;

    int _getIntValue(String key) => (json.statsCount.containsKey(key)) ? json.statsCount[key] : 0;

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