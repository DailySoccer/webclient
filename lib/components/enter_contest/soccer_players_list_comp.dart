library soccer_players_list_comp;

import 'package:angular/angular.dart';
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

  @NgTwoWay("soccer-players")
  List<dynamic> get soccerPlayers => _soccerPlayers;
  void          set soccerPlayers(List<dynamic> sp) {
    _soccerPlayers = sp;

    // TODO ?
    _refreshFilter();

    // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
    // TODO: Doble trabajo?
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

    if (_supressRefresh) {
      return;
    }

    // TODO
    /*
    if (_filterList.isEmpty && availableSoccerPlayers.length == _allSoccerPlayers.length)
       return;
    */

    // TODO
    // Partimos siempre de la lista original de todos los players menos los ya seleccionados en el lineup
    //availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();

    Iterable<dynamic> iterable = _soccerPlayers;

    // Recorremos la lista de filtros y aplicamos los que no sean nulos
    _filterList.forEach((String clave, String valor) {
      if (valor != null) {
        switch(clave) {
          case FILTER_POSITION:
            iterable = iterable.where((soccerPlayer) => soccerPlayer["fieldPos"].value == valor);
          break;
          case FILTER_NAME:
            iterable = iterable.where((soccerPlayer) => StringUtils.normalize(soccerPlayer["fullName"]).toUpperCase().contains(StringUtils.normalize(valor).toUpperCase()));
          break;
          case FILTER_MATCH:
            iterable = iterable.where((soccerPlayer) => soccerPlayer["matchId"] == valor);
          break;
        }
      }
    });

    _soccerPlayers = iterable.toList();
    _refreshOrder();

    /* TODO: Se detecta desde fuera?
    _supressRefresh = true;
    soccerPlayers = _soccerPlayers;
    _supressRefresh = false;
    */
  }


  void sortListByField(String fieldName, {bool invert : true}) {
    if (fieldName != _primarySort) {
      _sortDir = false;
      _secondarySort = _primarySort;
      _primarySort = fieldName;
    }
    else if (invert) {
      _sortDir = !_sortDir;
    }
    _refreshOrder();
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
  void _refreshOrder() {
    switch(_primarySort) {
      case "Pos":
        _soccerPlayers.sort((player1, player2) => _sortDir? compare("fieldPos", player2, player1) : compare("fieldPos", player1, player2));
      break;
      case "Name":
        _soccerPlayers.sort((player1, player2) => _sortDir? compare("Name", player2, player1) : compare("Name", player1, player2));
      break;
      case "DFP":
        _soccerPlayers.sort((player1, player2) => !_sortDir? compare("fantasyPoints", player2, player1): compare("fantasyPoints", player1, player2));
      break;
      case "Played":
        _soccerPlayers.sort((player1, player2) => !_sortDir? compare("playedMatches", player2, player1): compare("playedMatches", player1, player2));
      break;
      case "Salary":
        _soccerPlayers.sort((player1, player2) => !_sortDir? compare("salary", player2, player1): compare("salary", player1, player2));
      break;
    }
  }

  int compareNameTo(playerA, playerB) {
    int comp = StringUtils.normalize(playerA["fullName"]).compareTo(StringUtils.normalize(playerB["fullName"]));
    return comp != 0 ? comp : playerA["id"].compareTo(playerB["id"]);
  }

  List<dynamic> _soccerPlayers;
  Map<String, String> _filterList = {};

  bool _sortDir = false;
  String _primarySort = "";
  String _secondarySort = "";

  bool _supressRefresh = false;

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
}