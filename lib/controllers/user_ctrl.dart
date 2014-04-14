library user_controller;

import 'package:angular/angular.dart';

import '../services/user_manager.dart';
import '../services/match_manager.dart';
import '../services/group_manager.dart';
import '../services/contest_manager.dart';

@NgController(
    selector: '[user-ctrl]',
    publishAs: 'user'
)
class UserCtrl {
  bool isLogin = false;
  String fullName = "";
  String nickName = "";
  
  UserManager _userManager;
  MatchManager _matchManager;
  GroupManager _groupManager;
  ContestManager _contestManager;
  
  UserCtrl(Scope scope, this._userManager, this._matchManager, this._contestManager) {
    print("create UserCtrl");
    
    isLogin  = _userManager.isLogin;
    
    scope.watch( "isLogin", (value, _) {
      isLogin = value;
      
      if ( isLogin ) {
        fullName = _userManager.currentUser.fullName;
        nickName = _userManager.currentUser.nickName;
      }
      print("isLogin: $isLogin");
    }, context: _userManager );
  }
  
  void logOut() {
    _userManager.logout();
  }
}