library enter_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/components/lineup_selector_comp.dart';
import 'package:webclient/components/soccer_players_list_comp.dart';


@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest_comp.html',
    publishAs: 'enterContest',
    useShadowDom: false
)
class EnterContestComp implements ShadowRootAware {

  Contest contest;
  bool isSelectingSoccerPlayer = false;

  LineupSelectorComp lineupSelector;
  SoccerPlayersListComp soccerPlayersList;

  EnterContestComp(RouteProvider routeProvider, this._contestService, this._scope) {
    contest = _contestService.getContestById(routeProvider.parameters['contestId']);
  }

  void onShadowRoot(var root) {
    var rootElement = root as HtmlElement;
  }

  void onLineupPositionClick(int slotIndex, var soccerPlayer) {
    isSelectingSoccerPlayer = true;
  }

  void onSoccerPlayerSelected() {
    isSelectingSoccerPlayer = false;
  }

  Scope _scope;
  ContestService _contestService;
}
