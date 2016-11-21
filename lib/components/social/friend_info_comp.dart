library friend_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:math';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'friend-info',
  templateUrl: 'friend_info_comp.html'
)
class FriendInfoComp {
  
  int nameWidth = 105;
  User _fbUser = null;

  @Input('max-width')
  void set maxWidth(int theWidth) { nameWidth = theWidth; }
  
  @Input('user')
  void set fbUser(User theUser) { _fbUser = theUser; }
  User get fbUser => _fbUser;

  @Input('on-challenge')
  Function onChallenge;
  
  @Input('show-challenge')
  bool showChallenge = true;
  
  @Input('show-manager-level')
  bool showManagerLevel = true;
  
  @Input('id-error')
  bool idError = false;
  
  String get challengeText => StringUtils.translate("challenge", "facebook_service");
  String get profileImage => idError ? '' : _fbUser != null? _fbUser.profileImage : "";
  String get nickname => idError ? 'id desconocido' :_fbUser != null? _fbUser.nickName : "";
  String get managerLevel => idError ? '-' :_fbUser != null? "${_fbUser.managerLevel.toInt()}" : "-";
  
  FriendInfoComp();
}
