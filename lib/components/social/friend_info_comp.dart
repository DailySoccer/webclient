library friend_info_comp;

import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'friend-info',
  templateUrl: 'packages/webclient/components/social/friend_info_comp.html',
  useShadowDom: false
)
class FriendInfoComp {
  
  int nameWidth = 105;
  User _fbUser = null;

  @NgOneWay('max-width')
  void set maxWidth(int theWidth) { nameWidth = theWidth; }
  
  @NgOneWay('user')
  void set fbUser(User theUser) { _fbUser = theUser; }
  User get fbUser => _fbUser;

  @NgCallback('on-challenge')
  Function onChallenge;
  
  @NgOneWay('show-challenge')
  bool showChallenge = true;
  
  @NgOneWay('show-manager-level')
  bool showManagerLevel = true;
  
  String get challengeText => StringUtils.translate("challenge", "facebook_service");
  String get profileImage => _fbUser != null? _fbUser.profileImage : "";
  String get nickname => _fbUser != null? _fbUser.nickName : "";
  String get managerLevel => _fbUser != null? "${_fbUser.managerLevel.toInt()}" : "-";
  
  FriendInfoComp();
}
