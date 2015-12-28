library friends_bar_comp;

import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';

@Component(
  selector: 'friends-bar',
  templateUrl: 'packages/webclient/components/social/friends_bar_comp.html',
  useShadowDom: false
)
class FriendsBarComp {
  

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
  
  String get pictureUrl => pro.user.profileImage;
  
  FriendsBarComp(this.pro);
  
  ProfileService pro;
}
