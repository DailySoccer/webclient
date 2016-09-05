library soccer_players_scalinglist_comp;

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
import 'package:webclient/models/contest.dart';
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:webclient/utils/scaling_list.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';

@Component(
    selector: 'soccer-players-scalinglist',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_scalinglist_comp.html',
    useShadowDom: false,
    exportExpressions: const ["lineupFilter"]
)
class SoccerPlayersScalingListComp {

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";
  static const String FILTER_FAVORITES = "FILTER_FAVORITES";

  static const int MIN_PLAYER_SHOWN = 15;

  List<SoccerPlayerListItem> lineupFilter = [];
  List<SoccerPlayerListItem> soccerPlayerList = null;
  
  ScalingList<SoccerPlayerListItem> currentSoccerPlayerList = new ScalingList<SoccerPlayerListItem>(MIN_PLAYER_SHOWN, (p1, p2) => p1.id == p2.id);
  

  @NgOneWay("soccer-players")
  void set setSoccerPlayers(List<SoccerPlayerListItem> sp) {
    _setSort();
    soccerPlayerList = sp;
    _refreshFilters();
  }
  
  @NgOneWay("manager-level")
  num managerLevel;

  @NgOneWay("contest")
  Contest contest;

  @NgOneWay("field-pos-filter")
  FieldPos get fieldPosFilter => new FieldPos(_filterList[FILTER_POSITION]);
  void     set fieldPosFilter(FieldPos fieldPos) => _setFilter(FILTER_POSITION, fieldPos != null? fieldPos.value : null);

  @NgOneWay("only-favorites")
  bool     get onlyFavorites {
    if (_filterList[FILTER_FAVORITES] == null) {
      _filterList[FILTER_FAVORITES] = false;
    }
    return _filterList[FILTER_FAVORITES];
  }
  void     set onlyFavorites(bool only) => _setFilter(FILTER_FAVORITES, only);

  @NgOneWay("favorites-list")
  List     get favoritesList => _favoritesList == null? [] : _favoritesList;
  void     set favoritesList(List favs) { _favoritesList = favs; }

  @NgOneWay("name-filter")
  String get nameFilter => _filterList[FILTER_NAME];
  void   set nameFilter(String val) => _setFilter(FILTER_NAME, val);

  @NgOneWay("match-filter")
  String get matchFilter => _filterList[FILTER_MATCH];
  void   set matchFilter(String matchId) => _setFilter(FILTER_MATCH, matchId);

  @NgOneWay("hide-lineup-players")
  bool hideLineupPlayers = false;
  
  @NgOneWay("additional-gold-price")
  Money additionalGoldPrice = new Money.zeroFrom(Money.CURRENCY_GOLD);

  @NgOneWay("lineup-filter")
  void set setLineupFilter(List<dynamic> sp) {
    if (sp == lineupFilter || sp == null) {
      return;
    }

    lineupFilter = sp;
    /*
    if (_lineupFilterWatch != null) {
      _lineupFilterWatch.remove();
      _lineupFilterWatch = null;
    }
    _lineupFilterWatch = _scope.watch("lineupFilter", _onLineupFilterChanged, canChangeModel: false, collection:true);
    */
    // Siempre que reseteen la lista, empezamos ordenados por posicion
    sortListByField('Pos', invert: false);
  }

  @NgOneWay("is-scouting-list")
  bool isScoutingList;  
  
  @NgCallback("on-info-click")
  Function onInfoClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  dynamic get filterPosVal => _filterList[FILTER_POSITION];
  dynamic get filterMatchIdVal => _filterList[FILTER_MATCH];
  dynamic get filterNameVal => _filterList[FILTER_NAME] == null? null : StringUtils.normalize(_filterList[FILTER_NAME]).toUpperCase();
  
  SoccerPlayersScalingListComp(this._scrDet, this._profileService);

  String getLocalizedText(key) {
    return StringUtils.translate(key, "soccerplayerlist");
  }
  /*
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
            Money moneyToBuy = soccerPlayer['instanceSoccerPlayer'].moneyToBuy(contest, managerLevel);
            bool addButton = !lineupFilter.contains(soccerPlayer);
            elem.setInnerHtml(_getActionButton(addButton, moneyToBuy), treeSanitizer: NULL_TREE_SANITIZER);
            elem.classes.removeAll(['add', 'remove']);
            elem.classes.add(addButton? 'add' : 'remove');
          }
        }
      }

      changes.forEachAddition(inner);
      changes.forEachRemoval(inner);
    }
  }*/
  
