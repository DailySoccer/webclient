library soccer_players_list_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
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

  List<dynamic> sortedSoccerPlayers = [];
  List<String> sortList = ["+fieldPosSortOrder", "+fullNameNormalized"];


  @NgOneWay("soccer-players")
  void set soccerPlayers(List<dynamic> sp) {
    sortedSoccerPlayers = sp;

    // Cuando se re-inicializa la lista de jugadores, esta se ordena por posicion
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

    // TODO: Hacer esto en el digest o algo asi? Por ejemplo, en removeAllFilters se hace 3 veces
    _refreshFilter();
  }

  SoccerPlayersListComp(this.scrDet);

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(String abrevName) => _POS_CLASS_NAMES[abrevName];

  // Numero de caracteres a partir del cual cortamos el nombre y mostramos 3 puntos
  int showWidth(String playerName) => 19;

  void onRow(dynamic slot) {
    if (onRowClick != null) {
      onRowClick({"soccerPlayerId": slot['id']});
    }
  }

  void onAdd(dynamic slot) {
    if (onAddClick != null) {
      onAddClick({"soccerPlayer": slot});
    }
  }

  // En vez de cambiar la lista que se renderiza con ng-repeat, es mucho mas rapido tocar el hidden
  void _refreshFilter() {

    var pos = _filterList[FILTER_POSITION];
    var name = _filterList[FILTER_NAME];
    var matchId = _filterList[FILTER_MATCH];

    if (name != null) {
      name = StringUtils.normalize(name).toUpperCase();
    }

    for (int c = 0; c < sortedSoccerPlayers.length; ++c) {
      var player = sortedSoccerPlayers[c];
      int intId = player['intId'];

      var elem = document.querySelector("#soccerPlayer${intId}");

      if (elem == null) {
        continue;
      }

      if (_shouldBeVisible(player, pos, matchId, name)) {
        elem.classes.remove("hidden");
      }
      else {
        elem.classes.add("hidden");
      }
    }
  }

  bool _shouldBeVisible(player, pos, matchId, name) {
    return (pos == null || player["fieldPos"].value == pos) &&
           (matchId == null || player["matchId"] == matchId) &&
           (name == null || name.isEmpty || player["fullNameNormalized"].contains(name));
  }

  void sortListByField(String fieldName, {bool invert : true}) {
    var newSortField = _SORT_FIELDS[fieldName];

    if (newSortField != sortList[0]) {
      sortList[1] = sortList[0];
      sortList[0] = newSortField;
    }
    else if (invert) {
      if (sortList[0].startsWith("+")) {
        sortList[0] = "-" + sortList[0].substring(1);
      }
      else {
        sortList[0] = "+" + sortList[0].substring(1);
      }
    }
  }

  Map<String, String> _filterList = {};

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
  static final Map<String, String> _SORT_FIELDS = { "Name": "+fullNameNormalized", "DFP": "-fantasyPoints",
                                                    "Played": "-playedMatches", "Salary": "-salary", "Pos": "+fieldPosSortOrder" };
}