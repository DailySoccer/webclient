library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/enter_contest_service.dart';


@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayersListComp {

  EnterContestService enterContestService;

  SoccerPlayersListComp(this.enterContestService);
}
