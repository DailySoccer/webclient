library soccer_player_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/soccer_player_info.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';


@Component(
    selector: 'soccer-player-info',
    templateUrl: 'packages/webclient/components/soccer_player_info_comp.html',
    publishAs: 'soccerPlayerInfo',
    useShadowDom: false
)

class SoccerPlayerInfoComp {

  EnterContestCtrl enterContestCtrl;

  @NgTwoWay("soccer-player-id")
  String get soccerPlayerData => _soccerPlayerId;
  void set soccerPlayerData(String value) {
    _soccerPlayerId = value;
    if(value != null){
      updateSoccerPlayerInfo(value);
    }
  }

  List<Map> medias;
  Map currentInfoData;
  List partidos  = new List();
  dynamic seasons = [];
  dynamic tempSeasons = [];
  bool matchesPlayed;

  SoccerPlayerInfoComp(this._router, this._soccerPlayerService, this._flashMessage, this.enterContestCtrl) {
    currentInfoData = {
      'id'              : '<id>',
      'fieldPos'        : '<fieldPos>',
      'team'            : '<team>',
      'name'            : '<name>',
      'fantasyPoints'   : '<fantasyPoints>',
      'matches'         : '<matches>',
      'salary'          : '<salary>'
    };
  }

  updateSoccerPlayerInfo(String soccerPlayerId) {
    _soccerPlayerService.refreshSoccerPlayerInfo(soccerPlayerId)
      .then((_) {
        updateSoccerPlayerInfoFromService();
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  updateSoccerPlayerInfoFromService() {
    SoccerPlayerInfo soccerPlayer = _soccerPlayerService.soccerPlayerInfo;
    currentInfoData['id'] = _soccerPlayerId;
    currentInfoData['fieldPos'] = soccerPlayer.fieldPos.abrevName;
    currentInfoData['team'] = soccerPlayer.team.name.toUpperCase();
    currentInfoData['name'] = soccerPlayer.name.toUpperCase();
    currentInfoData['fantasyPoints'] = soccerPlayer.fantasyPoints;
    currentInfoData['matches'] = soccerPlayer.stats.length;
    currentInfoData['salary'] = soccerPlayer.salary;

    partidos.clear();
    for (SoccerPlayerStats stats in _soccerPlayerService.soccerPlayerInfo.stats){
      partidos.add({
        'stats' : stats
      });
    }
    // Calculo de estadisticas de jugador
    calculateStadistics(soccerPlayer);
  }

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "POR";

  void calculateStadistics(SoccerPlayerInfo soccerPlayer) {
    List<String> matchDate = [];
    List<String> day = [];
    String year;
    String dayMonth ;

    int partidosTotales = soccerPlayer.stats.length;
    int sumatorioMinutos = 0;
    int sumatorioPases = 0;
    int sumatorioRecuperaciones = 0;
    int sumatorioPerdidasBalon = 0;
    int sumatorioFaltasCometidas = 0;
    int sumatorioTarjetasAmarillas = 0;
    int sumatorioTarjetasRojas = 0;
    // Goalkeeper
    int sumatorioGolesEncajados = 0;
    int sumatorioParadas = 0;
    int sumatorioDespejes = 0;
    int sumatorioPenaltisDetenidos = 0;
    // Player
    int sumatorioGoles = 0;
    int sumatorioTiros = 0;
    int sumatorioAsistencias = 0;
    int sumatorioRegates = 0;
    int sumatorioFaltasRecibidas = 0;

    // Si ha jugado partidos
    if (partidosTotales != 0) {
      matchesPlayed = true;
      soccerPlayer.stats.forEach((stat) {
        // Sumatorios para las medias
        sumatorioMinutos += stat.playedMinutes;
        sumatorioGoles += stat.goles;
        sumatorioTiros += stat.tiros;
        sumatorioPases += stat.pases;
        sumatorioAsistencias += stat.asistencias;
        sumatorioRegates += stat.regates;
        sumatorioRecuperaciones += stat.recuperaciones;
        sumatorioPerdidasBalon += stat.perdidasBalon;
        sumatorioFaltasCometidas += stat.faltasCometidas;
        sumatorioFaltasRecibidas += stat.faltasRecibidas;
        sumatorioTarjetasAmarillas += stat.tarjetasAmarillas;
        sumatorioTarjetasRojas += stat.tarjetasRojas;
        sumatorioGolesEncajados += stat.golesEncajados;
        sumatorioParadas += stat.paradas;
        sumatorioDespejes += stat.despejes;
        sumatorioPenaltisDetenidos += stat.penaltisDetenidos;

        matchDate = stat.startDate.toString().split("-");
        day = matchDate[2].split(" ");
        year = matchDate[0];
        dayMonth = day[0]+"/"+matchDate[1];

        List<String> matchStats = [];
        if(isGoalkeeper())
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, stat.playedMinutes, stat.golesEncajados, stat.paradas, stat.despejes, stat.pases, stat.recuperaciones, stat.perdidasBalon, stat.penaltisDetenidos, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        else
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, stat.playedMinutes, stat.goles, stat.tiros, stat.pases, stat.asistencias, stat.regates, stat.recuperaciones, stat.perdidasBalon, stat.faltasRecibidas, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);

        /*seasons = [
                    {"año":"2013","value" : [
                                             ["20/01","ATM","120"],
                                             ["21/01","BCN","121"]
                                            ]
                    }
                   ];*/

        if (seasons.length == 0) {
          Map season = {};
          season.addAll({"año":year,"value":[]});
          season["value"].add(matchStats);
          seasons.add(season);
        }
        else {
          seasons.forEach((stat) {
            if (stat["año"] != year) {
              Map season = {};
              season.addAll({"año":year,"value":[]});
              season["value"].add(matchStats);
              tempSeasons.add(season);
            }
            else
              stat["value"].add(matchStats);

          });
          tempSeasons.forEach((stat) {
            seasons.add(stat);
          });
        }
        print(seasons);
      });

    // No ha jugado ningún partido
    }
    else {
      matchesPlayed = false;
      seasons = [];
    }

    if(isGoalkeeper()) {
      //añadimos las especificas del portero
      medias = [
                {'nombre' : "MIN" , 'valor': partidosTotales ==  0 ? 0 : sumatorioMinutos / partidosTotales},
                {'nombre' : "PB" , 'valor': partidosTotales ==  0 ? 0 : sumatorioPerdidasBalon / partidosTotales},
                {'nombre' : "GE" , 'valor': partidosTotales ==  0 ? 0 : sumatorioGolesEncajados / partidosTotales},
                {'nombre' : "PD" , 'valor': partidosTotales ==  0 ? 0 : sumatorioPenaltisDetenidos / partidosTotales},
                {'nombre' : "PA" , 'valor': partidosTotales ==  0 ? 0 : sumatorioParadas / partidosTotales},
                {'nombre' : "FC" , 'valor': partidosTotales ==  0 ? 0 : sumatorioFaltasCometidas / partidosTotales},
                {'nombre' : "D" , 'valor': partidosTotales ==  0 ? 0 : sumatorioDespejes / partidosTotales},
                {'nombre' : "TA" , 'valor': partidosTotales ==  0 ? 0 : sumatorioTarjetasAmarillas / partidosTotales},
                {'nombre' : "P" , 'valor': partidosTotales ==  0 ? 0 : sumatorioPases / partidosTotales},
                {'nombre' : "TR" , 'valor': partidosTotales ==  0 ? 0 : sumatorioTarjetasRojas / partidosTotales},
                {'nombre' : "RE" , 'valor': partidosTotales ==  0 ? 0 : sumatorioRecuperaciones / partidosTotales}
      ];
    }
    else {
      //añadimos las especificas del resto de jugadores
      medias = [
                {'nombre' : "MIN" , 'valor': partidosTotales ==  0 ? 0 : sumatorioMinutos / partidosTotales},
                {'nombre' : "RE" , 'valor': partidosTotales ==  0 ? 0 : sumatorioRecuperaciones / partidosTotales},
                {'nombre' : "G" , 'valor': partidosTotales ==  0 ? 0 : sumatorioGoles / partidosTotales},
                {'nombre' : "PB" , 'valor': partidosTotales ==  0 ? 0 : sumatorioPerdidasBalon / partidosTotales},
                {'nombre' : "T" , 'valor': partidosTotales ==  0 ? 0 : sumatorioTiros / partidosTotales},
                {'nombre' : "FR" , 'valor': partidosTotales ==  0 ? 0 : sumatorioFaltasRecibidas / partidosTotales},
                {'nombre' : "P" , 'valor': partidosTotales ==  0 ? 0 : sumatorioPases / partidosTotales},
                {'nombre' : "FC" , 'valor': partidosTotales ==  0 ? 0 : sumatorioFaltasCometidas / partidosTotales},
                {'nombre' : "A" , 'valor': partidosTotales ==  0 ? 0 : sumatorioAsistencias / partidosTotales},
                {'nombre' : "TA" , 'valor': partidosTotales ==  0 ? 0 : sumatorioTarjetasAmarillas / partidosTotales},
                {'nombre' : "R" , 'valor': partidosTotales ==  0 ? 0 : sumatorioRegates / partidosTotales},
                {'nombre' : "TR" , 'valor': partidosTotales ==  0 ? 0 : sumatorioTarjetasRojas / partidosTotales}
      ];
    }
    // Añado una última columna en las medias de portero para que cuadre
    if (medias.length % 2 != 0)
      medias.add({"nombre":"","valor":""});
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".soccer-player-info-content .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    if(contentTab != null) {
      contentTab.classes.add("active");
    }
  }

  Router _router;
  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  String _soccerPlayerId;
}