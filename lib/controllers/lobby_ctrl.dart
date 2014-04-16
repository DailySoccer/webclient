library lobby_ctrl;

import 'package:angular/angular.dart';

import '../services/contest_manager.dart';
import '../models/contest.dart';

@NgController(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {
  List<Contest> contests;

  Router _router;
  ContestManager _contestManager;

  LobbyCtrl(Scope scope, this._router, this._contestManager) {
    contests = this._contestManager.all();
  }

  Enter(Contest contest) {
    print("Lobby: Enter to Contest: ${contest.name}");
    _router.go('team.create', { "contestId": contest.id });
  }
}
