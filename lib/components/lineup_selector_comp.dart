library lineup_selector_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/models/field_pos.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/lineup_selector_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class LineupSelectorComp {

  EnterContestCtrl enterContestCtrl;

  LineupSelectorComp(this.enterContestCtrl);

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo
  String getSlotDescription(int slotIndex) => "AÑADIR " + FieldPos.FIELD_POSITION_FULL_NAMES[FieldPos.LINEUP[slotIndex]];
}
