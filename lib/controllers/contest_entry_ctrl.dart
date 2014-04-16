library contest_entry_ctrl;

import 'package:angular/angular.dart';

import '../services/contest_manager.dart';
import '../models/contest.dart';

@NgController(
    selector: '[contest-entry-ctrl]',
    publishAs: 'ctrl'
)
class ContestEntryCtrl {
  Contest contest;

  ContestManager _contestManager;

  ContestEntryCtrl( Scope scope, RouteProvider routeProvider, ContestManager _contestManager ) {
    String contestId = routeProvider.parameters['contestEntryId'];
    contest = _contestManager.get(contestId);
  }
}
