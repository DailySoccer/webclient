library soccer_player_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/models/soccer_player_stats.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:intl/intl.dart';
import 'package:webclient/components/modal_comp.dart';


@Component(
    selector: 'soccer-player-info',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_player_info_comp.html',
    useShadowDom: false
)
class SoccerPlayerInfoComp {

  ScreenDetectorService scrDet;

  EnterContestComp enterContestComp;

  List<Map> medias;
  Map currentInfoData;
  List partidos  = new List();
  List seasons = [];
  List tempSeasons = [];
  bool matchesPlayed;
  bool cannotAddPlayer;

  SoccerPlayerInfoComp(this._flashMessage, this.enterContestComp, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router) {

    var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];
    _instanceSoccerPlayer = _soccerPlayerService.getInstanceSoccerPlayer(routeProvider.route.parent.parameters["contestId"], instanceSoccerPlayerId);

    // TODO: Nos vienen recargando.
    if (_instanceSoccerPlayer == null) {
      return;
    }

    currentInfoData = {
      'id'              : _instanceSoccerPlayer.id,
      'fieldPos'        : _instanceSoccerPlayer.fieldPos.abrevName,
      'team'            : _instanceSoccerPlayer.soccerTeam.name.toUpperCase(),
      'name'            : _instanceSoccerPlayer.soccerPlayer.name.toUpperCase(),
      'fantasyPoints'   : _instanceSoccerPlayer.soccerPlayer.fantasyPoints,
      'salary'          : _instanceSoccerPlayer.salary,
      'matches'         : '',
      'nextMatchEvent'  : ''
    };

    cannotAddPlayer = !enterContestComp.isSlotAvailableForSoccerPlayer(currentInfoData['id']);

