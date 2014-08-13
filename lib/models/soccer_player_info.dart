library soccer_player_info;

import "package:json_object/json_object.dart";
import "package:webclient/models/field_pos.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';

class SoccerPlayerInfo {
  String name;
  SoccerTeam team;
  FieldPos fieldPos;
  int    fantasyPoints;
  int    salary;

  List<SoccerPlayerStats> stats;

  SoccerPlayerInfo.fromJsonObject(JsonObject json, ContestReferences references) {
    name = json.name;
    team = references.getSoccerTeamById(json.templateTeamId);
    fieldPos = new FieldPos(json.fieldPos);
    fantasyPoints = json.fantasyPoints;
    salary = json.salary;

    stats = new List();
    for (var x in json.stats) {
      stats.add(new SoccerPlayerStats.fromJsonObject(x, references));
    }
  }
}

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
    startDate = json.containsKey("startDate") ? new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true) : new DateTime.now();
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

  /*
  Map matchStatsPOR = {
   "01": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" },
   "02": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" },
   "03": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" },
   "04": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" },
   "05": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" },
   "06": {"año": "2014", "dia": "20/05", "op": "ATM", "MIN": "120", "G": "00", "T": "00", "P": "00", "A": "00", "R": "00", "RE": "00", "E": "00", "PB": "00", "FJ": "00", "TA": "00", "TR": "00" }
  };*/

}