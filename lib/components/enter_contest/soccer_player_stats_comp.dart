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
import 'package:webclient/services/server_error.dart';
import 'package:logging/logging.dart';

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

  String _instanceSoccerPlayerId = null;
  @NgOneWay("instance-soccer-player-id")
  void set instanceSoccerPlayerId(String id) {
    _instanceSoccerPlayerId = id; 
    refreshSoccerPlayerData();
  }
  String get instanceSoccerPlayerId => _instanceSoccerPlayerId;
  
  bool _selectablePlayer = null;
  @NgOneWay("selectable-player")
  void set selectablePlayer(bool isSelectable) { _selectablePlayer = isSelectable; }
  bool get selectablePlayer => _selectablePlayer;
  
  String _contestId = null;
  @NgOneWay("contest-id")
  void set contestId(String id) { _contestId = id; }
  String get contestId => _contestId;

  bool isGoalkeeper() => currentInfoData['fieldPos'] == StringUtils.translate("gk", "soccerplayerpositions");

  String get printableSalary => currentInfoData != null? StringUtils.parseSalary(currentInfoData['salary']) : "0";

  //Listas para las estadísticas ordenadas
  static List<String> get goalKeeperStatsList   => [
    getCodeData("keygoalsconceded"),
    getCodeData("keysaves"),
    getCodeData("keyclearances"),
    getCodeData("keypenaltiessaved"),
    getCodeData("keypasses"),
    getCodeData("keyrecovers"),
    getCodeData("keyposslost"),
    getCodeData("keyfoulscommited"),
    getCodeData("keyyellowcards"),
    getCodeData("keyredcards")
  ];

  static List<String> get commonPlayerStatsList => [
    getCodeData("keygoals"),
    getCodeData("keyshots") ,
    getCodeData("keypasses"),
    getCodeData("keychancescreated"),
    getCodeData("keytakeons") ,
    getCodeData("keyrecovers"),
    getCodeData("keyposslost"),
    getCodeData("keyfoulscommited"),
    getCodeData("keyfoulsconceded"),
    getCodeData("keyyellowcards"),
    getCodeData("keyredcards")
  ];

  Map get mappedFieldNames => {
    getCodeData("keypasses")          : {"shortName" : getCodeData("abrevpasses"),        "description" : getCodeData("descpasses")},
    getCodeData("keyrecovers")        : {"shortName" : getCodeData("abrevrecovers"),      "description" : getCodeData("descrecovers")},
    getCodeData("keyposslost")        : {"shortName" : getCodeData("abrevposslost"),      "description" : getCodeData("descposslost")},
    getCodeData("keyfoulscommited")   : {"shortName" : getCodeData("abrevfoulscommited"), "description" : getCodeData("descfoulscommited")},
    getCodeData("keyyellowcards")     : {"shortName" : getCodeData("abrevyellowcards"),   "description" : getCodeData("descyellowcards")},
    getCodeData("keyredcards")        : {"shortName" : getCodeData("abrevredcards"),      "description" : getCodeData("descredcards")},
    getCodeData("keygoalsconceded")   : {"shortName" : getCodeData("abrevgoalsconceded"), "description" : getCodeData("descgoalsconceded")},
    getCodeData("keysaves")           : {"shortName" : getCodeData("abrevsaves"),         "description" : getCodeData("descsaves")},
    getCodeData("keyclearances")      : {"shortName" : getCodeData("abrevclearances"),    "description" : getCodeData("descclearances")},
    getCodeData("keypenaltiessaved")  : {"shortName" : getCodeData("abrevpenaltiessaved"),"description" : getCodeData("descpenaltiessaved")},
    getCodeData("keygoals")           : {"shortName" : getCodeData("abrevgoals"),         "description" : getCodeData("descgoals")},
    getCodeData("keyshots")           : {"shortName" : getCodeData("abrevshots"),         "description" : getCodeData("descshots")},
    getCodeData("keychancescreated")  : {"shortName" : getCodeData("abrevchancescreated"),"description" : getCodeData("descchancescreated")},
    getCodeData("keytakeons")         : {"shortName" : getCodeData("abrevtakeons") ,      "description" : getCodeData("desctakeons") },
    getCodeData("keyfoulsconceded")   : {"shortName" : getCodeData("abrevfoulsconceded"), "description" : getCodeData("descfoulsconceded")}
  };

  static String getCodeData(String key) {
    return StringUtils.translate(key, "soccerplayerstats");
  }
  String getLocalizedText(String key) {
    return StringUtils.translate(key, "soccerplayerstats");
  }
  String getUppercaseLocalizedText(String key) {
    return getLocalizedText(key).toUpperCase();
  }
  String get imgSoccerTeam => currentInfoData != null ? "images/team-shirts/${currentInfoData['shortTeam']}.png" : "";

  SoccerPlayerStatsComp(this._flashMessage, this.scrDet, this._soccerPlayerService, RouteProvider routeProvider, Router router, this._rootElement) {
    contestId = routeProvider.route.parent.parameters.containsKey("contestId") ? routeProvider.route.parent.parameters["contestId"] : null;
    instanceSoccerPlayerId = routeProvider.route.parent.parameters.containsKey("soccerPlayerId") ? routeProvider.route.parameters["soccerPlayerId"] : null;
    
    refreshSoccerPlayerData();
  }
  
  void refreshSoccerPlayerData() {

    Future refreshInstancePlayerInfo;
    if (instanceSoccerPlayerId == null) return;

    // 2 Opciones:
    // a) parent.contestId + instanceSoccerPlayerId + selectable
    // b) soccerPlayerId + selectable
    if (contestId != null) {
      // var instanceSoccerPlayerId = routeProvider.route.parameters['instanceSoccerPlayerId'];
      
      // Optimizacion: Tenemos un instance con la información necesaria?
      InstanceSoccerPlayer instance = _soccerPlayerService.getInstanceSoccerPlayer(contestId, instanceSoccerPlayerId);
      // El instance puede ser null (p.ej. cuando el usuario ha realizado un refresh del browser teniendo abiertas las estadísticas del futbolista)
      if (instance != null) {
        if (instance.hasFullInformation) {
          collectSoccerPlayerInfo(instance);
        }
      }
      
      refreshInstancePlayerInfo = _soccerPlayerService.refreshInstancePlayerInfo(contestId, instanceSoccerPlayerId);
    }
    else {
      //var soccerPlayerId = routeProvider.route.parameters["soccerPlayerId"];
      refreshInstancePlayerInfo = _soccerPlayerService.refreshSoccerPlayerInfo(instanceSoccerPlayerId);
    }

    //selectablePlayer = routeProvider.route.parameters["selectable"] == "true";

    refreshInstancePlayerInfo
      .then((_) {
        updateSoccerPlayerInfoFromService();
      })
      .catchError((ServerError error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      }, test: (error) => error is ServerError);

    //_streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void detach() {
    //_streamListener.cancel();
  }

  void onShadowRoot(ShadowRoot shadowRoot) {
    new Timer(new Duration(seconds: 1), tooltipfy);
  }

  void tooltipfy() {
    var lista = querySelectorAll('.tt-selector');

    JsUtils.runJavascript(".season-stats-row", 'tooltip', null);
  }

  void onScreenWidthChange(String msg) {
    //tabChange('season-stats-tab-content', 'seasonTab');
  }

  void collectSoccerPlayerInfo(InstanceSoccerPlayer _soccerPlayerInstance) {
    _instanceSoccerPlayer = _soccerPlayerInstance;

    if (_instanceSoccerPlayer != null) {
      currentInfoData = {
        'id'              : _instanceSoccerPlayer.id,
        'fieldPos'        : _instanceSoccerPlayer.fieldPos.abrevName,
        'team'            : _instanceSoccerPlayer.soccerTeam.name.toUpperCase(),
        'shortTeam'       : _instanceSoccerPlayer.soccerTeam.shortName.toUpperCase(),
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

    return ("${getLocalizedText('next-match')}: " + matchEventName + matchEventDate);
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
    seasonTableHeaders = [
      getCodeData("date"),
      getCodeData("opponent"),
      getCodeData("dailyfantasypoints"),
      getCodeData("minutes")
    ];

    if(isGoalkeeper()) {
      goalKeeperStatsList.forEach((key) {
        _totalSums[key] = 0;
      });
      seasonTableHeaders.addAll([
        getCodeData("descgoalsconceded"),
        getCodeData("descsaves"),
        getCodeData("descclearances"),
        getCodeData("descpenaltiessaved"),
        getCodeData("descpasses"),
        getCodeData("descrecovers"),
        getCodeData("posessionlost"),
        getCodeData("descfoulscommited"),
        getCodeData("descyellowcards"),
        getCodeData("descredcards")
      ]);
    }
    else {
      commonPlayerStatsList.forEach((key) {
        _totalSums[key] = 0;
      });
      seasonTableHeaders.addAll([
        getCodeData("descgoals"),
        getCodeData("descshots"),
        getCodeData("descpasses"),
        getCodeData("descchancescreated"),
        getCodeData("desctakeons"),
        getCodeData("descrecovers"),
        getCodeData("posessionlost"),
        getCodeData("descfoulscommited"),
        getCodeData("descfoulsconceded"),
        getCodeData("descyellowcards"),
        getCodeData("descredcards")
      ]);
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

        bool isCurrentYearFetching = seasonsList.where((data) => data["year"] == year).length > 0;
        // Si no existe aún este año en la tabla de años, la generamos
        if ( !isCurrentYearFetching ) {
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
      seasonResumeStats.add({ 'nombre' : "MIN" , 
                              'valor':  calculateStatAverage("MIN"), 
                              'helpInfo': getLocalizedText("minutes-played")
                              });

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