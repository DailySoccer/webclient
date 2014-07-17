library lobby_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';

@Controller(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)

class LobbyCtrl {

  LobbyCtrl(this._router) {
  }

  Router _router;
}
