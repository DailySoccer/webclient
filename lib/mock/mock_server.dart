library mock_daily_soccer_http;

import 'dart:async';
import 'package:mock/mock.dart';

import "package:json_object/json_object.dart";

import '../services/server_request.dart';

part 'mock_users.dart';
part 'mock_matches.dart';
part 'mock_groups.dart';
part 'mock_contests.dart';

class MockDailySoccerServer extends Mock implements DailySoccerServer {
  var _users    = new MockUsers();
  var _matches  = new MockMatches();
  var _groups   = new MockGroups();
  var _contests = new MockContests();
  
  MockDailySoccerServer();
  
  Future<String> register( String fullName, String email, String nickName, String password ) {
    print("Mock Register: $fullName - $email - $nickName - $password");
    
    var completer = new Completer();
    
    if ( !_users.exists(email) ) {
      _users.add( new JsonObject.fromMap({"fullName": fullName, "email": email, "nickName": nickName, "password": password}) );
      completer.complete( JSON_REGISTRADO_OK );
    }
    else {
      completer.complete( JSON_ERR_YA_REGISTRADO );
    }
    
    return completer.future;
   }
  
  Future<String> login( String email, String password ) {
    print("Mock: Login: $email - $password");
    
    var completer = new Completer();
    
    if ( _users.exists(email) ) {
      JsonObject userRegistered = _users.get(email);
      if ( userRegistered.password == password ) {
        String responseLogin = JSON_LOGIN_OK.replaceFirst("%fullName%", userRegistered.fullName).replaceFirst("%nickName%", userRegistered.nickName);
        completer.complete( responseLogin );
      }
      else {
        completer.complete( JSON_ERR_NO_REGISTRADO );
      }
    }
    else {
      completer.complete( JSON_ERR_NO_REGISTRADO );
    }
    
    return completer.future;
  }
 
  Future<String> matchAll() {
    print("Http: matchAll");
    return new Future.value( _matches.json );
  }

  Future<String> groupAll() {
    print("Http: groupAll");
    return new Future.value( _groups.json );
  }
  
  Future<String> contestAll() {
    print("Http: contestAll");
    return new Future.value( _contests.json );
  }

  /*
   *  JSON RESPONSES 
   */
  final JSON_REGISTRADO_OK = """
    {"result": "ok"} 
  """;
  final JSON_LOGIN_OK = """
    {"result": "ok", "data": { "fullName": "%fullName%", "nickName": "%nickName%" }}
  """;
  
  final JSON_ERR_YA_REGISTRADO  = """
    {"result": "error", "reason": "ya registrado"}
  """;
  final JSON_ERR_NO_REGISTRADO  = """
    {"result": "error", "reason": "no registrado"}
  """;
  final JSON_ERR_NO_LOGIN       = """
    {"result": "error", "reason": "no login"}
  """;
}