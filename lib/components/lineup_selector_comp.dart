library lineup_selector_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/components/enter_contest_comp.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/lineup_selector_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class LineupSelectorComp {

  var slots = new List();

  LineupSelectorComp(this._scope, this._enterContest) {

    FieldPos.LINEUP.forEach((pos) {
      // Creamos los slots iniciales
      slots.add({"fieldPos": FieldPos.FIELD_POSITION_ABREV[pos], "isEmpty":true});

      // Rellenamos color y texto de cada posicion
      slots.last["desc"] = "AÑADIR " + FieldPos.FIELD_POSITION_NAMES[pos];
    });

    _enterContest.lineupSelector = this;
  }

  void onSlotClick(var slot) {
    _enterContest.onLineupPositionClick(slots.indexOf(slot), slot);
  }

  Scope _scope;
  EnterContestComp _enterContest;
}
