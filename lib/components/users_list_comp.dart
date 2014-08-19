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

  @NgOneWay("mode")
  set mode(String value)
  {
    _mode = value;
  }

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
      case "live_contest":
        _viewContestCtrl.setTabNameAndShowIt(user["name"]);
      break;
      case "history_contest":
        //_viewContestCtrl.setTabNameAndShowIt(user["name"]);
        //TODO: Aqui cuando me hacen click, despliego la lista de acciones que hizo el jugador en el partido.
      break;
    }
    selectedContestEntry = user["contestEntry"];
  }

  List<ContestEntry> _contestEntries;
  ViewContestCtrl _viewContestCtrl;
  String _mode;
}
