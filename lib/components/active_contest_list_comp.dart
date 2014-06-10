library active_contest_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';


@Component(
    selector: 'active-contest-list',
    templateUrl: 'packages/webclient/components/active_contest_list_comp.html',
    publishAs: 'activeContestList',
    useShadowDom: false
)
class ActiveContestList {

  ContestService contestService;

  ActiveContestList(this._router, this.contestService) {
    this.contestService.refreshActiveContests();
  }

  void enterContest(Contest contest) {
    _router.go('enter_contest', { "contestId": contest.contestId });
  }

   Router _router;
}