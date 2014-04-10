library user_manager;

import 'dart:async';
import 'package:angular/angular.dart';

import '../models/user.dart';

class UserManager {
  User currentUser = new User();
  
  bool get isLogin => currentUser.isLogin;

  Router _router;
  Http _http;
  
  UserManager( this._http ) {
    print("new UserManager");
  }

  Future register( User user ) {
    print("Register: ${user.fullName} - ${user.email} - ${user.nickName} - ${user.password}");
    
    var completer = new Completer();
    
    currentUser.isRegistered  = true;
    currentUser.isLogin       = true;
    
    currentUser.fullName  = user.fullName;
    currentUser.email     = user.email;
    currentUser.nickName  = user.nickName;
    currentUser.password  = user.password;
    
    completer.complete();
    return completer.future;
   }
  
  Future login( User user ) {
    print("Login: ${user.email} - ${user.password}");
    
    var completer = new Completer();
    
    currentUser.isLogin = true;
    
    currentUser.email     = user.email;
    currentUser.password  = user.password;
    
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