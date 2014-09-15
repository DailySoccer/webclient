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

  @NgOneWay("parent")
   set parent(ViewContestCtrl value) {
     _viewContestCtrl = value;
   }

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

  String getPrize(int index) => (_viewContestCtrl != null) ? _viewContestCtrl.getPrize(index) : "";

  bool get isViewContestEntryMode => (_routeProvider.route.name == "view_contest_entry") || (_routeProvider.route.name == "edit_contest_entry");

  UsersListComp(this._routeProvider, this._profileService);

  void _refresh() {
    //print("refresh users: ${_liveContestCtrl.usersInfo}");

    users.clear();

    if (_contestEntries != null) {
      if (_viewContestCtrl != null) {
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
      else {
        for (var contestEntry in _contestEntries) {
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
  }

  bool isMainPlayer(var user) => _profileService.user.userId == user["id"];

  void onUserClick(var user) {
    switch(_routeProvider.route.name)
    {
      case "live_contest":
        _viewContestCtrl.setTabNameAndShowIt(user["name"]);
        selectedContestEntry = user["contestEntry"];
      break;
      case "history_contest":
        _viewContestCtrl.setTabNameAndShowIt(user["name"]);
        selectedContestEntry = user["contestEntry"];
      break;
    }
  }

  List<ContestEntry> _contestEntries;
  ViewContestCtrl _viewContestCtrl;
  RouteProvider _routeProvider;
  ProfileService _profileService;
}
