library soccer_players_list_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:angular/change_detection/change_detection.dart';


@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_list_comp.html',
    useShadowDom: false,
    exportExpressions: const ["sortedSoccerPlayers"]
)
class SoccerPlayersListComp implements ShadowRootAware, ScopeAware, DetachAware {

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  ScreenDetectorService scrDet;

  List<dynamic> sortedSoccerPlayers = [];
  List<Map> sortList = [_SORT_FIELDS["Pos"], _SORT_FIELDS["Name"]];

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-add-click")
  Function onAddClick;

  @NgOneWay("field-pos-filter")
  FieldPos get fieldPosFilter => new FieldPos(_filterList[FILTER_POSITION]);
  void     set fieldPosFilter(FieldPos fieldPos) => _setFilter(FILTER_POSITION, fieldPos != null? fieldPos.value : null);

  @NgOneWay("name-filter")
  String get nameFilter => _filterList[FILTER_NAME];
  void   set nameFilter(String val) => _setFilter(FILTER_NAME, val);

  @NgOneWay("match-filter")
  String get matchFilter => _filterList[FILTER_MATCH];
  void   set matchFilter(String matchId) => _setFilter(FILTER_MATCH, matchId);

  void _setFilter(String key, String valor) {
    _filterList[key] = valor;
    _isDirty = true;
  }

  @NgOneWay("soccer-players")
  void set soccerPlayers(List<dynamic> sp) {
    sortedSoccerPlayers = sp;
    sortListByField('Pos', invert: false);
    _isDirty = true;

    if (_soccerPlayersWatch != null) {
      _soccerPlayersWatch.remove();
      _soccerPlayersWatch = null;
    }
    _soccerPlayersWatch = _scope.watch("sortedSoccerPlayers", _onSoccerPlayersChanged, canChangeModel: false, collection:true);
  }

  SoccerPlayersListComp(this.scrDet, this._element);

  void _onSoccerPlayersChanged(changes, other) {
    if (changes != null && changes is CollectionChangeRecord) {
      /*
      changes.forEachRemoval((changedItem) {
        querySelector("#soccerPlayer${changedItem.item['intId']}").remove();
      });
      changes.forEachAddition((changedItem) {
        if (_shouldBeVisible(changedItem.item)) {
          _soccerPlayerListRoot.appendHtml(getHtmlForSlot(changedItem.item));
        }
      });
      */
      _isDirty = true;
    }
  }

  @override void onShadowRoot(emulated) {
    window.animationFrame.then(_onAnimationFrame);
  }

  @override void set scope(Scope theScope) {
    _scope = theScope;
  }

  @override void detach() {
    if (_soccerPlayersWatch != null) {
      _soccerPlayersWatch.remove();
    }
  }

  void _onAnimationFrame(elapsed) {
    if (_isDirty) {
      _generateSlots();
      _isDirty = false;
    }
    window.animationFrame.then(_onAnimationFrame);
  }

  void _removeSlots() {
    if (_soccerPlayerListRoot != null) {
      _soccerPlayerListRoot.remove();
      _soccerPlayerListRoot = null;
    }
  }

  void _generateSlots() {
    Stopwatch sw = new Stopwatch()..start();

    _removeSlots();

    _soccerPlayerListRoot = new DivElement();
    _soccerPlayerListRoot.classes.add("soccer-players-list");

    var filterPosVal = _filterList[FILTER_POSITION];
    var filterMatchIdVal = _filterList[FILTER_MATCH];
    var filterNameVal = _normalizedNameFilter;

    StringBuffer allHtml = new StringBuffer();

    int length = sortedSoccerPlayers.length;
    for (int c = 0; c < length; ++c) {
      var slot = sortedSoccerPlayers[c];

      if (!_shouldBeVisibleWithFilters(slot, filterPosVal, filterMatchIdVal, filterNameVal)) {
        continue;
      }

      allHtml.write(getHtmlForSlot(slot));
    }

    _soccerPlayerListRoot.appendHtml(allHtml.toString());
    _element.append(_soccerPlayerListRoot);

    _element.querySelectorAll(".soccer-players-list-slot").onClick.listen(_onMouseEvent);

    print("Ha tardado: ${sw.elapsedMilliseconds}");
  }

