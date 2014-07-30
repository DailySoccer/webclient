library user_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';

@Component(
    selector: 'users-list',
    templateUrl: 'packages/webclient/components/users_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class UsersListComp {

  List users = new List();

  @NgTwoWay("selectedContestEntry")
  ContestEntry selectedContestEntry= null;

  @NgOneWay("contestEntries")
  set contestEntries(List<ContestEntry> value) {
    _contestEntries = value;
    _refresh();
  }

  @NgOneWay("watch")
  set watch(dynamic value) {
    _refresh();
  }

  String getPrize(int index) => _liveContestCtrl.getPrize(index);

  UsersListComp(this._scope, this._liveContestCtrl);

  void _refresh() {
    //print("refresh users: ${_liveContestCtrl.usersInfo}");

    users.clear();

    if (_contestEntries != null) {
      for (var contestEntry in _liveContestCtrl.contestEntriesOrderByPoints) {
        users.add({
          "id": contestEntry.user.userId,
          "contestEntry" : contestEntry,
          "name": contestEntry.user.fullName,
          "remainingTime": _liveContestCtrl.getUserRemainingTime(contestEntry),
          "score": contestEntry.currentLivePoints
        });
      }
    }
  }

  void onUserClick(var user) {
    selectedContestEntry = user["contestEntry"];
  }

  Scope _scope;
  List<ContestEntry> _contestEntries;
  LiveContestCtrl _liveContestCtrl;
}
