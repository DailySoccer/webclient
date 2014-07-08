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

  String getPrize(int index) => _liveContestCtrl.getPrize(index);
  
  UsersListComp(this._scope, this._liveContestCtrl) {
    _scope.watch("contestEntries", (newValue, oldValue) {
      refresh(); 
    }, context: _liveContestCtrl, collection: true);
  }

  void refresh() {
    //print("refresh users: ${_liveContestCtrl.usersInfo}");
    
    users.clear();
    for (var contestEntry in _liveContestCtrl.contestEntries) {
      users.add({
        "id": contestEntry.userId,
        "contestEntryId" : contestEntry.contestEntryId,
        "name": _liveContestCtrl.getUserName(contestEntry),
        "remainingTime": _liveContestCtrl.getUserRemainingTime(contestEntry),
        "score": _liveContestCtrl.getUserScore(contestEntry)
      });
    }
  }
  
  void onUserClick(var user) {
    selectedUser = user["id"];
  }
  
  Scope _scope;
  LiveContestCtrl _liveContestCtrl;
}
