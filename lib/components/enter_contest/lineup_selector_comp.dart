library lineup_selector_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/money.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/enter_contest/lineup_selector_comp.html',
    useShadowDom: false
)
class LineupSelectorComp {

  @NgOneWay("not-enough-resources")
  bool alertNotEnoughResources;

  @NgOneWay("resource")
  String resource;

  @NgOneWay("has-negative-balance")
  bool alertNegativeBalance;

  @NgOneWay("has-max-players-same-team")
  bool alertMaxPlayersSameTeamExceed;

  @NgOneWay("manager-level")
  num managerLevel = 0;

  String get MAX_PLAYERS_SAME_TEAM => Contest.MAX_PLAYERS_SAME_TEAM.toString();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "lineupselector", {"MAX_PLAYERS_SAME_TEAM": MAX_PLAYERS_SAME_TEAM, "RESOURCE": resource});
  }

  EnterContestComp enterContestComp;

  LineupSelectorComp(this.enterContestComp);

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(int slotIndex) => _POS_CLASS_NAMES[FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]]];

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo + posicion del jugador
  String getSlotPosition(int slotIndex) => FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]];
  String getSlotDescription(int slotIndex) => getLocalizedText("add") + FieldPos.FIELD_POSITION_FULL_NAMES[FieldPos.LINEUP[slotIndex]];

  String getPrintableSalary(int salary) => StringUtils.parseSalary(salary);

  String getPrintableGoldCost(dynamic slot) {
    Money money = slot['instanceSoccerPlayer'].moneyToBuy(managerLevel);
    return money.amount <= 0 ? '' : '<span class="coins-amount">${money.toInt()}</span>';
  }

  static final Map<String, String> _POS_CLASS_NAMES = {
    StringUtils.translate("gk", "soccerplayerpositions") : "posPOR",
    StringUtils.translate("def", "soccerplayerpositions"): "posDEF",
    StringUtils.translate("mid", "soccerplayerpositions"): "posMED",
    StringUtils.translate("for", "soccerplayerpositions"): "posDEL"
  };
}
