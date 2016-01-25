library friends_bar_comp;

import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'friends-bar',
  templateUrl: 'packages/webclient/components/social/friends_bar_comp.html',
  useShadowDom: false
)
class FriendsBarComp {
  
  int nameWidth = 105;
  List<User> _fbUsers = [];
  
  @NgOneWay('user-list')
  void set fbUsers(List<User> user) { 
    _fbUsers = user.sublist(0, min(user.length, 5));
  }
  List<User> get fbUsers => _fbUsers;

  @NgCallback('on-challenge')
  Function onChallenge;
  
  @NgOneWay('show-challenge')
  bool showChallenge = true;

  String get challengeText => StringUtils.translate("challenge", "facebook_service");
  
  FriendsBarComp();
  
}