    _soccerPlayerService.refreshSoccerPlayerInfo(instanceSoccerPlayerId)
      .then((_) {
        updateSoccerPlayerInfoFromService();
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  void updateSoccerPlayerInfoFromService() {
    var matchEventName = "", matchEventDate = "";

    MatchEvent nextMatchEvent = _soccerPlayerService.nextMatchEvent;
    if (nextMatchEvent != null) {
      String shortNameTeamA = nextMatchEvent.soccerTeamA.name;
      String shortNameTeamB = nextMatchEvent.soccerTeamB.name;
      matchEventName = (_soccerPlayerService.soccerPlayer.soccerTeam.templateSoccerTeamId == nextMatchEvent.soccerTeamA.templateSoccerTeamId)
          ? "<strong>$shortNameTeamA</strong> vs $shortNameTeamB"
          : "$shortNameTeamA vs <strong>$shortNameTeamB</strong>";
      matchEventDate = " (${DateTimeService.formatDateTimeShort(nextMatchEvent.startDate)})";
    }

    SoccerPlayer soccerPlayer = _soccerPlayerService.soccerPlayer;
    currentInfoData['matches'] = soccerPlayer.stats.length;
    currentInfoData['nextMatchEvent'] = matchEventName + matchEventDate;

    partidos.clear();
    for (SoccerPlayerStats stats in _soccerPlayerService.soccerPlayer.stats){
      partidos.add({
        'stats' : stats
      });
    }
    // Limpiamos las estadísticas partido a partido
    seasons.clear();
    tempSeasons.clear();

    // Calculo de estadisticas de jugador
    calculateStadistics(soccerPlayer);
  }

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "POR";

  String calculateStatAverage(int statSummatory, int totalMatch) {
    String zero = "0";
    if (totalMatch == 0 || statSummatory == 0) {
      return zero;
    }
    else {
      NumberFormat twoDecimals = new NumberFormat("0.00");
      NumberFormat oneDecimals = new NumberFormat("00.0");
      NumberFormat noDecimals = new NumberFormat("000");
      var average = statSummatory/totalMatch;
      if (average >= 100) {
       return noDecimals.format(average).toString();
      }
      else {
        return (average >= 10) ? oneDecimals.format(average).toString() : average = twoDecimals.format(average).toString();
      }
    }
  }

  void calculateStadistics(SoccerPlayer soccerPlayer) {
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
      soccerPlayer.stats.reversed.forEach((stat) {
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
        if (isGoalkeeper()) {
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, stat.fantasyPoints, stat.playedMinutes, stat.golesEncajados, stat.paradas, stat.despejes, stat.pases, stat.recuperaciones, stat.perdidasBalon, stat.penaltisDetenidos, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        }
        else {
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, stat.fantasyPoints, stat.playedMinutes, stat.goles, stat.tiros, stat.pases, stat.asistencias, stat.regates, stat.recuperaciones, stat.perdidasBalon, stat.faltasRecibidas, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        }
        // Si no tenemos creadas las estadísticas partido a partido
        if (seasons.length == 0) {
          Map season = {};
          season.addAll({"año":year,"value":[]});
          season["value"].add(matchStats);
          seasons.add(season);
        }
        // Vamos completanto las estadísticas partido a partido
        else {
          if (seasons.last["año"] != year) {
            Map season = {};
            season.addAll({"año":year,"value":[]});
            season["value"].add(matchStats);
            seasons.add(season);
          }
          else {
            seasons.last["value"].add(matchStats);
          }
        }
      });

    // No ha jugado ningún partido
    }
    else {
      matchesPlayed = false;
      seasons = [];
    }

    if (isGoalkeeper()) {
      //añadimos las especificas del portero
      medias = [
                {'nombre' : "MIN" , 'valor': calculateStatAverage(sumatorioMinutos, partidosTotales)},
                {'nombre' : "PB" , 'valor': calculateStatAverage(sumatorioPerdidasBalon, partidosTotales)},
                {'nombre' : "GE" , 'valor': calculateStatAverage(sumatorioGolesEncajados, partidosTotales)},
                {'nombre' : "PD" , 'valor': calculateStatAverage(sumatorioPenaltisDetenidos, partidosTotales)},
                {'nombre' : "PA" , 'valor': calculateStatAverage(sumatorioParadas, partidosTotales)},
                {'nombre' : "FC" , 'valor': calculateStatAverage(sumatorioFaltasCometidas, partidosTotales)},
                {'nombre' : "D" , 'valor': calculateStatAverage(sumatorioDespejes, partidosTotales)},
                {'nombre' : "TA" , 'valor': calculateStatAverage(sumatorioTarjetasAmarillas, partidosTotales)},
                {'nombre' : "P" , 'valor': calculateStatAverage(sumatorioPases, partidosTotales)},
                {'nombre' : "TR" , 'valor': calculateStatAverage(sumatorioTarjetasRojas, partidosTotales)},
                {'nombre' : "RE" , 'valor': calculateStatAverage(sumatorioRecuperaciones, partidosTotales)}
      ];
    }
    else {
      //añadimos las especificas del resto de jugadores
      medias = [
                {'nombre' : "MIN" , 'valor': calculateStatAverage(sumatorioMinutos, partidosTotales)},
                {'nombre' : "RE" , 'valor': calculateStatAverage(sumatorioRecuperaciones, partidosTotales)},
                {'nombre' : "G" , 'valor': calculateStatAverage(sumatorioGoles, partidosTotales)},
                {'nombre' : "PB" , 'valor': calculateStatAverage(sumatorioPerdidasBalon, partidosTotales)},
                {'nombre' : "T" , 'valor': calculateStatAverage(sumatorioTiros, partidosTotales)},
                {'nombre' : "FR" , 'valor': calculateStatAverage(sumatorioFaltasRecibidas, partidosTotales)},
                {'nombre' : "P" , 'valor': calculateStatAverage(sumatorioPases, partidosTotales)},
                {'nombre' : "FC" , 'valor': calculateStatAverage(sumatorioFaltasCometidas, partidosTotales)},
                {'nombre' : "A" , 'valor': calculateStatAverage(sumatorioAsistencias, partidosTotales)},
                {'nombre' : "TA" , 'valor': calculateStatAverage(sumatorioTarjetasAmarillas, partidosTotales)},
                {'nombre' : "R" , 'valor': calculateStatAverage(sumatorioRegates, partidosTotales)},
                {'nombre' : "TR" , 'valor': calculateStatAverage(sumatorioTarjetasRojas, partidosTotales)}
      ];
    }
    // Añado una última columna en las medias de portero para que cuadre
    if (medias.length % 2 != 0) {
      medias.add({"nombre":"","valor":""});
    }
  }

  void tabChange(String tab) {
    querySelectorAll(".soccer-player-info-content .tab-pane").classes.remove('active');

    Element contentTab = document.querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
  }

  void onAddClicked() {
    enterContestComp.addSoccerPlayerToLineup(currentInfoData['id']);
    ModalComp.close();
  }

  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  InstanceSoccerPlayer _instanceSoccerPlayer;
}