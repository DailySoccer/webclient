library soccer_player_stats_comp;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';

@Component(
    selector: 'soccer-player-stats',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_player_stats_comp.html',
    useShadowDom: false
)
class SoccerPlayerStatsComp implements DetachAware, ShadowRootAware {

  ScreenDetectorService scrDet;

  List<Map> seasonResumeStats = [];
  List seasonTableHeaders = [];
  List seasonsList = [];

  Map currentInfoData;
  bool selectablePlayer;

  bool isGoalkeeper() => currentInfoData['fieldPos'] == "GK";

  //Listas para las estadísticas ordenadas
  static List<String> goalKeeperStatsList   = ["GOLES_ENCAJADOS", "PARADAS", "DESPEJES", "PENALTIS_DETENIDOS", "PASES", "RECUPERACIONES", "PERDIDAS_BALON", "FALTAS_COMETIDAS", "TARJETAS_AMARILLAS", "TARJETAS_ROJAS"];
  static List<String> commonPlayerStatsList = ["GOLES", "TIROS", "PASES", "ASISTENCIAS", "REGATES", "RECUPERACIONES", "PERDIDAS_BALON", "FALTAS_COMETIDAS", "FALTAS_RECIBIDAS", "TARJETAS_AMARILLAS", "TARJETAS_ROJAS"];

  Map mappedFieldNames = {
                "PASES"               : {"shortName" : "P",  "description" : 'Passes'},
                "RECUPERACIONES"      : {"shortName" : "R", "description" : 'Recoveries'},
                "PERDIDAS_BALON"      : {"shortName" : "PL", "description" : 'Possession lost'},
                "FALTAS_COMETIDAS"    : {"shortName" : "F", "description" : 'Fouls Committed'},
                "TARJETAS_AMARILLAS"  : {"shortName" : "YC", "description" : 'Yellow Cards'},
                "TARJETAS_ROJAS"      : {"shortName" : "RC", "description" : 'Red Cards'},
                "GOLES_ENCAJADOS"     : {"shortName" : "GC", "description" : 'Goals Conceded'},
                "PARADAS"             : {"shortName" : "S", "description" : 'Saves'},
                "DESPEJES"            : {"shortName" : "C",  "description" : 'Clearances'},
                "PENALTIS_DETENIDOS"  : {"shortName" : "PS", "description" : 'Penalties Saved'},
                "GOLES"               : {"shortName" : "G",  "description" : 'Goals'},
                "TIROS"               : {"shortName" : "SH",  "description" : 'Shots'},
                "ASISTENCIAS"         : {"shortName" : "A",  "description" : 'Assists'},
                "REGATES"             : {"shortName" : "T",  "description" : 'Take-ons'},
                "FALTAS_RECIBIDAS"    : {"shortName" : "FC", "description" : 'Fouls Conceded'}
  };

  SoccerPlayerStatsComp(this._flashMessage, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router, this._rootElement) {

    var contestId = routeProvider.route.parent.parameters["contestId"];
    var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];
    selectablePlayer = routeProvider.route.parameters["selectable"] == "true";

    collectSoccerPlayerInfo(_soccerPlayerService.getInstanceSoccerPlayer(contestId, instanceSoccerPlayerId));
    _soccerPlayerService.refreshInstancePlayerInfo(contestId, instanceSoccerPlayerId)
      .then((_) {
        updateSoccerPlayerInfoFromService();
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });

    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void detach() {
    _streamListener.cancel();
  }

  void onShadowRoot(ShadowRoot shadowRoot) {
    new Timer(new Duration(seconds: 1), tooltipfy);
  }

