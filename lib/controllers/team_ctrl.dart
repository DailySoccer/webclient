library team_controller;

import 'package:angular/angular.dart';

import '../services/contest_manager.dart';
import '../models/contest.dart';

@NgController(
    selector: '[team-ctrl]',
    publishAs: 'ctrl'
)
class TeamCtrl {
  Contest contest;
  
  ContestManager _contestManager;
  
  TeamCtrl( Scope scope, RouteProvider routeProvider, ContestManager _contestManager ) {
    print("create TeamCtrl");
    
    String contestId = routeProvider.parameters['contestId'];
    contest = _contestManager.get(contestId);
  }
}
