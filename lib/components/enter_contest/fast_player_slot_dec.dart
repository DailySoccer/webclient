library fast_player_slot_dec;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart';


//
// Un decorador acompañamiento de la SoccerPlayerList para evitar bindings
//
@Decorator(selector: '[fast-player-slot]',
           map: const {'fast-player-slot': '=>!slot'})
class FastPlayerSlotDec {

  FastPlayerSlotDec(this._element, this._soccerPlayersList);

  void set slot(dynamic slot) {

    _slot = slot;

    String text =
    '''
      <div class="column-fieldpos">${slot["fieldPos"].abrevName}</div>
      <div class="column-primary-info">
        <span class="soccer-player-name">${_limitName(slot["fullName"], 19)}</span>
        <span class="match-event-name">${slot["matchEventName"]}</span>
      </div>
      <div class="column-dfp">${slot["fantasyPoints"]}</div>
      <div class="column-played">${slot["playedMatches"]}</div>
      <div class="column-salary">${slot["salary"]}€</div>
      <div class="column-add">
        <button type="button" class="btn">Añadir</button>
      </div>
    ''';

    _element.id = "soccerPlayer${slot["intId"]}";
    _element.classes.add(_POS_CLASS_NAMES[slot["fieldPos"].abrevName]);
    _element.setInnerHtml(text, validator: null, treeSanitizer: null);

    _element.onClick.listen(_onMouseClick);
  }

  void _onMouseClick(MouseEvent e) {
    if (e.target is ButtonElement) {
      _soccerPlayersList.onAdd(_slot);
    }
    else {
      _soccerPlayersList.onRow(_slot);
    }
  }

  String _limitName(String items, int limit) {
     int j = items.length;

     if (j > limit) {
       return items.substring(0, limit) + '…';
     }
     else {
       return items;
     }
  }

  Element _element;
  SoccerPlayersListComp _soccerPlayersList;
  dynamic _slot;

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
}