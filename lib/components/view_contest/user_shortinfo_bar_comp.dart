library user_shortinfo_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'user-shortinfo-bar',
   templateUrl: 'packages/webclient/components/view_contest/user_shortinfo_bar_comp.html',
   useShadowDom: false
)
class UserShortinfoBarComp {
  

  @NgOneWay("user")
  ContestEntry player;
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "userlist");
  }

  UserShortinfoBarComp(this._routeProvider, this._profileService);

  Contest _contest;
  List<ContestEntry> _contestEntries;
  RouteProvider _routeProvider;
  ProfileService _profileService;
}
