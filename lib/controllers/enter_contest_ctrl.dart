library enter_contest_ctrl;

import 'package:angular/angular.dart';

import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';


@Controller(
    selector: '[enter-contest-ctrl]',
    publishAs: 'ctrl'
)
class EnterContestCtrl {
  Contest contest;

  EnterContestCtrl(Scope scope, RouteProvider routeProvider, ContestService _contestService) {
    contest = _contestService.getContestById(routeProvider.parameters['contestEntryId']);
  }

  ContestService _contestService;
}
