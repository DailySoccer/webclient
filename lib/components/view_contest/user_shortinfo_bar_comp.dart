library user_shortinfo_bar_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'user-shortinfo-bar',
   templateUrl: 'user_shortinfo_bar_comp.html'
)
class UserShortinfoBarComp {
  

  @Input("user")
  ContestEntry player;
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "userlist");
  }

  String get clasification =>  (player != null) ? player.contest.getUserPosition(player).toString() : "-";
  String get name =>  (player != null) ? player.user.nickName : " ";
  String get points =>     (player != null) ? StringUtils.parseFantasyPoints(player.currentLivePoints) : "0";
  String get percentLeft => (player != null) ? "${player.percentLeft}%" : "-";

  UserShortinfoBarComp();
}
