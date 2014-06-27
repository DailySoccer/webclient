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
  List<String> slotDescriptions = new List<String>();


  LineupSelectorComp(this._scope, this._enterContest) {

    _enterContest.lineupSelector = this;

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      slots.add(null);
      slotDescriptions.add("AÑADIR " + FieldPos.FIELD_POSITION_FULL_NAMES[pos]);
    });
  }

  // Por si queremos cambiar lo que significa un slot libre
  bool isEmptySlot(var slot) => slot == null;

  void setSoccerPlayerIntoSelectedLineupPos(var soccerPlayer) {
    slots[_selectedLineupPosIndex] = soccerPlayer;
  }

  void onSlotClick(int slotIndex) {
    _selectedLineupPosIndex = slotIndex;

    if (slots[slotIndex] != null)
      slots[slotIndex] = null;
    else
      _enterContest.onLineupPosClick(new FieldPos(FieldPos.LINEUP[slotIndex]));
  }

  Scope _scope;
  EnterContestComp _enterContest;
  int _selectedLineupPosIndex = 0;
}
