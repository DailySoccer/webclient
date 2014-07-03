library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayersListComp {

  EnterContestCtrl enterContestCtrl;

  SoccerPlayersListComp(this.enterContestCtrl);
}
