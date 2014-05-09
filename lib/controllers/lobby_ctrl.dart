library lobby_ctrl;

import 'package:angular/angular.dart';

import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';


@Controller(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {

  ContestService contestService;

  LobbyCtrl(this._router, this.contestService) {
    this.contestService.refreshActiveContests();
  }

  void enterContest(Contest contest) {
    _router.go('team.create', { "contestId": contest.contestId });
  }

  Router _router;
}