  String getHtmlForSlot(var slot) {
    return '''
      <div id="soccerPlayer${slot["intId"]}" class="soccer-players-list-slot ${_POS_CLASS_NAMES[slot["fieldPos"].abrevName]}">
        <div class="column-fieldpos">${slot["fieldPos"].abrevName}</div>
        <div class="column-primary-info">
          <span class="soccer-player-name">${slot["fullName"]}</span>
          <span class="match-event-name">${slot["matchEventName"]}</span>
        </div>
        <div class="column-dfp">${slot["fantasyPoints"]}</div>
        <div class="column-played">${slot["playedMatches"]}</div>
        <div class="column-salary">${slot["salary"]}€</div>
        <div class="column-add">
          <button type="button" class="btn">Añadir</button>
        </div>
      </div>
    ''';
  }

  void _onMouseEvent(MouseEvent e) {
    int divId = int.parse((e.currentTarget as DivElement).id.replaceFirst("soccerPlayer", ""));
    var clickedSlot = sortedSoccerPlayers.firstWhere((slot) => slot['intId'] == divId);

    if (e.target is ButtonElement) {
      if (onAddClick != null) {
        onAddClick({"soccerPlayer": clickedSlot});
      }
    }
    else if (onRowClick != null) {
      onRowClick({"soccerPlayerId": clickedSlot['id']});
    }
  }

  static bool _shouldBeVisibleWithFilters(player, pos, matchId, name) {
    return (pos == null || player["fieldPos"].value == pos) &&
           (matchId == null || player["matchId"] == matchId) &&
           (name == null || name.isEmpty || player["fullNameNormalized"].contains(name));
  }

  bool _shouldBeVisible(player) => !_shouldBeVisibleWithFilters(player, _filterList[FILTER_POSITION], _filterList[FILTER_MATCH], _filterList[FILTER_NAME]);


  void sortListByField(String fieldName, {bool invert : true}) {
    var newSortField = _SORT_FIELDS[fieldName];

    // Vamos memorizando todos los campos por los que ordenamos
    if (newSortField["field"] != sortList[0]["field"]) {
      sortList.insert(0, newSortField);

      if (sortList.length > _SORT_FIELDS.length) {
        sortList.removeLast();
      }
    }
    else if (invert) {
      sortList[0]['order'] = -sortList[0]['order'];
    }

    sortedSoccerPlayers.sort((player1, player2) {
      int compResult = 0;
      int fieldIndex = 0;

      // Ordenamos por todos los campos uno tras otro
      do {
        String currField = sortList[fieldIndex]["field"];
        int currOrder = sortList[fieldIndex]["order"];
        compResult = currOrder * player1[currField].compareTo(player2[currField]);
        fieldIndex++;
      } while(compResult == 0 && fieldIndex < sortList.length);

      return compResult;
    });

    // Al ordenar se dispara un cambio en la lista, no hace falta marcar aqui _isDirty = true
  }

  String get _normalizedNameFilter => _filterList[FILTER_MATCH] == null? null : StringUtils.normalize(_filterList[FILTER_MATCH]).toUpperCase();

  Element _element;
  DivElement _soccerPlayerListRoot;
  bool _shadowRoot = false;
  bool _isDirty = false;
  Scope _scope;
  Watch _soccerPlayersWatch;

  Map<String, String> _filterList = {};

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
  static final Map<String, Map> _SORT_FIELDS = { "Name": _getSortField("fullNameNormalized", 1),
                                                 "DFP": _getSortField("fantasyPoints", -1),
                                                 "Played": _getSortField("playedMatches", -1),
                                                 "Salary": _getSortField("salary", -1),
                                                 "Pos": _getSortField("fieldPosSortOrder", 1)};

  static Map _getSortField(name, order) => {'field': name, 'order': order };
}