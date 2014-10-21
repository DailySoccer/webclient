library user_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
   selector: 'users-list',
   templateUrl: '/packages/webclient/components/view_contest/users_list_comp.html',
   useShadowDom: false
)
class UsersListComp {

  List users = new List();

  @NgOneWay("contest-entries")
  set contestEntries(List<ContestEntry> value) {
    _contestEntries = value;
    _refresh();
  }

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgOneWay("watch")
  set watch(dynamic value) {
    _refresh();
  }

  bool get isViewContestEntryMode => _routeProvider.route.name.contains("view_contest_entry");
  bool isMainPlayer(var user) => _profileService.user.userId == user["id"];

  String getPrize(int index) => (_contest != null) ? _contest.getPrize(index) : "";

  UsersListComp(this._routeProvider, this._profileService);

  void _refresh() {

    users.clear();

    if (_contestEntries != null) {
      _contest = _contestEntries.first.contest;

      for (var contestEntry in _contest.contestEntriesOrderByPoints) {
        users.add({
          "id": contestEntry.user.userId,
          "contestEntry" : contestEntry,
          "name": contestEntry.user.nickName,
          "remainingTime": "${contestEntry.percentLeft}%",
          "score": contestEntry.currentLivePoints
        });
      }
    }
  }

  void onUserClick(var user) {
    if (onRowClick != null) {
      onRowClick({"contestEntry":user["contestEntry"]});
    }
  }

  Contest _contest;
  List<ContestEntry> _contestEntries;
  RouteProvider _routeProvider;
  ProfileService _profileService;
}
