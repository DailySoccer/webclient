library soccer_player_info;

import "package:json_object/json_object.dart";

class SoccerPlayerInfo {
  String name;
  String fieldPos;
  int    fantasyPoints;
  int    salary;

  List<SoccerPlayerStats> stats;

  SoccerPlayerInfo.fromJsonObject(JsonObject json) {
    name = json.name;
    fieldPos = json.fieldPos;
    fantasyPoints = json.fantasyPoints;
    salary = json.salary;

    stats = new List();
    for (var x in json.stats) {
      stats.add(new SoccerPlayerStats.fromJsonObject(x));
    }
  }
}

class SoccerPlayerStats {
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

  SoccerPlayerStats.fromJsonObject(JsonObject json) {
    fantasyPoints = json.fantasyPoints;
    playedMinutes = json.playedMinutes;

    int _getIntValue(String key) => (json.events.containsKey(key)) ? json.events[key] : 0;

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