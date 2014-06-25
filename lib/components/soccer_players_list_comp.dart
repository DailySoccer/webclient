library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';


@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'soccerPlayersList',
    useShadowDom: false
)
class SoccerPlayersListComp {

  var slots = new List();

  SoccerPlayersListComp(this._scope) {
    slots.add({"fieldPos":"POR", "fullName":"IKER CASILLAS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"DEF", "fullName":"DIEGO LOPEZ", "matchEventName": "RMD - VAL", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"DEF", "fullName":"JESUS HERNANDEZ", "matchEventName": "RMD - ROS", "remainingMatchTime": "EMPIEZA 19:00"});
    slots.add({"fieldPos":"DEF", "fullName":"RAPHAEL VARANE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"DEF", "fullName":"PEPE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"MED", "fullName":"SERGIO RAMOS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"MED", "fullName":"NACHO FERNANDEZ", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 19:00"});
    slots.add({"fieldPos":"MED", "fullName":"FABIO COENTRAO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"MED", "fullName":"MARCELO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"DEL", "fullName":"ALVARO ARBELOA", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    slots.add({"fieldPos":"DEL", "fullName":"DANIEL CARVAJAL", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 9:00"});
  }

  void onAddButton(var slot) {
    _scope.emit("onSoccerPlayerSelected", {"soccerPlayer": slot});
  }

  Scope _scope;
}
