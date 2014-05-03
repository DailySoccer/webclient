library lobby_ctrl;

import 'package:angular/angular.dart';

import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';


@Controller(
    selector: '[lobby-ctrl]',
    publishAs: 'ctrl'
)
class LobbyCtrl {
  Iterable<Contest> contests;

  LobbyCtrl(this._router, this._contestService) {
    this._contestService.getAllContests()
        .then((values) {
            contests = values;
        });
  }

  EnterContest(Contest contest) {
    _router.go('team.create', { "contestId": contest.id });
  }

  Router _router;
  ContestService _contestService;
}
