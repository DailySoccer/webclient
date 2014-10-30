library soccer_players_list_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/field_pos.dart';


@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_list_comp.html',
    useShadowDom: false
)
class SoccerPlayersListComp {

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  ScreenDetectorService scrDet;
  List<dynamic> filteredSoccerPlayers = [];

  @NgOneWay("soccer-players")
  void set soccerPlayers(List<dynamic> sp) {
    filteredSoccerPlayers = sp;

    // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
    sortListByField('Pos', invert: false);
  }

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-add-click")
  Function onAddClick;

  @NgOneWay("field-pos-filter")
  FieldPos get fieldPosFilter => new FieldPos(_filterList[SoccerPlayersListComp.FILTER_POSITION]);
  void     set fieldPosFilter(FieldPos fieldPos) => _setFilter(SoccerPlayersListComp.FILTER_POSITION, fieldPos != null? fieldPos.value : null);

  @NgOneWay("name-filter")
  String get nameFilter => _filterList[SoccerPlayersListComp.FILTER_NAME];
  void   set nameFilter(String val) => _setFilter(SoccerPlayersListComp.FILTER_NAME, val);

  @NgOneWay("match-filter")
  String get matchFilter => _filterList[SoccerPlayersListComp.FILTER_MATCH];
  void   set matchFilter(String matchId) => _setFilter(SoccerPlayersListComp.FILTER_MATCH, matchId);

  void _setFilter(String key, String valor) {
    _filterList[key] = valor;
    _refreshFilter();         // TODO: Hacer esto en el digest o algo asi? Por ejemplo, en removeAllFilters se hace esto 3 veces?
  }

  SoccerPlayersListComp(this.scrDet);

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(String abrevName) => _POS_CLASS_NAMES[abrevName];

  // Numero de caracteres a partir del cual cortamos el nombre y mostramos 3 puntos
  int showWidth(String playerName) => 19;

  void onRow(dynamic slot) {
    if (onRowClick != null) {
      onRowClick({"soccerPlayerId": slot.id});
    }
  }

  void onAdd(dynamic slot) {
    if (onAddClick != null) {
      onAddClick({"soccerPlayer": slot});
    }
  }

  void _refreshFilter() {

    // Cuando todavia la lista no esta rellena...
    if (document.querySelector("#soccerPlayer0") == null) {
      return;
    }

    // TODO
    // Partimos siempre de la lista original de todos los players menos los ya seleccionados en el lineup
    //availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();

    var pos = _filterList[FILTER_POSITION];
    var name = _filterList[FILTER_NAME];
    var matchId = _filterList[FILTER_MATCH];

    if (name != null) {
      name = StringUtils.normalize(name).toUpperCase();
    }

    for (int c = 0; c < filteredSoccerPlayers.length; ++c) {
      var player = filteredSoccerPlayers[c];

      var elem = document.querySelector("#soccerPlayer${c}");

      if ((pos == null || player["fieldPos"].value == pos) &&
          (matchId == null || player["matchId"] == matchId) &&
          (name == null || name.isEmpty ||
          StringUtils.normalize(player["fullName"]).toUpperCase().contains(name))) {
        elem.classes.remove("hidden");
      }
      else {
        elem.classes.add("hidden");
      }
    }
  }

  dynamic compare(String field, var playerA, var playerB) {
    int compResult;
    switch(field) {
      case "fieldPos":
        compResult = playerA["fieldPos"].sortOrder - playerB["fieldPos"].sortOrder;
      break;
      case "Name":
        compResult = compareNameTo(playerA, playerB);
      break;
      default:
        compResult = playerA[field].compareTo(playerB[field]);
      break;
    }

    if (_secondarySort != "" && compResult == 0) {
      switch(_secondarySort) {
        case "Pos":
          compResult = playerB["fieldPos"].sortOrder - playerA["fieldPos"].sortOrder;
        break;
        case "Name":
          compResult = compareNameTo(playerA, playerB);
        break;
        case "DFP":
          compResult = playerA["fantasyPoints"].compareTo(playerB["fantasyPoints"]);
        break;
        case "Played":
          compResult = playerA["playedMatches"].compareTo(playerB["playedMatches"]);
        break;
        case "Salary":
          compResult = playerA["salary"].compareTo(playerB["salary"]);
        break;
      }
    }
    return compResult;
  }

  // TODO: Pasar el sortDir como parametro
  void _refreshSort() {
    switch(_primarySort) {
      case "Pos":
        filteredSoccerPlayers.sort((player1, player2) => _sortDir? compare("fieldPos", player2, player1) : compare("fieldPos", player1, player2));
      break;
      case "Name":
        filteredSoccerPlayers.sort((player1, player2) => _sortDir? compare("Name", player2, player1) : compare("Name", player1, player2));
      break;
      case "DFP":
        filteredSoccerPlayers.sort((player1, player2) => !_sortDir? compare("fantasyPoints", player2, player1): compare("fantasyPoints", player1, player2));
      break;
      case "Played":
        filteredSoccerPlayers.sort((player1, player2) => !_sortDir? compare("playedMatches", player2, player1): compare("playedMatches", player1, player2));
      break;
      case "Salary":
        filteredSoccerPlayers.sort((player1, player2) => !_sortDir? compare("salary", player2, player1): compare("salary", player1, player2));
      break;
    }
  }

  void _changeSort(String fieldName, invert) {
    if (fieldName != _primarySort) {
      _sortDir = false;
      _secondarySort = _primarySort;
      _primarySort = fieldName;
    }
    else if (invert) {
      _sortDir = !_sortDir;
    }
  }

  void sortListByField(String fieldName, {bool invert : true}) {
    _changeSort(fieldName, invert);
    _refreshSort();
  }

  int compareNameTo(playerA, playerB) {
    int comp = StringUtils.normalize(playerA["fullName"]).compareTo(StringUtils.normalize(playerB["fullName"]));
    return comp != 0 ? comp : playerA["id"].compareTo(playerB["id"]);
  }

  Map<String, String> _filterList = {};

  bool _sortDir = false;
  String _primarySort = "";
  String _secondarySort = "";

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
}