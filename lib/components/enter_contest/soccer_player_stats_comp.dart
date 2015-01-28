library soccer_player_stats_comp;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/models/instance_soccer_player.dart';

@Component(
    selector: 'soccer-player-stats',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_player_stats_comp.html',
    useShadowDom: false
)
class SoccerPlayerStatsComp implements DetachAware{

  ScreenDetectorService scrDet;

  List<Map> seasonResumeStats = [];
  Map<String,dynamic> seasons = {'headers': [], 'values': {}};
  Map currentInfoData;
  bool cannotAddPlayer;

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "POR";

  SoccerPlayerStatsComp(this._flashMessage, this._enterContestComp, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router, this._rootElement) {

    var contestId = routeProvider.route.parent.parameters["contestId"];
    var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];

    collectSoccerPlayerInfo(_soccerPlayerService.getInstanceSoccerPlayer(contestId, instanceSoccerPlayerId));
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
    tabChange('season-stats-tab-content', 'seasonTab');
  }

  void collectSoccerPlayerInfo(InstanceSoccerPlayer _soccerPlayerInstance) {
    _instanceSoccerPlayer = _soccerPlayerInstance;

    if (_instanceSoccerPlayer != null) {
      currentInfoData = {
        'id'              : _instanceSoccerPlayer.id,
        'fieldPos'        : _instanceSoccerPlayer.fieldPos.abrevName,
        'team'            : _instanceSoccerPlayer.soccerTeam.name.toUpperCase(),
        'name'            : _instanceSoccerPlayer.soccerPlayer.name.toUpperCase(),
        'fantasyPoints'   : StringUtils.parseFantasyPoints(_instanceSoccerPlayer.soccerPlayer.fantasyPoints),
        'salary'          : _instanceSoccerPlayer.salary,
        'matches'         : _instanceSoccerPlayer.soccerPlayer.stats != null ? _instanceSoccerPlayer.soccerPlayer.stats.length : 0,
        'nextMatchEvent'  : getNextMatchEvent(),
        'stats'           : {}
      };

      cannotAddPlayer = !_enterContestComp.isSlotAvailableForSoccerPlayer(currentInfoData['id']);
    }
  }

  String getNextMatchEvent() {
    String matchEventName = "";
    String matchEventDate = "";

    MatchEvent nextMatchEvent = _soccerPlayerService.nextMatchEvent;
    if (nextMatchEvent != null) {
      String shortNameTeamA = nextMatchEvent.soccerTeamA.name;
      String shortNameTeamB = nextMatchEvent.soccerTeamB.name;

      matchEventName = (_soccerPlayerService.soccerPlayer.soccerTeam.templateSoccerTeamId == nextMatchEvent.soccerTeamA.templateSoccerTeamId)
                        ? " <strong>$shortNameTeamA</strong> vs $shortNameTeamB" : " $shortNameTeamA vs <strong>$shortNameTeamB</strong>";

      matchEventDate = " (${DateTimeService.formatDateTimeShort(nextMatchEvent.startDate)})";
    }

    return ("PRÓXIMO PARTIDO: " + matchEventName + matchEventDate);
  }

  void updateSoccerPlayerInfoFromService() {
    collectSoccerPlayerInfo(_instanceSoccerPlayer);
    // Calculo de estadisticas de jugador
    calculateStatistics();
    // Renderizamos el HTML
  //  renderizeHTML();
  }

  String calculateStatAverage(int statSummatory, int totalMatch) {
    if (totalMatch == 0 || statSummatory == 0) {
      return "0";
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

  void initializaPlayerStats() {
    seasonResumeStats.clear();
    seasons["values"].clear();
    if (isGoalkeeper()) {
      seasons['headers'] = ['Fecha', 'Oponente', 'Daily Fantasy Points', 'Minutos', 'Goles Encajados', 'Paradas', 'Despejes', 'Penaltis Detenidos', 'Pases', 'Recuperaciones', 'Perdidas de Balón', 'Faltas Cometidas', 'Tarjetas Amarillas', 'Tarjetas Rojas'];
    }
    else {
      seasons['headers'] = ['Fecha', 'Oponente', 'Daily Fantasy Points', 'Minutos', 'Goles', 'Tiros', 'Pases', 'Asistencias', 'Regates', 'Recuperaciones', 'Perdidas de Balones', 'Faltas Cometidas', 'Faltas Recibidas', 'Tarjetas Amarillas', 'Tarjetas Rojas'];
    }
    _totalMinutes        = 0;
    _totalPasses         = 0;
    _totalRetrievals     = 0;
    _totalTurnovers      = 0;
    _totalFoulsCommitted = 0;
    _totalYellowCards    = 0;
    _totalRedCards       = 0;
    // Goalkeeper
    _totalGoalsAgainst   = 0;
    _totalSaves          = 0;
    _totalClearances     = 0;
    _totalSavedPenalties = 0;
    // Player
    _totalGoals          = 0;
    _totalShoots         = 0;
    _totalAssistances    = 0;
    _totalDribbles       = 0;
    _totalFoulsSuffered  = 0;
  }

  void calculateStatistics() {
    if(_instanceSoccerPlayer != null) {
      initializaPlayerStats();
      calculateSeasonStats();
      calculateSeasonResumeStats();
    }
  }

  void calculateSeasonStats() {

    SoccerPlayer soccerPlayer = _soccerPlayerService.soccerPlayer;

    // Si ha jugado partidos
    if (currentInfoData['matches'] > 0) {
      soccerPlayer.stats.reversed.forEach((stat) {
        // Sumatorios para las medias
        _totalMinutes         += stat.playedMinutes;
        _totalGoals           += stat.goles;
        _totalShoots          += stat.tiros;
        _totalPasses          += stat.pases;
        _totalAssistances     += stat.asistencias;
        _totalDribbles        += stat.regates;
        _totalRetrievals      += stat.recuperaciones;
        _totalTurnovers       += stat.perdidasBalon;
        _totalFoulsCommitted  += stat.faltasCometidas;
        _totalFoulsSuffered   += stat.faltasRecibidas;
        _totalYellowCards     += stat.tarjetasAmarillas;
        _totalRedCards        += stat.tarjetasRojas;
        _totalGoalsAgainst    += stat.golesEncajados;
        _totalSaves           += stat.paradas;
        _totalClearances      += stat.despejes;
        _totalSavedPenalties  += stat.penaltisDetenidos;

        var matchDate = stat.startDate.toString().split("-");
        var year = matchDate[0];
        var month = matchDate[1];
        var day = matchDate[2].split(" ");

        var dayMonth = day[0] + "/" + month;

        List<String> matchStatRows = [];
        if (isGoalkeeper()) {
          //  campos en orden  ['Fecha', 'Oponente',                   'Daily Fantasy Points',                             'Minutos',          'Goles Encajados',   'Paradas',    'Despejes',    'Pases',    'Penaltis Detenidos',   'Recuperaciones',    'Perdidas de Balón','Faltas Cometidas',   'Tarjetas Amarillas',  'Tarjetas Rojas'];
          matchStatRows.addAll([dayMonth, stat.opponentTeam.shortName, StringUtils.parseFantasyPoints(stat.fantasyPoints), stat.playedMinutes, stat.golesEncajados, stat.paradas, stat.despejes, stat.pases, stat.penaltisDetenidos, stat.recuperaciones, stat.perdidasBalon, stat.faltasCometidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        }
        else {
          //  campos en orden  ['Fecha',  'Oponente',                  'Daily Fantasy Points',                             'Minutos',          'Goles',    'Tiros',    'Pases',    'Asistencias',    'Regates',    'Recuperaciones',    'Perdidas de Balones',  'Faltas Cometidas',   'Faltas Recibidas',   'Tarjetas Amarillas',   'Tarjetas Rojas'];
          matchStatRows.addAll([dayMonth, stat.opponentTeam.shortName, StringUtils.parseFantasyPoints(stat.fantasyPoints), stat.playedMinutes, stat.goles, stat.tiros, stat.pases, stat.asistencias, stat.regates, stat.recuperaciones, stat.perdidasBalon,     stat.faltasCometidas, stat.faltasRecibidas, stat.tarjetasAmarillas, stat.tarjetasRojas]);
        }

        // Buscamos el año que vamos a actualizar
        Map seasonYear = seasons['values'];

        // Si no existe aún este año en la tabla de años, la generamos
        if (seasonYear == null || !seasonYear.containsKey(year)) {
          // Si no tenemos creadas las estadísticas partido a partido
          Map newYear = {};
          newYear.addAll({year:matchStatRows});
          seasonYear.addAll(newYear);
        }
        else {
          seasonYear[year].add(matchStatRows);
        }
      });

    // No ha jugado ningún partido
    }
    else {
      seasons['values'] = [];
    }
  }

  void calculateSeasonResumeStats() {

    if (isGoalkeeper()) {
      //añadimos las especificas del portero
      seasonResumeStats = [
                {'nombre' : "MIN" , 'valor': calculateStatAverage(_totalMinutes, currentInfoData['matches']),       'helpInfo': 'Minutos jugados'},
                {'nombre' : "GE"  , 'valor': calculateStatAverage(_totalGoalsAgainst, currentInfoData['matches']),  'helpInfo': 'Goles Encajados'},
                {'nombre' : "PA"  , 'valor': calculateStatAverage(_totalSaves, currentInfoData['matches']),         'helpInfo': 'Paradas'},
                {'nombre' : "D"   , 'valor': calculateStatAverage(_totalClearances, currentInfoData['matches']),    'helpInfo': 'Despejes'},
                {'nombre' : "PD"  , 'valor': calculateStatAverage(_totalSavedPenalties, currentInfoData['matches']),'helpInfo': 'Penaltis Detenidos'},
                {'nombre' : "P"   , 'valor': calculateStatAverage(_totalPasses, currentInfoData['matches']),        'helpInfo': 'Pases'},
                {'nombre' : "RE"  , 'valor': calculateStatAverage(_totalRetrievals, currentInfoData['matches']),    'helpInfo': 'Recuperaciones'},
                {'nombre' : "PB"  , 'valor': calculateStatAverage(_totalTurnovers, currentInfoData['matches']),     'helpInfo': 'Perdidas de Balón'},
                {'nombre' : "TA"  , 'valor': calculateStatAverage(_totalYellowCards, currentInfoData['matches']),   'helpInfo': 'Tarjetas Amarillas'},
                {'nombre' : "TR"  , 'valor': calculateStatAverage(_totalRedCards, currentInfoData['matches']),      'helpInfo': 'Tarjetas Rojas'}
      ];
    }
    else {
      //añadimos las especificas del resto de jugadores
      seasonResumeStats = [
                {'nombre' : "MIN" , 'valor': calculateStatAverage(_totalMinutes, currentInfoData['matches']),       'helpInfo': 'Minutos jugados'},
                {'nombre' : "G"   , 'valor': calculateStatAverage(_totalGoals, currentInfoData['matches']),         'helpInfo': 'Goles'},
                {'nombre' : "T"   , 'valor': calculateStatAverage(_totalShoots, currentInfoData['matches']),        'helpInfo': 'Tiros'},
                {'nombre' : "P"   , 'valor': calculateStatAverage(_totalPasses, currentInfoData['matches']),        'helpInfo': 'Pases'},
                {'nombre' : "A"   , 'valor': calculateStatAverage(_totalAssistances, currentInfoData['matches']),   'helpInfo': 'Asistencias'},
                {'nombre' : "R"   , 'valor': calculateStatAverage(_totalDribbles, currentInfoData['matches']),      'helpInfo': 'Regates'},
                {'nombre' : "RE"  , 'valor': calculateStatAverage(_totalRetrievals, currentInfoData['matches']),    'helpInfo': 'Recuperaciones'},
                {'nombre' : "PB"  , 'valor': calculateStatAverage(_totalTurnovers, currentInfoData['matches']),     'helpInfo': 'Perdidas de Balones'},
                {'nombre' : "FC"  , 'valor': calculateStatAverage(_totalFoulsCommitted, currentInfoData['matches']),'helpInfo': 'Faltas Cometidas'},
                {'nombre' : "FR"  , 'valor': calculateStatAverage(_totalFoulsSuffered, currentInfoData['matches']), 'helpInfo': 'Faltas Recibidas'},
                {'nombre' : "TA"  , 'valor': calculateStatAverage(_totalYellowCards, currentInfoData['matches']),   'helpInfo': 'Tarjetas Amarillas'},
                {'nombre' : "TR"  , 'valor': calculateStatAverage(_totalRedCards, currentInfoData['matches']),      'helpInfo': 'Tarjetas Rojas'}
      ];
    }

    // Añado una última columna en las medias de portero para que cuadre en XS.
    if (seasonResumeStats.length % 2 != 0) {
      seasonResumeStats.add({"nombre":"","valor":""});
    }
  }

  String getNextMatchForDesktop() {
    return  '''
              <div class="next-match-wrapper">
                <span class="next-match">PRÓXIMO PARTIDO:</span> <span class="next-match">${currentInfoData['nextMatchEvent']}></span>
                <button class="button-add ${cannotAddPlayer ? "disabled":""}" do-function="onAddClicked">AÑADIR</button>
              </div>
            ''';
  }

  String getSeasonResumeStats() {
    String resumeStats = "";
    seasonResumeStats.forEach( (stat) {
      resumeStats += '''
        <div data-toggle="tooltip" title="${stat['helpInfo']}">
          <div class="season-stats-header">${stat['nombre']}</div>
          <div class="season-stats-info">${stat['valor']}</div>
        </div>
      ''';
    });

    return ''' <div class="season-stats-row"> ${resumeStats} </div> ''';
  }

  String getSeasonsStats() {
    if (currentInfoData['matches'] > 0) {
      return '''<div class="noMatchesPlayed"> <span>No ha jugado ningún partido esta temporada</span> </div>''';
    }
    else {
      return '''<div class="match-stats"> ${getSeasonsDataTable()} </div>''';
    }
  }

  String getSeasonsDataTable() {
    String ret = "";
    return ret;
  }

  void tabChange(String tab,[String LItabName = null]) {
    querySelectorAll(".soccer-player-stats-content .tab-pane").classes.remove('active');

    Element contentTab = document.querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
    if (querySelector('#' + LItabName)!= null) {
      querySelectorAll('#soccer-player-stats li').classes.remove('active');
      querySelector('#' + LItabName).classes.add("active");
    }
  }

  void onAddSoccerPlayerToFantasyTem() {
    _enterContestComp.addSoccerPlayerToLineup(currentInfoData['id']);
    ModalComp.close();
  }

  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  InstanceSoccerPlayer _instanceSoccerPlayer;

  EnterContestComp _enterContestComp;
  var _streamListener;
  Element _rootElement;

  // Common Stats
  int _totalMinutes, _totalPasses, _totalRetrievals, _totalTurnovers, _totalFoulsCommitted, _totalYellowCards, _totalRedCards = 0;
  // Goalkeeper Stats
  int _totalGoalsAgainst, _totalSaves, _totalClearances, _totalSavedPenalties = 0;
  // Players not goalkeepers Sta
  int _totalGoals, _totalShoots, _totalAssistances, _totalDribbles, _totalFoulsSuffered = 0;
}