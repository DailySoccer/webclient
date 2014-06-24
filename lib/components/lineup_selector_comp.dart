library lineup_selector_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/lineup_selector_comp.html',
    publishAs: 'lineupSelector',
    useShadowDom: false
)
class LineupSelectorComp {

  var slots = new List();

  LineupSelectorComp() {
    // Creamos los slots iniciales
    FieldPos.LINEUP.forEach((pos) {
      slots.add({"fieldPos": FieldPos.FIELD_POSITION_ABREV[pos], "isEmpty":true});

      // Rellenamos color y texto de cada posicion
      slots.last["desc"] = "AÑADIR " + FieldPos.FIELD_POSITION_NAMES[pos];
    });
  }
}
