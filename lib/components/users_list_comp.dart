library user_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
   selector: 'users-list',
   templateUrl: 'packages/webclient/components/users_list_comp.html',
   publishAs: 'comp',
   useShadowDom: false
)

class UsersListComp {

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

  String getPrize(int index) => _viewContestCtrl.getPrize(index);

  UsersListComp(this._routeProvider, this._viewContestCtrl, this._profileService);

  void _refresh() {
    //print("refresh users: ${_liveContestCtrl.usersInfo}");

    users.clear();

    if (_contestEntries != null) {
      for (var contestEntry in _viewContestCtrl.contestEntriesOrderByPoints) {
        users.add({
          "id": contestEntry.user.userId,
          "contestEntry" : contestEntry,
          "name": contestEntry.user.nickName,
          "remainingTime": "${contestEntry.timeLeft} min.",
          "score": contestEntry.currentLivePoints
        });
      }
    }
  }

  bool isMainPlayer(var user) => _profileService.user.userId == user["id"];

  void onUserClick(var user) {
    switch(_routeProvider.route.name)
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
  RouteProvider _routeProvider;
  ProfileService _profileService;
}
