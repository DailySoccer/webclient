library lobby_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';


@Controller(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {

  LobbyCtrl(this._router) {
    // Timer.run(() => _router.go("enter_contest", {'contestId': '539fbfdb300456034ddd85a5'}));
  }

  Router _router;
}
