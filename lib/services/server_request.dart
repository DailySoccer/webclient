library server_request;

import 'dart:async';

import 'package:angular/angular.dart';

import '../webclient.dart';

abstract class ServerRequest {
  Future<String> register   ( String fullName, String email, String nickName, String password );
  Future<String> login      ( String email, String password );
  Future<String> matchAll   ();
  Future<String> groupAll   ();
  Future<String> contestAll ();
}

class DailySoccerServer implements ServerRequest {

  Http _http;
  
  DailySoccerServer( this._http );
  
  Future<String> register( String fullName, String email, String nickName, String password ) {
    print("Http: Register: $fullName - $email - $nickName - $password");
    
    var dataUrl = "$HostServer/signup";
    var data = {'fullName': fullName, 'email': email, 'nickName': nickName, 'password': password};
    
    return _http.post( dataUrl, null, params: data )
      .then( (HttpResponse responseRequest) {
        return new Future.value( responseRequest.data );
      });
   }
  
  Future<String> login( String email, String password ) {
    print("Http: Login: $email - $password");
    
    var dataUrl = "$HostServer/login";
    var data = {'email': email, 'password': password};
    
    return _http.post( dataUrl, null, params: data )
      .then( (HttpResponse responseRequest) {
        return new Future.value( responseRequest.data );
      });
  }

  Future<String> matchAll() {
    print("Http: matchAll");
    
    var dataUrl = "$HostServer/match_all";
    
    return _http.get( dataUrl )
      .then( (HttpResponse responseRequest) {
        return new Future.value( responseRequest.data );
      });
  }

  Future<String> groupAll() {
    print("Http: groupAll");
    
    var dataUrl = "$HostServer/group_all";
    
    return _http.get( dataUrl )
      .then( (HttpResponse responseRequest) {
        return new Future.value( responseRequest.data );
      });
  }
  
  Future<String> contestAll() {
    print("Http: contestAll");
    
    var dataUrl = "$HostServer/contest_all";
    
    return _http.get( dataUrl )
      .then( (HttpResponse responseRequest) {
        return new Future.value( responseRequest.data );
      });
  }
  
}