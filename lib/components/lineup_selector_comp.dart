library lineup_selector_comp;

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

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(int slotIndex){
    // Listas de las clases y posiciones
    List<String> classList = ['posPOR', 'posDEF', 'posMED', 'posDEL'];
    List<String> posList = ['POR', 'DEF', 'MED', 'DEL'];
    // Mapeamos clase segun posicion
    Map<String, String> classMap = new Map.fromIterables(posList, classList);

    String pos = FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]];
    return classMap[pos];
  }

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  // Cuando el slot esta libre, ponemos un texto alternativo + posicion del jugador
  String getSlotPosition(int slotIndex) => FieldPos.FIELD_POSITION_ABREV[FieldPos.LINEUP[slotIndex]];
  String getSlotDescription(int slotIndex) => "AÑADIR " + FieldPos.FIELD_POSITION_FULL_NAMES[FieldPos.LINEUP[slotIndex]];
}
