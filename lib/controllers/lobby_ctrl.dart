library list_contest_controller;

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
  
  LobbyCtrl(Scope scope, this._router, this._contestManager ) {
    print("create LoginCtrl");
    
    this._contestManager.all
      .then( (values) {
        contests = values;
      });
  }
  
  Enter( Contest contest ) {
    print("Lobby: Enter to Contest: ${contest.name}");
    _router.go('team.create', { "contestId": contest.id });
  }
}
