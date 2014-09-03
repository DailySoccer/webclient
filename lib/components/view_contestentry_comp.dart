library view_contestentry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/active_contests_service.dart';

@Component(
   selector: 'view-contestentry',
   templateUrl: 'packages/webclient/components/view_contestentry_comp.html',
   publishAs: 'viewContestentry',
   useShadowDom: false
)

class ViewContestentryComp {

  Contest contest;


  ViewContestentryComp(RouteProvider routeProvider, this._contestService) {
      contest = _contestService.getContestById(routeProvider.route.parameters['contestId']);
  }

  ActiveContestsService _contestService;

}