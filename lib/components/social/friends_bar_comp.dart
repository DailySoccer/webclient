library friends_bar_comp;

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
  
  @NgOneWay('user-list')
  List<User> fbUsers = [];
  
  
  
  String get pictureUrl => pro.user.profileImage;
  
  FriendsBarComp(this.pro);
  
  
  ProfileService pro;
}
