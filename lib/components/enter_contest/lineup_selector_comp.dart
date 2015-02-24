library lineup_selector_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/enter_contest/lineup_selector_comp.html',
    useShadowDom: false
)
class LineupSelectorComp {

  @NgOneWay("has-negative-balance")
  bool alertNegativeBalance;

  @NgOneWay("has-max-players-same-team")
  bool alertMaxPlayersSameTeamExceed;

  String get MAX_PLAYERS_SAME_TEAM => Contest.MAX_PLAYERS_SAME_TEAM.toString();

  EnterContestComp enterContestComp;

  LineupSelectorComp(this.enterContestComp);

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(int slotIndex) => _POS_CLASS_NAMES[FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]]];

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo + posicion del jugador
  String getSlotPosition(int slotIndex) => FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]];
  String getSlotDescription(int slotIndex) => "ADD " + FieldPos.FIELD_POSITION_FULL_NAMES[FieldPos.LINEUP[slotIndex]];

  String getPrintableSalary(int salary) => StringUtils.parseSalary(salary);

  static final Map<String, String> _POS_CLASS_NAMES = { "GK": "posPOR", "DEF": "posDEF", "MID": "posMED", "FWD": "posDEL" };
}
