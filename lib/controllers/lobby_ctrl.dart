library lobby_ctrl;

import 'package:angular/angular.dart';


@Controller(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {

  LobbyCtrl(this._router);

  Router _router;
}
