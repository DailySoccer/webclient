library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/change_detection/change_detection.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/money.dart';


@Component(
    selector: 'soccer-players-list',
    useShadowDom: false,
    exportExpressions: const ["lineupFilter"]
)
class SoccerPlayersListComp implements ShadowRootAware, ScopeAware, DetachAware {

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;
  
  @NgOneWay("manager-level")
  num managerLevel;

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

    // En movil no permitimos nunca poner el filtro vacio!
    if (_scrDet.isXsScreen && key == FILTER_POSITION && valor == null) {
      return;
    }

    _filterList[key] = valor;
    _isDirty = true;
  }

  @NgOneWayOneTime("soccer-players")
  void set setSoccerPlayers(List<dynamic> sp) {
    if (sp == _sortedSoccerPlayers) {
      return;
    }
    _sortedSoccerPlayers = sp;  // Nos quedamos directamente con la lista sin hacer copias y la ordenaremos.
    _refreshSort();
  }

  @NgOneWay("lineup-filter")
  void set setLineupFilter(List<dynamic> sp) {
    if (sp == lineupFilter) {
      return;
    }

    lineupFilter = sp;

    if (_lineupFilterWatch != null) {
      _lineupFilterWatch.remove();
      _lineupFilterWatch = null;
    }
    _lineupFilterWatch = _scope.watch("lineupFilter", _onLineupFilterChanged, canChangeModel: false, collection:true);

    // Siempre que reseteen la lista, empezamos ordenados por posicion
    sortListByField('Pos', invert: false);

    _isDirty = true;
  }

  List<dynamic> lineupFilter = [];

  String getLocalizedText(key) {
    return StringUtils.translate(key, "soccerplayerlist");
  }
  
  SoccerPlayersListComp(this._scrDet, this._element, this._turnZone, this._profileService);

  void _onLineupFilterChanged(changes, _) {
    if (_soccerPlayerListRoot == null) {
      return;
    }

    if (changes != null && changes is CollectionChangeRecord) {

      void inner(changedItem) {
        var soccerPlayer = changedItem.item;

        if (soccerPlayer != null) {
          var elem = _soccerPlayerListRoot.querySelector("#soccerPlayer${soccerPlayer['intId']} .column-action");

          // Quiza nos mandan quitar un portero pero estamos filtrando por defensas....
          if (elem != null) {
            Money moneyToBuy = soccerPlayer['instanceSoccerPlayer'].moneyToBuy(managerLevel);
            elem.setInnerHtml(_getActionButton(!lineupFilter.contains(soccerPlayer), moneyToBuy), treeSanitizer: NULL_TREE_SANITIZER);
          }
        }
      }

      changes.forEachAddition(inner);
      changes.forEachRemoval(inner);
    }
  }

  @override void onShadowRoot(emulated) {
    _createSortHeader();

    // El proceso de generacion de slots corre fuera de la zona de angular. Los clicks que se capturan en los slots por lo tanto tb.
    // Es decir, hacer un click en un boton de por si no genera un digest. Sin embargo, el click bublea al body (HtmlBodyClick) y ahi
    // si que se genera un digest.
    _turnZone.runOutsideAngular(() => _onAnimationFrame(0));
  }

  @override void set scope(Scope theScope) {
    _scope = theScope;
  }

  @override void detach() {
    if (_lineupFilterWatch != null) {
      _lineupFilterWatch.remove();
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

  void _createSortHeader() {
    var text = '''
      <div class="soccer-player-list-header-table">
        <div class="filter filterOrderPos"><a id="Pos">${getLocalizedText('positionabrev')}</a></div>
        <div class="filter filterOrderName"><a id="Name">${getLocalizedText('name')}</a></div>
        <div class="filter filterOrderDFP"><a id="DFP">${getLocalizedText('dfp')}</a></div>
        <div class="filter filterOrderPlayed"><a id="Played">${getLocalizedText('numMatchesAbrev')}</a></div>
        <div class="filter filterOrderSalary"><a id="Salary">${getLocalizedText('salary')}</a></div>
      </div>
      ''';

    _element.appendHtml(text);
    _element.querySelectorAll(".filter a").onClick.listen((MouseEvent e) {
      sortListByField((e.currentTarget as Element).id);
    });
  }

  void _generateSlots() {

    _removeSlots();

    if (_sortedSoccerPlayers == null) {
      return;
    }

    _soccerPlayerListRoot = new DivElement();
    _soccerPlayerListRoot.classes.add("soccer-players-list");

    var filterPosVal = _filterList[FILTER_POSITION];
    var filterMatchIdVal = _filterList[FILTER_MATCH];
    var filterNameVal = _normalizedNameFilter;

    StringBuffer allHtml = new StringBuffer();

    int length = _sortedSoccerPlayers.length;
    for (int c = 0; c < length; ++c) {
      var slot = _sortedSoccerPlayers[c];

      if (_isVisibleWithFilters(slot, filterPosVal, filterMatchIdVal, filterNameVal)) {
        allHtml.write(_getHtmlForSlot(slot, !lineupFilter.contains(slot)));
      }
    }

    _soccerPlayerListRoot.appendHtml(allHtml.toString());
    _element.append(_soccerPlayerListRoot);

    _element.querySelectorAll(".soccer-player-info").onClick.listen(_onSoccerPlayerInfo);
    _element.querySelectorAll(".column-action").onClick.listen(_onSoccerPlayerAction);
  }

  /*
   * 
  String _getHtmlForSlot(var slot, bool addButton) { 
    InstanceSoccerPlayer soccerPlayer = slot['instanceSoccerPlayer'];
    Money moneyToBuy = slot['instanceSoccerPlayer'].moneyToBuy(managerLevel);
    bool soccerPlayerIsAvailable = moneyToBuy.toInt() == 0;
    String strAddButton = _getActionButton(addButton, moneyToBuy);
    
    return '''
      <div id="soccerPlayer${slot["intId"]}" class="soccer-players-list-slot ${_POS_CLASS_NAMES[slot["fieldPos"].abrevName]} ${!soccerPlayerIsAvailable? 'not-available' : ''}">
        <div id="soccerPlayerInfo${slot["intId"]}" class="soccer-player-info">
          <div class="column-fieldpos">${slot["fieldPos"].abrevName}</div>
          <div class="column-primary-info">
            <span class="soccer-player-name">${slot["fullName"]}</span>
            <span class="match-event-name">${slot["matchEventName"]}</span>
          </div>
          <div class="column-dfp">${StringUtils.parseFantasyPoints(slot["fantasyPoints"])}</div>
          <div class="column-played">${slot["playedMatches"]}</div>
          <div class="column-salary">\$${StringUtils.parseSalary(slot["salary"])}</div>
          <div class="column-manager-level"><span class="manager-level-needed">${soccerPlayer.level}</span></div>
        </div>
        <div class="column-action" id="soccerPlayerAction${slot["intId"]}" >
          ${strAddButton}
        </div>
      </div>
    ''';
  }
  */
  
  
  // FIXME: Pillar la funcion de arriba, esta está adaptada para las pruebas 
  String _getHtmlForSlot(var slot, bool addButton) { 
    //InstanceSoccerPlayer soccerPlayer = slot['instanceSoccerPlayer'];
    Money moneyToBuy = new Money.fromValue(10);//soccerPlayer.moneyToBuy(managerLevel);
    bool soccerPlayerIsAvailable = moneyToBuy.toInt() == 0;
    String strAddButton = _getActionButton(addButton, moneyToBuy);
    
    return '''
      <div id="soccerPlayer${slot["intId"]}" class="soccer-players-list-slot ${_POS_CLASS_NAMES[slot["fieldPos"].abrevName]} ${!soccerPlayerIsAvailable? 'not-available' : ''}">
        <div id="soccerPlayerInfo${slot["intId"]}" class="soccer-player-info">
          <div class="column-fieldpos">${slot["fieldPos"].abrevName}</div>
          <div class="column-primary-info">
            <span class="soccer-player-name">${slot["fullName"]}</span>
            <span class="match-event-name">${slot["matchEventName"]}</span>
          </div>
          <div class="column-dfp">${StringUtils.parseFantasyPoints(slot["fantasyPoints"])}</div>
          <div class="column-played">${slot["playedMatches"]}</div>
          <div class="column-salary">\$${StringUtils.parseSalary(slot["salary"])}</div>
          <div class="column-manager-level"><span class="manager-level-needed">${(slot['id']%5) + 1 /*soccerPlayer.level*/}</span></div>
        </div>
        <div class="column-action" id="soccerPlayerAction${slot["intId"]}" >
          ${strAddButton}
        </div>
      </div>
    ''';
  }

  String _getActionButton(bool addButton, Money moneyToBuy) {
    bool isFree = moneyToBuy.toInt() == 0;
    String buttonText = !addButton? '-' : isFree? '+' : '<span class="coins-to-buy">${moneyToBuy.toInt()}</span>';
    
    return '<button type="button" class="action-button ${addButton? 'add' : 'remove'} ${isFree? 'free-purchase' : 'coin-purchase'}">$buttonText</button>';
  }

  void _onSoccerPlayerAction(MouseEvent e) {
    DivElement div = e.currentTarget as DivElement;
    
    int soccerPlayerId = int.parse(div.id.replaceFirst("soccerPlayerAction", ""));
    var clickedSlot = _sortedSoccerPlayers.firstWhere((slot) => slot['intId'] == soccerPlayerId);
    
    if (onActionClick != null) {
      onActionClick({"soccerPlayer": clickedSlot});
    }
  }

  void _onSoccerPlayerInfo(MouseEvent e) {
    DivElement div = e.currentTarget as DivElement;
    
    int divId = int.parse(div.id.replaceFirst("soccerPlayerInfo", ""));
    var clickedSlot = _sortedSoccerPlayers.firstWhere((slot) => slot['intId'] == divId);
    
    if (onRowClick != null) {
      onRowClick({"soccerPlayerId": clickedSlot['id']});
    }
  }  
  
  static bool _isVisibleWithFilters(player, pos, matchId, name) {
    return (pos == null || player["fieldPos"].value == pos) &&
           (matchId == null || player["matchId"] == matchId) &&
           (name == null || name.isEmpty || player["fullNameNormalized"].contains(name));
  }

  bool _isVisible(player) => !_isVisibleWithFilters(player, _filterList[FILTER_POSITION], _filterList[FILTER_MATCH], _filterList[FILTER_NAME]);


  void sortListByField(String fieldName, {bool invert : true}) {

    var newSortField = _SORT_FIELDS[fieldName];

    // Vamos memorizando todos los campos por los que ordenamos
    if (newSortField["field"] != _sortList[0]["field"]) {
      _sortList.insert(0, newSortField);

      if (_sortList.length > _SORT_FIELDS.length) {
        _sortList.removeLast();
      }
    }
    else if (invert) {
      _sortList[0]['order'] = -_sortList[0]['order'];
    }

    _refreshSort();
  }

  void _refreshSort() {

    if (_sortedSoccerPlayers == null) {
      return;
    }

    _sortedSoccerPlayers.sort((player1, player2) {
      int compResult = 0;
      int fieldIndex = 0;

      // Ordenamos por todos los campos uno tras otro
      do {
        String currField = _sortList[fieldIndex]["field"];
        int currOrder = _sortList[fieldIndex]["order"];
        compResult = currOrder * player1[currField].compareTo(player2[currField]);
        fieldIndex++;
      } while(compResult == 0 && fieldIndex < _sortList.length);

      return compResult;
    });

    _isDirty = true;
  }

  String get _normalizedNameFilter => _filterList[FILTER_NAME] == null? null : StringUtils.normalize(_filterList[FILTER_NAME]).toUpperCase();

  VmTurnZone _turnZone;
  ScreenDetectorService _scrDet;
  Element _element;
  DivElement _soccerPlayerListRoot;
  bool _shadowRoot = false;
  bool _isDirty = false;
  Scope _scope;
  Watch _lineupFilterWatch;
  ProfileService _profileService;
  

  List<dynamic> _sortedSoccerPlayers = null;
  List<Map> _sortList = [_SORT_FIELDS["Pos"], _SORT_FIELDS["Name"]];
  Map<String, String> _filterList = {};

  static final Map<String, String> _POS_CLASS_NAMES = {
    StringUtils.translate("gk", "soccerplayerpositions") : "posPOR",
    StringUtils.translate("def", "soccerplayerpositions"): "posDEF",
    StringUtils.translate("mid", "soccerplayerpositions"): "posMED",
    StringUtils.translate("for", "soccerplayerpositions"): "posDEL"
  };
  static final Map<String, Map> _SORT_FIELDS = { "Name": _getSortField("fullNameNormalized", 1),
                                                 "DFP": _getSortField("fantasyPoints", -1),
                                                 "Played": _getSortField("playedMatches", -1),
                                                 "Salary": _getSortField("salary", -1),
                                                 "Pos": _getSortField("fieldPosSortOrder", 1)};

  static Map _getSortField(name, order) => {'field': name, 'order': order };
}