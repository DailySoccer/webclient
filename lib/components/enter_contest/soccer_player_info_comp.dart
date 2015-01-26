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
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';


@Component(
    selector: 'soccer-player-info',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_player_info_comp.html',
    useShadowDom: false
)
class SoccerPlayerInfoComp implements DetachAware, AttachAware, ShadowRootAware {

  ScreenDetectorService scrDet;

  EnterContestComp enterContestComp;

  List<Map> medias;
  Map currentInfoData;
  List partidos  = new List();
  List seasons = [];
  List tempSeasons = [];
  bool matchesPlayed;
  bool cannotAddPlayer;

  SoccerPlayerInfoComp(this._flashMessage, this.enterContestComp, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router, this._root) {

    var contestId = routeProvider.route.parent.parameters["contestId"];
    var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];

    //setInstancePlayerInfo(_soccerPlayerService.getInstanceSoccerPlayer(contestId, instanceSoccerPlayerId));
    _soccerPlayerService.refreshInstancePlayerInfo(contestId, instanceSoccerPlayerId)
      .then((_) {
        updateSoccerPlayerInfoFromService();
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });

    // Nos subscribimos al evento de cambio de tamañano de ventana (Necesario para volver al primer tab al cambiar el tamaño).
    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void detach() {
    _streamListener.cancel();
  }

  void onScreenWidthChange(String msg) {
    tabChange('season-info-tab-content', 'seasonTab');
  }

  void setInstancePlayerInfo() {
    _instanceSoccerPlayer = _soccerPlayerService.instanceSoccerPlayer;

    if (_instanceSoccerPlayer != null) {
      currentInfoData = {
        'id'              : _instanceSoccerPlayer.id,
        'fieldPos'        : _instanceSoccerPlayer.fieldPos.abrevName,
        'team'            : _instanceSoccerPlayer.soccerTeam.name.toUpperCase(),
        'name'            : _instanceSoccerPlayer.soccerPlayer.name.toUpperCase(),
        'fantasyPoints'   : StringUtils.parseFantasyPoints(_instanceSoccerPlayer.soccerPlayer.fantasyPoints),
        'salary'          : _instanceSoccerPlayer.salary,
        'matches'         : '-',
        'nextMatchEvent'  : ''
      };

      cannotAddPlayer = !enterContestComp.isSlotAvailableForSoccerPlayer(currentInfoData['id']);
    }
  }