  void tooltipfy() {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".season-stats-row", 'tooltip', null);
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
        'matchesCount'    : _instanceSoccerPlayer.soccerPlayer.stats != null ? _instanceSoccerPlayer.soccerPlayer.stats.length : 0,
        'nextMatchEvent'  : getNextMatchEvent(),
        'stats'           : {}
      };
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

    return ("NEXT MATCH: " + matchEventName + matchEventDate);
  }

  void updateSoccerPlayerInfoFromService() {
    collectSoccerPlayerInfo(_soccerPlayerService.instanceSoccerPlayer);
    // Calculo de estadisticas de jugador
    calculateStatistics();
  }

  String calculateStatAverage(String key) {
    if (currentInfoData['matchesCount'] == 0 || _totalSums[key] == 0) {
      return "0";
    }
    else {
      NumberFormat twoDecimals = new NumberFormat("0.00", "es_ES");
      NumberFormat oneDecimals = new NumberFormat("00.0", "es_ES");
      NumberFormat noDecimals = new NumberFormat("000", "es_ES");
      dynamic average;
      if(key == "MIN") {
        average = _totalMinutes / currentInfoData['matchesCount'];
      }
      else {
        average = _totalSums[key] / currentInfoData['matchesCount'];
      }
      if (average >= 100) {
       return noDecimals.format(average).toString();
      }
      else {
        return (average >= 10) ? oneDecimals.format(average).toString() : average = twoDecimals.format(average).toString();
      }
    }
  }

  void initializePlayerStats() {
    if (_instanceSoccerPlayer == null) {
      return;
    }

    seasonResumeStats.clear();
    seasonsList.clear();
    seasonTableHeaders = ['Date', 'Opponent', 'Daily Fantasy Points', 'Minutes'];

    if(isGoalkeeper()) {
      goalKeeperStatsList.forEach((key) {
        _totalSums[key] = 0;
      });
      seasonTableHeaders.addAll(['Goals Conceded', 'Saves', 'Clearances', 'Saved Penalties', 'Passes', 'Recoveries', 'Possession Lost', 'Fouls Committed', 'Yellow Cards', 'Red Cards']);
    }
    else {
      commonPlayerStatsList.forEach((key) {
        _totalSums[key] = 0;
      });
      seasonTableHeaders.addAll(['Goals', 'Shots', 'Passes', 'Assists', 'Take-ons', 'Recoveries', 'Possession lost', 'Fouls Committed', 'Fouls Conceded', 'Yellow Cards', 'Red Cards']);
    }
  }

  void calculateStatistics() {
      initializePlayerStats();
      calculateSeasonStats();
      calculateSeasonResumeStats();
  }

  void calculateSeasonStats() {

    SoccerPlayer soccerPlayer = _soccerPlayerService.soccerPlayer;

    // Si ha jugado partidos
    if (currentInfoData['matchesCount'] > 0) {
      soccerPlayer.stats.reversed.forEach((stat) {
        // Sumatorio de minutos
        _totalMinutes       += stat.playedMinutes;

        String year         = DateTimeService.formatDateYear(stat.startDate);
        String dayMonth     = DateTimeService.formatDateShort(stat.startDate);
        List matchStatRows  = [];

        //Campos en orden    ['Fecha', 'Oponente',                  'Daily Fantasy Points',                             'Minutos',
        matchStatRows.addAll([dayMonth, stat.opponentTeam.shortName, StringUtils.parseFantasyPoints(stat.fantasyPoints), stat.playedMinutes]);

        _totalSums.keys.forEach((key) {
          // Calculamos los sumatorios.
          _totalSums[key] += stat.soccerPlayerStatValues[key];
          // Añadimos las especificas a la lista de las estats por partido.
          matchStatRows.add(stat.soccerPlayerStatValues[key]);
        });

        // Si no existe aún este año en la tabla de años, la generamos
        if (seasonsList.length == 0) {
          // Si no tenemos creadas las estadísticas partido a partido
          Map newSeason = {};
          newSeason.addAll({'year':year, 'stats':[]});
          newSeason['stats'].add(matchStatRows);
          seasonsList.add(newSeason);
        }
        else {
          seasonsList.last['stats'].add(matchStatRows);
        }

      });
    } // No ha jugado ningún partido
    else {
      seasonsList = [];
    }
  }

  void calculateSeasonResumeStats() {

      // Añadimos las especificas del portero
      seasonResumeStats.add( {'nombre' : "MIN" , 'valor':  calculateStatAverage("MIN"),       'helpInfo': 'Minutes played'});

      _totalSums.keys.forEach((key) {
         seasonResumeStats.add({'nombre' : mappedFieldNames[key]["shortName"], 'valor' : calculateStatAverage(key), 'helpInfo': mappedFieldNames[key]["description"]});
      });
  }

  void tabChange(String tab, [String LItabName = null]) {
    querySelectorAll(".soccer-player-stats-content .tab-pane").classes.remove('active');

    Element contentTab = document.querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
    if (LItabName != null) {
      querySelectorAll('#soccer-player-stats-tabs li').classes.remove('active');
      querySelector('#' + LItabName).classes.add("active");
    }
  }

  void onAddClicked() {
    ModalComp.close(currentInfoData['id']);
  }

  SoccerPlayerService _soccerPlayerService;
  FlashMessagesService _flashMessage;

  InstanceSoccerPlayer _instanceSoccerPlayer;

  var _streamListener;
  Element _rootElement;

  // Common Stats
  Map _totalSums = {};
  int _totalMinutes = 0;
}