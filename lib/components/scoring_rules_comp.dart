library scoring_rules_comp;

import 'package:angular/angular.dart';

@Component(
  selector:     'scoring-rules',
  templateUrl:  'packages/webclient/components/scoring_rules_comp.html',
  publishAs:    'comp',
  useShadowDom: false
)

class ScoringRulesComp {

  List<Map> AllPLayers = [
    {"shortName":"(P)",     "name":"Pase",                                      "points": "2"}
    ,{"shortName":"(R)",    "name":"Regate",                                    "points": "10"}
    ,{"shortName":"(FR)",   "name":"Falta recibida",                            "points": "10"}
    ,{"shortName":"(PI)",   "name":"Pase Interceptado",                         "points": "15"}
    ,{"shortName":"(TP)",   "name":"Tiro a puerta (fallado, poste o parado)",   "points": "15"}
    ,{"shortName":"(EE)",   "name":"Entrada Exitosa",                           "points": "15"}
    ,{"shortName":"(A)",    "name":"Asistencia",                                "points": "20"}
    ,{"shortName":"(FC)",   "name":"Falta cometida",                            "points": "-5"}
    ,{"shortName":"(PB)",   "name":"Pérdida de Balón",                          "points": "-5"}
    ,{"shortName":"(E)",    "name":"Error (que acaba en gol en contra)",        "points": "-20"}
    ,{"shortName":"(TA)",   "name":"Tarjeta Amarilla",                          "points": "-25"}
    ,{"shortName":"(TR)",   "name":"Tarjeta roja",                              "points": "-75"}
    ,{"shortName":"(PC)",   "name":"Penalti cometido",                          "points": "-30"}
    ,{"shortName":"(PF)",   "name":"Penalti Fallado",                           "points": "-30"}
    ,{"shortName":"(GPP)",  "name":"Gol en propia puerta",                      "points": "-10"}
    ,{"shortName":"(FJ)",   "name":"Fuera de juego",                            "points": "-5"}
  ];

  List<Map> GoalKeepers = [
    {"shortName":"(P0)",   "name":"Puerta a cero",                              "points": "40"}
    ,{"shortName":"(G)",    "name":"Gol",                                       "points": "100"}
    ,{"shortName":"(PP)",   "name":"Penalti parado",                            "points": "30"}
    ,{"shortName":"(PA)",   "name":"Parada",                                    "points": "10"}
    ,{"shortName":"(DP)",   "name":"Despeje de puños",                          "points": "10"}
    ,{"shortName":"(D)",    "name":"Despeje",                                   "points": "10"}
    ,{"shortName":"(GE)",    "name":"Gol encajado",                             "points": "-10"}
  ];

  List<Map> Defenders = [
    {"shortName":"(P0)",   "name":"Puerta a cero",                              "points": "40"}
    ,{"shortName":"(G)",    "name":"Gol",                                       "points": "80"}
    ,{"shortName":"(GE)",   "name":"Gol encajado",                              "points": "-10"}

  ];

  List<Map> MidFielders = [
    {"shortName":"(G)",    "name":"Gol",                                       "points": "60"}
  ];

  List<Map> Forwards = [
    {"shortName":"(G)",    "name":"Gol",                                       "points": "40"}
  ];

  ScoringRulesComp();

}