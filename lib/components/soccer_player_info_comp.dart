library soccer_player_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/soccer_player_info.dart';
import 'package:webclient/models/field_pos.dart';
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
    currentInfoData['fieldPos'] = soccerPlayer.fieldPos;
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

    print(partidos);

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

    soccerPlayer.stats.forEach((stat) {

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

      print(stat.playedMinutes);

    });

    // añadimos las medias comunes a todos los jugadores
    medias = [
              {'nombre' : "MIN" , 'valor': sumatorioMinutos / partidosTotales},
              {'nombre' : "P" , 'valor': sumatorioPases / partidosTotales},
              {'nombre' : "RE" , 'valor': sumatorioRecuperaciones / partidosTotales},
              {'nombre' : "PB" , 'valor': sumatorioPerdidasBalon / partidosTotales},
              {'nombre' : "FC" , 'valor': sumatorioFaltasCometidas / partidosTotales},
              {'nombre' : "TA" , 'valor': sumatorioTarjetasAmarillas / partidosTotales},
              {'nombre' : "TR" , 'valor': sumatorioTarjetasRojas / partidosTotales}
    ];

    if(isGoalkeeper()) {
      //añadimos las especificas del portero
      medias.add({'nombre' : "GE" , 'valor': sumatorioGolesEncajados / partidosTotales});
      medias.add({'nombre' : "PA" , 'valor': sumatorioParadas / partidosTotales});
      medias.add({'nombre' : "D" , 'valor': sumatorioDespejes / partidosTotales});
      medias.add({'nombre' : "PD" , 'valor': sumatorioPenaltisDetenidos / partidosTotales});
    }
    else {
      //añadimos las especificas del resto de jugadores
      medias.add({'nombre' : "G" , 'valor': sumatorioGoles / partidosTotales});
      medias.add({'nombre' : "T" , 'valor': sumatorioTiros / partidosTotales});
      medias.add({'nombre' : "A" , 'valor': sumatorioAsistencias / partidosTotales});
      medias.add({'nombre' : "R" , 'valor': sumatorioRegates / partidosTotales});
      medias.add({'nombre' : "FR" , 'valor': sumatorioFaltasRecibidas / partidosTotales});
    }

    if (medias.length % 2 != 0)
      medias.add({"nombre":"","valor":""});


  }

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "POR";

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