library lineup_field_selector_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';


@Component(
    selector: 'lineup-field-selector',
    templateUrl: 'packages/webclient/components/enter_contest/lineup_field_selector_comp.html',
    useShadowDom: false
)
class LineupFieldSelectorComp {
/*
  @NgOneWay("not-enough-resources")
  bool alertNotEnoughResources;
*/
  /*
  @NgOneWay("resource")
  String resource;

  @NgOneWay("has-negative-balance")
  bool alertNegativeBalance;

  @NgOneWay("has-max-players-same-team")
  bool alertMaxPlayersSameTeamExceed;

  @NgOneWay("manager-level")
  num managerLevel = 0;
*/
  @NgOneWay("formation-is-modifiable")
  bool formationIsModifiable = true;
  
  @NgOneWay("lineup-slots")
  List<SoccerPlayerListItem> lineupSlots = [];

  @NgOneWay("lineup-formation")
  List<String> lineupFormation = FieldPos.FORMATIONS[ContestEntry.FORMATION_442];

  @NgCallback("on-lineup-slot-selected")
  Function onLineupSlotSelected;

  @NgTwoWay("formation-id")
  String get formationId => _formationId;
  void set formationId(String value) {
    _formationId = value;
  }

  @NgOneWay("show-salary")
  bool showSalary = true;
  
  @NgOneWay("is-live")
  bool isLive = false;
  
  @NgOneWay("highlight-changeables")
  bool highlightChangeables = false;
  
  bool showLivePoints(SoccerPlayerListItem item) { 
    return (item.isPlaying || item.hasPlayed) && isLive;
  }
  
  bool canBeChanged() {
    
  }
  
  String get MAX_PLAYERS_SAME_TEAM => Contest.MAX_PLAYERS_SAME_TEAM.toString();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "lineupselector", substitutions/*, {"MAX_PLAYERS_SAME_TEAM": MAX_PLAYERS_SAME_TEAM, "RESOURCE": resource}*/);
  }

  LineupFieldSelectorComp();

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(int slotIndex) => _POS_CLASS_NAMES[FieldPos.FIELD_POSITION_ABREV[lineupFormation[slotIndex]]];
  
  // Para pintar el color correspondiente segun la posicion del jugador
  String getLineupClassname() => "lineup-$_formationId";

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo + posicion del jugador
  String getSlotPosition(int slotIndex) => FieldPos.FIELD_POSITION_ABREV[lineupFormation[slotIndex]];
  String getSlotDescription(int slotIndex) => getLocalizedText("add") + FieldPos.FIELD_POSITION_FULL_NAMES[lineupFormation[slotIndex]];
  String getImgPerSlotPosition(int slotIndex) => "images/team-shirts/_${getSlotPosition(slotIndex)}.png";
  String getImgPerSoccerTeam(SoccerPlayerListItem slot) => "images/team-shirts/${slot.soccerTeam.shortName}.png";
    
  String getPrintableSalary(int salary) => StringUtils.parseSalary(salary);

  String getPrintableGoldCost(SoccerPlayerListItem slot) {
    Money money = slot.moneyToBuy;
    return money.amount <= 0 ? '' : '<span class="coins-amount">${money.toInt()}</span>';
  }

  String getPrintableFormation() {
    return (FORMATION_TO_STRING.containsKey(formationId)? FORMATION_TO_STRING[formationId] : FORMATION_TO_STRING[ContestEntry.FORMATION_442]);
  }


  Iterable<String> _formationListKeys = FORMATION_TO_STRING.keys;
  Iterable<String> get formationList => _formationListKeys;
  String formationToString(String key) => FORMATION_TO_STRING[key];

  static final Map<String, String> FORMATION_TO_STRING = {
    ContestEntry.FORMATION_442 : "4-4-2",
    ContestEntry.FORMATION_352 : "3-5-2",
    ContestEntry.FORMATION_433 : "4-3-3",
    ContestEntry.FORMATION_343 : "3-4-3",
    ContestEntry.FORMATION_451 : "4-5-1"
  };

  static final Map<String, String> _POS_CLASS_NAMES = {
    StringUtils.translate("gk", "soccerplayerpositions") : "posPOR",
    StringUtils.translate("def", "soccerplayerpositions"): "posDEF",
    StringUtils.translate("mid", "soccerplayerpositions"): "posMED",
    StringUtils.translate("for", "soccerplayerpositions"): "posDEL"
  };

  String _formationId;
}
