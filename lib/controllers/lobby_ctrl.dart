library lobby_ctrl;

import 'package:angular/angular.dart';

import '../services/contest_service.dart';
import '../models/contest.dart';


@NgController(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {
  Iterable<Contest> contests;


  LobbyCtrl(Scope scope, this._router, this._contestService) {
    contests = this._contestService.getAllContests();
  }


  EnterContest(Contest contest) {
    _router.go('team.create', { "contestId": contest.id });
  }


  Router _router;
  ContestService _contestService;
}
