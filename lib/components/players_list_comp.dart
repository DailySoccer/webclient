library player_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';


@Component(
    selector: 'players-list',
    templateUrl: 'packages/webclient/components/players_list_comp.html',
    publishAs: 'playersList',
    useShadowDom: false
)
class PlayerListComp {

  var players = new List();

  var selectedPlayer = null;

  PlayerListComp() {

    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"1800'", "score":"150.00", "prize":"€100,00"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"120'", "score":"120.00", "prize":"€50,00"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"100.00", "prize":"€30,00"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"90.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"63.21", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"50.02", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"24.23", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"23.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"14.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"12.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"10.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"9.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"8.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"0.00", "prize":"-"});
    players.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"0.00", "prize":"-"});
  }


}
