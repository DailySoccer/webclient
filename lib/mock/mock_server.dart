library mock_daily_soccer_http;

import 'dart:async';
import 'package:mock/mock.dart';
import "package:json_object/json_object.dart";
import 'package:webclient/services/server_service.dart';

part 'mock_users.dart';
part 'mock_matches.dart';
part 'mock_groups.dart';
part 'mock_contests.dart';

class MockDailySoccerServer extends Mock implements ServerService {

  MockDailySoccerServer();

  void setSessionToken(String sessionToken) {}

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {
    print("Mock signup: $firstName - $lastName - $email - $nickName - $password");

    var completer = new Completer();

    if (!_users.exists(email)) {
      _users.add(new JsonObject.fromMap({"firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName, "password": password}));
      completer.complete(new JsonObject.fromJsonString(JSON_REGISTRADO_OK));
    }
    else {
      completer.completeError(new JsonObject.fromJsonString(JSON_ERR_YA_REGISTRADO));
    }

    return completer.future;
  }

  Future<JsonObject> login(String email, String password) {
    print("Mock login: $email - $password");

    var completer = new Completer();

    if (_users.exists(email)) {
      JsonObject userSignedUp = _users.get(email);

      if (userSignedUp.password == password) {
        completer.complete(new JsonObject.fromJsonString(JSON_LOGIN_OK));
        _loggedUser = userSignedUp;
      }
      else {
        completer.completeError(new JsonObject.fromJsonString(JSON_ERR_NO_REGISTRADO));
      }
    }
    else {
      completer.completeError(new JsonObject.fromJsonString(JSON_ERR_NO_REGISTRADO));
    }

    return completer.future;
  }

  Future<JsonObject> getUserProfile() => new Future.value(_loggedUser);


  Future<JsonObject> getAllMatchEvents() {
    return new Future.value(new JsonObject.fromJsonString(_matches.json));
  }

  Future<JsonObject> getAllMatchGroups() {
    return new Future.value(new JsonObject.fromJsonString(_groups.json));
  }

  Future<JsonObject> getAllContests() {
    return new Future.value(new JsonObject.fromJsonString(_contests.json));
  }

  JsonObject _loggedUser;

  var _users    = new MockUsers();
  var _matches  = new MockMatches();
  var _groups   = new MockGroups();
  var _contests = new MockContests();


  /*
   *  JSON RESPONSES
   */
  static const JSON_REGISTRADO_OK = """
    {"result": "ok"} 
  """;
  static const JSON_LOGIN_OK = """
    { "sessionToken": "THEROOFISONFIRE" }
  """;

  static const JSON_ERR_YA_REGISTRADO  = """
    {"result": "error", "reason": "ya registrado"}
  """;
  static const JSON_ERR_NO_REGISTRADO  = """
    {"result": "error", "reason": "no registrado"}
  """;
  static const JSON_ERR_NO_LOGIN       = """
    {"result": "error", "reason": "no login"}
  """;
}