  void updateSoccerPlayerInfoFromService() {
    setInstancePlayerInfo();

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
/*
    partidos.clear();
    for (SoccerPlayerStats stats in _soccerPlayerService.soccerPlayer.stats){
      partidos.add({
        'stats' : stats
      });
    }
    *
     */
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
      NumberFormat twoDecimals = new NumberFormat("0.00", "es_ES");
      NumberFormat oneDecimals = new NumberFormat("00.0", "es_ES");
      NumberFormat noDecimals = new NumberFormat("000", "es_ES");
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
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, StringUtils.parseFantasyPoints(stat.fantasyPoints), stat.playedMinutes, stat.golesEncajados, stat.paradas, stat.despejes, stat.pases, stat.recuperaciones, stat.perdidasBalon, stat.penaltisDetenidos, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        }
        else {
          matchStats.addAll([dayMonth, stat.opponentTeam.shortName, StringUtils.parseFantasyPoints(stat.fantasyPoints), stat.playedMinutes, stat.goles, stat.tiros, stat.pases, stat.asistencias, stat.regates, stat.recuperaciones, stat.perdidasBalon, stat.faltasRecibidas, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
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
                {'nombre' : "MIN" , 'valor': calculateStatAverage(sumatorioMinutos, partidosTotales), 'helpInfo': 'Minutos jugados'},
                {'nombre' : "GE" , 'valor': calculateStatAverage(sumatorioGolesEncajados, partidosTotales), 'helpInfo': 'Goles Encajados'},
                {'nombre' : "PA" , 'valor': calculateStatAverage(sumatorioParadas, partidosTotales), 'helpInfo': 'Paradas'},
                {'nombre' : "D" , 'valor': calculateStatAverage(sumatorioDespejes, partidosTotales), 'helpInfo': 'Despejes'},
                {'nombre' : "PD" , 'valor': calculateStatAverage(sumatorioPenaltisDetenidos, partidosTotales), 'helpInfo': 'Penaltis Detenidos'},
                {'nombre' : "P" , 'valor': calculateStatAverage(sumatorioPases, partidosTotales), 'helpInfo': 'Pases'},
                {'nombre' : "RE" , 'valor': calculateStatAverage(sumatorioRecuperaciones, partidosTotales), 'helpInfo': 'Recuperaciones'},
                {'nombre' : "PB" , 'valor': calculateStatAverage(sumatorioPerdidasBalon, partidosTotales), 'helpInfo': 'Perdidas de Balón'},
                //{'nombre' : "FC" , 'valor': calculateStatAverage(sumatorioFaltasCometidas, partidosTotales), 'helpInfo': 'Faltas Cometidas'},
                {'nombre' : "TA" , 'valor': calculateStatAverage(sumatorioTarjetasAmarillas, partidosTotales), 'helpInfo': 'Tarjetas Amarillas'},
                {'nombre' : "TR" , 'valor': calculateStatAverage(sumatorioTarjetasRojas, partidosTotales), 'helpInfo': 'Tarjetas Rojas'}
      ];
    }
    else {
      //añadimos las especificas del resto de jugadores
      medias = [
                {'nombre' : "MIN" , 'valor': calculateStatAverage(sumatorioMinutos, partidosTotales), 'helpInfo': 'Minutos jugados'},
                {'nombre' : "G" , 'valor': calculateStatAverage(sumatorioGoles, partidosTotales), 'helpInfo': 'Goles'},
                {'nombre' : "T" , 'valor': calculateStatAverage(sumatorioTiros, partidosTotales), 'helpInfo': 'Tiros'},
                {'nombre' : "P" , 'valor': calculateStatAverage(sumatorioPases, partidosTotales), 'helpInfo': 'Pases'},
                {'nombre' : "A" , 'valor': calculateStatAverage(sumatorioAsistencias, partidosTotales), 'helpInfo': 'Asistencias'},
                {'nombre' : "R" , 'valor': calculateStatAverage(sumatorioRegates, partidosTotales), 'helpInfo': 'Regates'},
                {'nombre' : "RE" , 'valor': calculateStatAverage(sumatorioRecuperaciones, partidosTotales), 'helpInfo': 'Recuperaciones'},
                {'nombre' : "PB" , 'valor': calculateStatAverage(sumatorioPerdidasBalon, partidosTotales), 'helpInfo': 'Perdidas de Balones'},
                {'nombre' : "FC" , 'valor': calculateStatAverage(sumatorioFaltasCometidas, partidosTotales), 'helpInfo': 'Faltas Cometidas'},
                {'nombre' : "FR" , 'valor': calculateStatAverage(sumatorioFaltasRecibidas, partidosTotales), 'helpInfo': 'Recibides'},
                {'nombre' : "TA" , 'valor': calculateStatAverage(sumatorioTarjetasAmarillas, partidosTotales), 'helpInfo': 'Tarjetas Amarillas'},
                {'nombre' : "TR" , 'valor': calculateStatAverage(sumatorioTarjetasRojas, partidosTotales), 'helpInfo': 'Tarjetas Rojas'}
      ];
    }
    // Añado una última columna en las medias de portero para que cuadre
    if (medias.length % 2 != 0) {
      medias.add({"nombre":"","valor":""});
    }
  }

  void tabChange(String tab,[String LItabName = null]) {
    querySelectorAll(".soccer-player-info-content .tab-pane").classes.remove('active');

    Element contentTab = document.querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
    if (LItabName!= null) {
      querySelectorAll('#soccer-player-info li').classes.remove('active');
      querySelector('#' + LItabName).classes.add("active");
    }
  }

  void onAddClicked() {
    enterContestComp.addSoccerPlayerToLineup(currentInfoData['id']);
    ModalComp.close();
  }

  void onShadowRoot(ShadowRoot shadowRoot) {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".tt-selector", 'tooltip', []);

    new Timer(new Duration(seconds: 1), tooltipfy);
  }

  void tooltipfy() {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".tt-selector", 'tooltip', null);
  }

  @override
  void attach() {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".tt-selector", 'tooltip', null);
  }

  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  InstanceSoccerPlayer _instanceSoccerPlayer;

  var _streamListener;
  Element _root;
}