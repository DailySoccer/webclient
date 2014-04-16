library user_manager;

import 'dart:async';
import 'package:angular/angular.dart';
import "package:json_object/json_object.dart";

import '../services/server_request.dart';
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
  ServerRequest _server;
  
  UserManager( this._server /*this._http*/ ) {
    // print("new UserManager");
    
    _usersRegistered = new Map<String, User>();
  }

  Future register( User user ) {
    print("Register: ${user.registerInfo}");
    currentUser.reset();
    
    Future register = _server.register(user.fullName, user.email, user.nickName, user.password)
      .then( (responseJson) {
        var response = new JsonObject.fromJsonString( responseJson );
        print( "response: $response" );
        if ( response.result == "ok" ) {
          currentUser
            ..fullName  = user.fullName
            ..email     = user.email
            ..nickName  = user.nickName
            ..password  = user.password
            ..isRegistered  = true
            ..isLogin       = false;
          
          _insertUser( currentUser );
        }
        else {
          // throw( ERR_YA_REGISTRADO );
          return new Future.error( ERR_YA_REGISTRADO );
        }
      });
    
    return register;
   }
  
  Future login( User user ) {
    print("Login: ${user.loginInfo}");
    currentUser.reset();
    
    var completer = new Completer();
    
    Future login = _server.login(user.email, user.password)
      .then( (responseJson) {
        var response = new JsonObject.fromJsonString( responseJson );
        print( "response: $response" );
        if ( response.result == "ok" ) {
          currentUser
            ..fullName  = response.data.fullName
            ..nickName  = response.data.nickName
            ..email     = user.email
            ..password  = user.password
            ..isRegistered  = user.isRegistered = true
            ..isLogin       = user.isLogin = true;
        }
        else {
          // throw( ERR_NO_REGISTRADO );
          return new Future.error( ERR_NO_REGISTRADO );
        }
      });
    
    return login;
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

  bool exists( String email ) {
    return _usersRegistered.containsKey(email);
  }
  
  User get( String email ) {
    return _usersRegistered[ email ];
  }
  
  _insertUser( User user ) {
    _usersRegistered[ user.email ] = user;
  }
  
}