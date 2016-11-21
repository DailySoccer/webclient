library friends_bar_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:math';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'friends-bar',
  templateUrl: 'friends_bar_comp.html'
)
class FriendsBarComp {
  
  int nameWidth = 105;
  List<User> _fbUsers = [];
  
  @Input('user-list')
  void set fbUsers(List<User> user) { 
    _fbUsers = user.sublist(0, min(user.length, 5));
  }
  List<User> get fbUsers => _fbUsers;

  @Input('on-challenge')
  Function onChallenge;
  
  @Input('show-challenge')
  bool showChallenge = true;

  String get challengeText => StringUtils.translate("challenge", "facebook_service");
  
  FriendsBarComp();
  
}
