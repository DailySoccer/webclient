library contest_entry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/active_contests_service.dart';

@Component(
   selector: 'contest-entry',
   templateUrl: 'packages/webclient/components/contest_entry_comp.html',
   publishAs: 'contestEntry',
   useShadowDom: false
)

class ContestEntryComp {

  Contest contest;


  ContestEntryComp(RouteProvider routeProvider, this._contestService) {
      contest = _contestService.getContestById(routeProvider.route.parameters['contestId']);
  }

  ActiveContestsService _contestService;

}