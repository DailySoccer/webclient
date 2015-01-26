library soccer_player_stats_comp;

import 'dart:html';
import 'dart:async';

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

@Component(
    selector: 'soccer-player-stats',
    useShadowDom: false
)
class SoccerPlayerStatsComp implements DetachAware{

  ScreenDetectorService scrDet;

  List<Map> seasonResumeStats;
  Map seasons = {'year': '', 'headers': ''};
  Map currentInfoData;
  bool cannotAddPlayer;

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "POR";

  SoccerPlayerStatsComp(this._flashMessage, this._enterContestComp, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router, this._root) {

    var contestId = routeProvider.route.parent.parameters["contestId"];
    var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];

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

  void collectSoccerPlayerInfo() {

    if (_soccerPlayerService.instanceSoccerPlayer != null) {
      currentInfoData = {
        'id'              : _soccerPlayerService.instanceSoccerPlayer.id,
        'fieldPos'        : _soccerPlayerService.instanceSoccerPlayer.fieldPos.abrevName,
        'team'            : _soccerPlayerService.instanceSoccerPlayer.soccerTeam.name.toUpperCase(),
        'name'            : _soccerPlayerService.instanceSoccerPlayer.soccerPlayer.name.toUpperCase(),
        'fantasyPoints'   : StringUtils.parseFantasyPoints(_soccerPlayerService.instanceSoccerPlayer.soccerPlayer.fantasyPoints),
        'salary'          : _soccerPlayerService.instanceSoccerPlayer.salary,
        'matches'         : _soccerPlayerService.soccerPlayer.stats.length,
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
                        ? "<strong>$shortNameTeamA</strong> vs $shortNameTeamB" : "$shortNameTeamA vs <strong>$shortNameTeamB</strong>";

      matchEventDate = " (${DateTimeService.formatDateTimeShort(nextMatchEvent.startDate)})";
    }

    return (matchEventName + matchEventDate);
  }

  void updateSoccerPlayerInfoFromService() {

    collectSoccerPlayerInfo();
    // Calculo de estadisticas de jugador
    calculateStatistics();
    // Renderizamos el HTML
    renderizeHTML();
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
    seasons["year"].clear();
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

    initializaPlayerStats();
    calculateSeasonStats();
    calculateSeasonResumeStats();
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
        var seasonYear = seasons['year'].where((year) => year == year);

        // Si no existe aún este año en la tabla de años, la generamos
        if (seasonYear == null) {
          // Si no tenemos creadas las estadísticas partido a partido
          Map newYear = {};
          newYear.addAll({"year":year, "value":[].add(matchStatRows)});
          seasons.addAll(newYear);
        }
        else {
          seasonYear["value"].add(matchStatRows);
        }

      });

    // No ha jugado ningún partido
    }
    else {
      seasons['year'] = [];
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

  void renderizeHTML() {
    _theHTML =
       '''
       <modal id="modalSoccerPlayerInfo">
      
        <div class="soccer-player-info-header">
          <div class="actions-header">
            <div class="text-header">ESTADÍSTICAS DEL JUGADOR</div>
      
            <button type="button" class="close" data-dismiss="modal">
              <span class="glyphicon glyphicon-remove"></span>
            </button>
      
            <!-- Esta seccion con boton de cancelar & añadir se repite 2 veces, solo en movil, arriba y abajo -->
            <div class="action-buttons">
                <button class="button-cancel" data-dismiss="modal">CANCELAR</button>
                <button class="button-add ${cannotAddPlayer ? "disabled":""}" do-function="onAddClicked">AÑADIR</button>
            </div>
      
          </div>
          <div class="description-header">
            <div class="soccer-player-description">
              <div class="soccer-player-pos-team">
                <span>${currentInfoData['fieldPos']}</span> | <span>${currentInfoData['team']}</span>
              </div>
              <div class="soccer-player-name">${currentInfoData['name']}</div>
            </div>
            <div class="soccer-player-info-stats">
              <div class="soccer-player-fantasy-points"><span>DFP</span><span>${currentInfoData['fantasyPoints']}</span></div>
              <div class="soccer-player-matches"><span>PARTIDOS</span><span>${currentInfoData['matches']}</span></div>
              <div class="soccer-player-salary"><span>SALARIO</span><span>${currentInfoData['salary']}</span></div>
            </div>
            ${scrDet.isNotXsScreen ? getNextMatchForDesktop() : ""}
          </div>
        </div>
      
        <div class="soccer-player-info-content">
            <!-- Nav tabs -->
            <ul id="soccer-player-info" class="soccer-player-info-tabs" role="tablist">
              <li id="seasonTab" class="active"><a role="tab" data-toggle="tab" do-function="tabChange" do-function-paams="season-info-tab-content">Datos de Temporada</a></li>
              <li id="matchTab" ><a role="tab" data-toggle="tab"  do-function="tabChange" do-function-paams="match-info-tab-content">Partido a Partido</a></li>
            </ul>
      
            <div class="tabs">
              <!-- Tab panes -->
              <div class="tab-content">
                <!--SEASON-->
                <div class="tab-pane active" id="season-info-tab-content">
                  <div class="next-match">PRÓXIMO PARTIDO: <span> ${currentInfoData['nextMatchEvent']}></span></div>
                  <!-- MEDIAS -->
                  <div class="season-header">ESTADÍSTICAS DE TEMPORADA <span>(DATOS POR PARTIDO)</span></div>
                  <div class="season-stats">
                    <div class="season-stats-wrapper">
                      ${getSeasonResumeStats()}
                    </div>
                  </div>
                </div>
                <!--END SEASON-->
                <!--MATCH-->
                <div class="tab-pane" id="match-info-tab-content">
                  <div class="match-header">PARTIDO A PARTIDO</div>
                  ${getSeasonsStats()}
                  
                </div>
                <!--END MATCH-->
              </div>
            </div>
      
            <div class="action-buttons bottom">
              <button class="button-cancel" data-dismiss="modal">CANCELAR</button>
              <button class="button-add" ng-click="onAddClicked()" ng-disabled="cannotAddPlayer">AÑADIR</button>
            </div>
        </div>
      </modal>


    ''';
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
      return '''
        <div class="noMatchesPlayed">
            <span>No ha jugado ningún partido esta temporada</span>
        </div>
      ''';
    }
    else {
      return '''
        <div class="match-stats">
            <div class="match-stats-header">
               ${getSeasonHeaders()}
        </div>
      ''';

    }
  }

  String getSeasonHeaders() {
    String ret = "";
    (seasons['headers'][0] as List).forEach( (head) {
      if (scrDet.isNotXsScreen && head == "Fecha") {
        ret += '''<div><span>${head}</span>&nbsp;</div>''';
      }
      else {
        ret
      }


    });

    return ret;
  }


