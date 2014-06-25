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

  EnterContestComp(this._scope, this._contestService, RouteProvider routeProvider) {
    contest = _contestService.getContestById(routeProvider.parameters['contestId']);

    _scope.on("onLineupPositionClick").listen(onLineupPositionClick);
    _scope.on("onSoccerPlayerSelected").listen(onSoccerPlayerSelected);
  }

  void onShadowRoot(var root) {
    var rootElement = root as HtmlElement;
  }

  void onLineupPositionClick(ScopeEvent scopeEvent) {
    isSelectingSoccerPlayer = true;
  }

  void onSoccerPlayerSelected(ScopeEvent scopeEvent) {
    isSelectingSoccerPlayer = false;
  }

  Scope _scope;
  ContestService _contestService;
}
