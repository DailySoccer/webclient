library user_manager;

import 'dart:async';
import 'package:angular/angular.dart';

import '../models/user.dart';

class UserManager {
  User currentUser = new User();
  
  bool get isRegistered => currentUser.isRegistered;
  bool get isLogin => currentUser.isLogin;

  Router _router;
  /*Http _http;*/
  
  UserManager( /*this._http*/ ) {
    print("new UserManager");
  }

  Future register( User user ) {
    print("Register: ${user.fullName} - ${user.email} - ${user.nickName} - ${user.password}");
    
    var completer = new Completer();
    
    currentUser
      ..isRegistered  = user.isRegistered = true
      ..isLogin       = user.isLogin = true
      ..fullName  = user.fullName
      ..email     = user.email
      ..nickName  = user.nickName
      ..password  = user.password;
    
    completer.complete();
    return completer.future;
   }
  
  Future login( User user ) {
    print("Login: ${user.email} - ${user.password}");
    
    var completer = new Completer();
    
    currentUser
      ..isLogin   = user.isLogin = true
      ..email     = user.email
      ..password  = user.password;
    
    completer.complete();
    return completer.future;
  }
    
  Future logout() {
    var completer = new Completer();
    
    currentUser.isLogin = false;
    
    completer.complete();
    return completer.future;
  }
}