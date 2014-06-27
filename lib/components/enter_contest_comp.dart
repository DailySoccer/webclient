library enter_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/components/lineup_selector_comp.dart';
import 'package:webclient/components/soccer_players_list_comp.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class EnterContestComp {

  Contest contest;
  bool isSelectingSoccerPlayer = false;

  // Intentando hacer la comunicacion a traves de bindings de atributos, falla dart2js. Requiere investigar por que.
  // De momento vamos a hacer un acoplamiento directo.
  // http://stackoverflow.com/questions/24397753/how-to-avoid-dart2js-discarding-my-angulardart-callback
  LineupSelectorComp lineupSelector;
  SoccerPlayersListComp soccerPlayersList;

  ScreenDetectorService scrDet;


  EnterContestComp(this._scope, this._contestService, this.scrDet, RouteProvider routeProvider) {
    contest = _contestService.getContestById(routeProvider.parameters['contestId']);
  }

  void onLineupPosClick(FieldPos fieldPos) {
    isSelectingSoccerPlayer = true;
    soccerPlayersList.setFieldPosFilter(fieldPos);
  }

  void onSoccerPlayerSelected(var soccerPlayer) {
    isSelectingSoccerPlayer = false;
    lineupSelector.setSoccerPlayerIntoSelectedLineupPos(soccerPlayer);
    soccerPlayersList.setFieldPosFilter(null);
  }

  Scope _scope;
  ContestService _contestService;
}
