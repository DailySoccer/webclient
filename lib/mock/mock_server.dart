library mock_daily_soccer_http;

import 'dart:async';
import 'package:mock/mock.dart';
import "package:json_object/json_object.dart";
import 'package:webclient/services/server_service.dart';
import 'package:webclient/models/contests_pack.dart';

part 'mock_users.dart';
part 'mock_match_events.dart';
part 'mock_groups.dart';
part 'mock_contests_pack.dart';

class MockDailySoccerServer extends Mock implements ServerService {

  MockDailySoccerServer();

  void setSessionToken(String sessionToken) {}

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {
    print("Mock signup: $firstName - $lastName - $email - $nickName - $password");

    var completer = new Completer();

    if (!_users.exists(email)) {
      _users.add(new JsonObject.fromMap({"firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName, "password": password}));
      completer.complete(new JsonObject.fromJsonString(JSON_SIGNUP_OK));
    }
    else {
      completer.completeError(new JsonObject.fromJsonString(JSON_ERR_ALREADY_SIGNEDUP));
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
        completer.completeError(new JsonObject.fromJsonString(JSON_ERR_INVALID_LOGIN));
      }
    }
    else {
      completer.completeError(new JsonObject.fromJsonString(JSON_ERR_INVALID_LOGIN));
    }

    return completer.future;
  }

  Future<JsonObject> getUserProfile() => new Future.value(_loggedUser);

  Future<JsonObject> getActiveContestsPack() {
    return new Future.value(new JsonObject.fromJsonString(_contestsPac));
  }

  JsonObject _loggedUser;

  var _users = new MockUsers();
  var _matches = new MockMatchEvents();
  var _groups = new MockGroups();
  var _contestsPack = new MockContestsPack();


  /*
   *  JSON RESPONSES
   */
  static const JSON_SIGNUP_OK = """
    {"result": "ok"} 
  """;
  static const JSON_LOGIN_OK = """
    { "sessionToken": "THEROOFISONFIRE" }
  """;

  static const JSON_ERR_ALREADY_SIGNEDUP  = """
    {"result": "error", "reason": "ya registrado"}
  """;
  static const JSON_ERR_INVALID_LOGIN  = """
    {"result": "error", "reason": "no registrado"}
  """;
}