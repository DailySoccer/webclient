library user_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';
import 'package:webclient/models/contest_entry.dart';

@Component(
    selector: 'users-list',
    templateUrl: 'packages/webclient/components/users_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class UsersListComp {

  List users = new List();

  
  @NgTwoWay("selectedUser")
  var selectedUser = null;

  UsersListComp(this._scope, this._liveContestCtrl) {
    _scope.watch("contestEntries", (newValue, oldValue) {
      refresh(); 
    }, context: _liveContestCtrl, collection: true);
  }

  void refresh() {
    users.clear();
    for (var contestEntry in _liveContestCtrl.contestEntries) {
      users.add({
        "id": contestEntry.userId,
        "contestEntryId" : contestEntry.contestEntryId,
        "name": getUserName(contestEntry), 
        "remainingTime": getUserRemainingTime(contestEntry),
        "score": getUserScore(contestEntry)
      });
    }
  }
  
  String getUserName(ContestEntry contestEntry) {
    return contestEntry.userId;
  }
  
  String getUserRemainingTime(ContestEntry contestEntry) {
    return "1";
  }
  
  String getUserScore(ContestEntry contestEntry) {
    return "0";
  }
  
  String getPrize(int index) {
    String prize = "-";
    switch(index) {
      case 0: prize = "€100,00"; break;
      case 1: prize = "€50,00"; break;
      case 2: prize = "€30,00"; break;
    }
    return prize;
  }

  void onUserClick(var user) {
    selectedUser = user["id"];
  }
  
  Scope _scope;
  LiveContestCtrl _liveContestCtrl;
}
