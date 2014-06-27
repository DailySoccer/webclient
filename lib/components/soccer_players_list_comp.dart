library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest_comp.dart';
import 'package:webclient/models/field_pos.dart';


@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayersListComp {

  var slots = new List();

  SoccerPlayersListComp(this._scope, this._enterContest) {

    _enterContest.soccerPlayersList = this;

    _allSoccerPlayers.add({"fieldPos":new FieldPos("GOALKEEPER"), "fullName":"IKER CASILLAS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"DIEGO LOPEZ", "matchEventName": "RMD - VAL", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"JESUS HERNANDEZ", "matchEventName": "RMD - ROS", "remainingMatchTime": "EMPIEZA 19:00"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"RAPHAEL VARANE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"PEPE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"SERGIO RAMOS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"NACHO FERNANDEZ", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 19:00"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"FABIO COENTRAO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"MARCELO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("FORWARD"), "fullName":"ALVARO ARBELOA", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("FORWARD"), "fullName":"DANIEL CARVAJAL", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 9:00"});

    slots = _allSoccerPlayers;
  }

  void onAddButton(var slot) {
    _enterContest.onSoccerPlayerSelected(slot);
  }

  void setFieldPosFilter(FieldPos filter) {
    if (filter != null)
      slots = _allSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"] == filter).toList();
    else
      slots = _allSoccerPlayers;
  }

  Scope _scope;
  EnterContestComp _enterContest;
  var _allSoccerPlayers = new List();
}
