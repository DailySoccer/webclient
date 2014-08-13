library user_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';

@Component(
   selector: 'users-list',
   templateUrl: 'packages/webclient/components/users_list_comp.html',
   publishAs: 'comp',
   useShadowDom: false
)

class UsersListComp {

  static const int LIVE_CONTEST = 0;

  List users = new List();


  @NgTwoWay("selected-contest-entry")
  ContestEntry selectedContestEntry = null;

  @NgOneWay("contest-entries")
  set contestEntries(List<ContestEntry> value) {
    _contestEntries = value;
    _refresh();
  }

  @NgOneWay("watch")
  set watch(dynamic value) {
    _refresh();
  }

  //
  @NgOneWay("mode")
  set mode(String value)
  {
    switch(value)
    {
      case "LIVE_CONTEST":
        _mode = LIVE_CONTEST;
      break;
      default:
        print("-USER_LIST-COMP: Se ha establecido un valor para el parametro 'mode' no valido.");
    }
  }
  int _mode;


  String getPrize(int index) => _viewContestCtrl.getPrize(index);

  UsersListComp(this._viewContestCtrl);

  void _refresh() {
    //print("refresh users: ${_liveContestCtrl.usersInfo}");

    users.clear();

    if (_contestEntries != null) {
      for (var contestEntry in _viewContestCtrl.contestEntriesOrderByPoints) {
        users.add({
          "id": contestEntry.user.userId,
          "contestEntry" : contestEntry,
          "name": contestEntry.user.fullName,
          "remainingTime": contestEntry.timeLeft,
          "score": contestEntry.currentLivePoints
        });
      }
    }
  }

  void onUserClick(var user) {
    switch(_mode)
    {
      case LIVE_CONTEST:
        _viewContestCtrl.setTabNameAndShowIt(user["name"]);
      break;
    }
    selectedContestEntry = user["contestEntry"];
  }

  List<ContestEntry> _contestEntries;
  ViewContestCtrl _viewContestCtrl;
}
