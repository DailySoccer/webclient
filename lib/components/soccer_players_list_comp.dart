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

  SoccerPlayersListComp() {

  }
}