/*
      return '''
      <div class="match-stats">
                          <!--HEADER-->
                          <div ng-if="isGoalkeeper()" class="match-stats-header">
                            <div><span ng-if="scrDet.isNotXsScreen">FECHA</span>&nbsp;</div>
                            <div ng-if="scrDet.isXsScreen">DÍA</div>
                            <div>OP</div>
                            <div>DFP</div>
                            <div>MIN</div>
                            <div>GE</div>
                            <div>PA</div>
                            <div>D</div>
                            <div>P</div>
                            <div>RE</div>
                            <div>PB</div>
                            <div>PD</div>
                            <div>FC</div>
                            <div>TA</div>
                            <div>TR</div>
                          </div>
                          <div ng-if="!isGoalkeeper()" class="match-stats-header">
                            <div><span ng-if="scrDet.isNotXsScreen">FECHA</span>&nbsp;</div>
                            <div ng-if="scrDet.isXsScreen">DÍA</div>
                            <div>OP</div>
                            <div>DFP</div>
                            <div>MIN</div>
                            <div>G</div>
                            <div>T</div>
                            <div>P</div>
                            <div>A</div>
                            <div>R</div>
                            <div>RE</div>
                            <div>E</div>
                            <div>PB</div>
                            <div>FJ</div>
                            <div>TA</div>
                            <div>TR</div>
                          </div>
                          <!--CONTENT-->
                          <div class="match-stats-content">
                              <div class="match-stats-data">
                                <!-- Los datos con un ng-repeat por año -->
                                <div ng-repeat="slot in seasons">
                                    <div class="match-year">{{slot["año"]}}</div>
                                    <div class="data" ng-repeat="match in slot['value']">
                                      <div ng-repeat="data in match">{{data}}<span ng-if="index == 0 && scrDet.isDesktop">/{{slot["año"]}}</span></div>
                                    </div>
                                </div>
                              </div>
                          </div>
                        </div>

                       ''';
*/
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

  void onAddSoccerPlayerToFantasyTem() {
    _enterContestComp.addSoccerPlayerToLineup(currentInfoData['id']);
    ModalComp.close();
  }

  void onShadowRoot(ShadowRoot shadowRoot) {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".tt-selector", 'tooltip', []);

    new Timer(new Duration(seconds: 1), JsUtils.runJavascript(".tt-selector", 'tooltip', null) );
  }


  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  EnterContestComp _enterContestComp;
  var _streamListener;
  Element _root;

  // Common Stats
  int _totalMinutes, _totalPasses, _totalRetrievals, _totalTurnovers, _totalFoulsCommitted, _totalYellowCards, _totalRedCards = 0;
  // Goalkeeper Stats
  int _totalGoalsAgainst, _totalSaves, _totalClearances, _totalSavedPenalties = 0;
  // Players not goalkeepers Sta
  int _totalGoals, _totalShoots, _totalAssistances, _totalDribbles, _totalFoulsSuffered = 0;

  String _theHTML;
}