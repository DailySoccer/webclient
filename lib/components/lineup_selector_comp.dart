library lineup_selector_comp;

import 'dart:html';
import 'package:angular/angular.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/lineup_selector_comp.html',
    publishAs: 'lineupSelector',
    useShadowDom: false
)
class LineupSelectorComp {

  var slots = new List();

  LineupSelectorComp() {
    slots.add({"fieldPos":"POR", "isEmpty":true});
    slots.add({"fieldPos":"DEF", "isEmpty":true});
    slots.add({"fieldPos":"DEF", "isEmpty":true});
    slots.add({"fieldPos":"DEF", "isEmpty":true});
    slots.add({"fieldPos":"DEF", "isEmpty":true});
    slots.add({"fieldPos":"MED", "isEmpty":true});
    slots.add({"fieldPos":"MED", "isEmpty":true});
    slots.add({"fieldPos":"MED", "isEmpty":true});
    slots.add({"fieldPos":"MED", "isEmpty":true});
    slots.add({"fieldPos":"DEL", "isEmpty":true});
    slots.add({"fieldPos":"DEL", "isEmpty":true});

    // Rellenamos color y texto de cada posicion
    slots.forEach((slot) {
        slot["desc"] = "AÑADIR PORTERO";
    });
  }
}
