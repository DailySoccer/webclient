library lineup_selector_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/components/enter_contest_comp.dart';
import 'package:angular/core/parser/parser.dart';


@Component(
    selector: 'lineup-selector',
    templateUrl: 'packages/webclient/components/lineup_selector_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class LineupSelectorComp {

  var slots = new List();

  @NgTwoWay("selectedLineupPos")
  var selectedLineupPos;

  LineupSelectorComp(this._scope, this._enterContest) {

    _enterContest.lineupSelector = this;

    FieldPos.LINEUP.forEach((pos) {
      // Creamos los slots iniciales
      slots.add({"fieldPos": FieldPos.FIELD_POSITION_ABREV[pos], "isEmpty":true});

      // Rellenamos color y texto de cada posicion
      slots.last["desc"] = "AÑADIR " + FieldPos.FIELD_POSITION_NAMES[pos];
    });
  }

  void setSoccerPlayerIntoSelectedLineupPos(var soccerPlayer) {
    int idx = slots.indexOf(selectedLineupPos);
    slots[idx] = soccerPlayer;
    slots[idx]["isEmpty"] = false; // Cuando tengamos datos de verdad, evitar esto
  }

  void onSlotClick(var slot) {

    if (!slot['isEmpty']) {
      slots[slots.indexOf(slot)]["isEmpty"] = true;
    }
    else {
      selectedLineupPos = slot;
      _enterContest.onLineupPosClick(slots.indexOf(slot), slot);
    }
  }

  Scope _scope;
  EnterContestComp _enterContest;
}
