library lineup_selector_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'lineup_selector_comp.html'
)
class LineupSelectorComp {

  @Input("not-enough-resources")
  bool alertNotEnoughResources;

  @Input("resource")
  String resource;

  @Input("has-negative-balance")
  bool alertNegativeBalance;

  @Input("has-max-players-same-team")
  bool alertMaxPlayersSameTeamExceed;

  @Input("manager-level")
  num managerLevel = 0;

  @Input("contest")
  Contest contest;

  List<SoccerPlayerListItem> _lineupSlots = [];

  @Input("lineup-slots")
  void set lineupSlots(List<SoccerPlayerListItem> slots) {
    _lineupSlots = slots;
  }
  List<SoccerPlayerListItem> get lineupSlots => _lineupSlots;

  @Input("lineup-formation")
  List<String> lineupFormation = FieldPos.FORMATIONS[ContestEntry.FORMATION_442];

  @Input("on-lineup-slot-selected")
  Function onLineupSlotSelected;

  @Input("formation-id")
  String get formationId => _formationId;

  @Output("formation-id")
  void set formationId(String value) {
    _formationId = value;
  }

  String get MAX_PLAYERS_SAME_TEAM => Contest.MAX_PLAYERS_SAME_TEAM.toString();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "lineupselector", {"MAX_PLAYERS_SAME_TEAM": MAX_PLAYERS_SAME_TEAM, "RESOURCE": resource});
  }

  LineupSelectorComp();

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(int slotIndex) => _POS_CLASS_NAMES[FieldPos.FIELD_POSITION_ABREV[lineupFormation[slotIndex]]];

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(SoccerPlayerListItem slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo + posicion del jugador
  String getSlotPosition(int slotIndex) => FieldPos.FIELD_POSITION_ABREV[lineupFormation[slotIndex]];
  String getSlotDescription(int slotIndex) => getLocalizedText("add") + FieldPos.FIELD_POSITION_FULL_NAMES[lineupFormation[slotIndex]];

  String getPrintableSalary(int salary) => StringUtils.parseSalary(salary);

  String getPrintableGoldCost(SoccerPlayerListItem slot) {
    Money money = slot.moneyToBuy;
    return money.amount <= 0 ? '' : '<span class="coins-amount">${money.toInt()}</span>';
  }

  String getPrintableFormation() {
    return getLocalizedText('formation') + " " + (FORMATION_TO_STRING.containsKey(formationId)? FORMATION_TO_STRING[formationId] : '');
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
