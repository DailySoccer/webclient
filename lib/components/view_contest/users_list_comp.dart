library user_list_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'users-list',
   templateUrl: 'users_list_comp.html'
)
class UsersListComp {
  
  int nameWidth = 105;

  List users = new List();

  @Input("contest-entries")
  set contestEntries(List<ContestEntry> value) {
    _contestEntries = value;
    _refresh();
  }

  @Input("on-row-click")
  Function onRowClick;

  @Input("watch")
  set watch(dynamic value) {
    _refresh();
  }

  bool get isViewContestEntryMode => _routeParams.get("view_contest_entry") != null;
  bool isMainPlayer(var user) => _profileService.isLoggedIn && (_profileService.user.userId == user["id"]);

  String getPrize(int index) => (_contest != null) ? _contest.getPrize(index) : "";

  String getLocalizedText(key) {
    return StringUtils.translate(key, "userlist");
  }

  UsersListComp(this._routeParams, this._profileService);

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
          "score": StringUtils.parseFantasyPoints(contestEntry.currentLivePoints)
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
  RouteParams _routeParams;
  ProfileService _profileService;
}
