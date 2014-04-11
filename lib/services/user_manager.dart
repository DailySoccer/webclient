library user_manager;

import 'dart:async';
import 'package:angular/angular.dart';

import '../models/user.dart';

class UserManager {
  final ERR_YA_REGISTRADO   = "ya registrado";
  final ERR_NO_REGISTRADO   = "no registrado";
  final ERR_NO_LOGIN        = "no login";
  
  User currentUser = new User();

  var  _usersRegistered;
  
  bool get isRegistered => currentUser.isRegistered;
  bool get isLogin => currentUser.isLogin;

  Router _router;
  /*Http _http;*/
  
  UserManager( /*this._http*/ ) {
    // print("new UserManager");
    
    _usersRegistered = new Map<String, User>();
  }

  Future register( User user ) {
    print("Register: ${user.registerInfo}");
    
    var completer = new Completer();
    
    if ( !existsUser(user.email) ) {
      currentUser
        ..isRegistered  = user.isRegistered = true
        ..isLogin       = user.isLogin = false
        ..fullName  = user.fullName
        ..email     = user.email
        ..nickName  = user.nickName
        ..password  = user.password;
      
      _insertUser( currentUser );
      
      completer.complete();
    }
    else {
      completer.completeError( ERR_YA_REGISTRADO );
    }
    
    return completer.future;
   }
  
  Future login( User user ) {
    print("Login: ${user.loginInfo}");
    
    var completer = new Completer();
    
    if ( existsUser(user.email) ) {
      User userRegistered = get(user.email);
      if ( _canLogin(userRegistered, user) ) {
        currentUser
          ..isRegistered  = user.isRegistered = true
          ..isLogin       = user.isLogin = true
          ..fullName  = user.fullName
          ..email     = user.email
          ..nickName  = user.nickName
          ..password  = user.password;
          
          completer.complete();
      }
      else {
        completer.completeError( ERR_NO_REGISTRADO );
      }
    }
    else {
      completer.completeError( ERR_NO_REGISTRADO );
    }
    
    return completer.future;
  }
    
  Future logout() {
    var completer = new Completer();
    
    if ( currentUser.isLogin ) {
      currentUser.isLogin = false;
      
      completer.complete();
    }
    else {
      completer.completeError( ERR_NO_LOGIN );
    }
    
    return completer.future;
  }

  bool existsUser( String email ) {
    return _usersRegistered.containsKey(email);
  }
  
  User get( String email ) {
    return _usersRegistered[ email ];
  }
  
  _insertUser( User user ) {
    _usersRegistered[ user.email ] = user;
  }
  
  bool _canLogin( User userA, User userB ) {
    return (userA.email == userB.email) && (userA.password == userB.password);
  }
  
}