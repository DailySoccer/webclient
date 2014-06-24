library enter_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/contest_service.dart';


@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest_comp.html',
    publishAs: 'enterContest',
    useShadowDom: false
)
class EnterContestComp {

  var slots = new List();

  Contest contest;

  EnterContestComp(Scope scope, RouteProvider routeProvider, this._contestService) {
    contest = _contestService.getContestById(routeProvider.parameters['contestId']);

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

  ContestService _contestService;
}