  void _setSort() {
    currentSoccerPlayerList.sortComparer = (SoccerPlayerListItem p1, SoccerPlayerListItem p2) {
      int compResult = 0;
      int fieldIndex = 0;

      // Ordenamos por todos los campos uno tras otro
      do {
        Function getField = _sortList[fieldIndex]["getField"];
        int currOrder = _sortList[fieldIndex]["order"];
        compResult = currOrder * getField(p1).compareTo(getField(p2));
        fieldIndex++;
      } while(compResult == 0 && fieldIndex < _sortList.length);

      return compResult;
    };
  }
  
  bool isAddAction(SoccerPlayerListItem player) {
    return !lineupFilter.contains(player);
  }
  bool soccerPlayerIsAvailable(SoccerPlayerListItem player) {
    return player.moneyToBuy.toInt() == 0;
  }
  String getActionButton(SoccerPlayerListItem player) {
    bool addButton = isAddAction(player);
    Money moneyToBuy = player.moneyToBuy;
    bool isFree = moneyToBuy.toInt() == 0;
    String buttonText = !addButton? '-' : isFree? '+' : '<span class="coins-to-buy">${moneyToBuy.toInt()}</span>';
    return '<button type="button" class="action-button ${addButton? 'add' : 'remove'} ${isFree? 'free-purchase' : 'coin-purchase'}">$buttonText</button>';
  }
  
  String parseFantasyPoints(SoccerPlayerListItem player) {
    return StringUtils.parseFantasyPoints(player.fantasyPoints);
  }
  String parseSalary(SoccerPlayerListItem player) {
    return StringUtils.parseSalary(player.salary);
  }

  void sortListByField(String fieldName, {bool invert : true}) {

    var newSortField = _SORT_FIELDS[fieldName];

    // Vamos memorizando todos los campos por los que ordenamos
    if (newSortField["getField"] != _sortList[0]["getField"]) {
      _sortList.insert(0, newSortField);

      if (_sortList.length > _SORT_FIELDS.length) {
        _sortList.removeLast();
      }
    }
    else if (invert) {
      _sortList[0]['order'] = -_sortList[0]['order'];
    }

    _setSort();
  }
  
  String getImgPerSoccerTeam(SoccerPlayerListItem slot) => "images/team-shirts/${slot.soccerTeam.shortName}.png";
  
  void _setFilter(String key, dynamic valor) {
    // En movil no permitimos nunca poner el filtro vacio!
    if (_scrDet.isXsScreen && key == FILTER_POSITION && valor == null) {
      return;
    }

    _filterList[key] = valor;
    _refreshFilters();
  }
  
  void _refreshFilters() {
    if ( soccerPlayerList != null ) {
      currentSoccerPlayerList.elements = soccerPlayerList.where(_isVisibleWithFilters).toList();
    }
  }
  
  bool _isVisibleWithFilters(SoccerPlayerListItem player) {
    return (filterPosVal == null || player.fieldPos.value == filterPosVal) &&
           (filterMatchIdVal == null || player.matchId == filterMatchIdVal) &&
           (filterNameVal == null || filterNameVal.isEmpty || player.fullNameNormalized.contains(filterNameVal)) &&
           (!onlyFavorites || (onlyFavorites && favoritesList.contains(player)));
  }
  
  List<Map> _sortList = [_SORT_FIELDS["Pos"], _SORT_FIELDS["Name"]];
  static final Map<String, Map> _SORT_FIELDS = { "Pos":    { 'getField': (SoccerPlayerListItem p) => p.fieldPosSortOrder, 'order': 1 },
                                                 "Name":   { 'getField': (SoccerPlayerListItem p) => p.fullNameNormalized, 'order': 1 },
                                                 "DFP":    { 'getField': (SoccerPlayerListItem p) => p.fantasyPoints, 'order': -1 },
                                                 "Played": { 'getField': (SoccerPlayerListItem p) => p.playedMatches, 'order': -1 },
                                                 "Salary": { 'getField': (SoccerPlayerListItem p) => p.salary, 'order': -1 }};

  Map<String, String> POS_CLASS_NAMES = {
    StringUtils.translate("gk", "soccerplayerpositions") : "posPOR",
    StringUtils.translate("def", "soccerplayerpositions"): "posDEF",
    StringUtils.translate("mid", "soccerplayerpositions"): "posMED",
    StringUtils.translate("for", "soccerplayerpositions"): "posDEL"
  };
  
  List<dynamic> _favoritesList = null;
  //List<dynamic> _sortedSoccerPlayers = null;
  Map<String, dynamic> _filterList = {};
  //Watch _lineupFilterWatch;
  //Scope _scope;
  
  ProfileService _profileService;
  ScreenDetectorService _scrDet;
}