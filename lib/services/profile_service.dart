library profile_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:json_object/json_object.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/server_service.dart';


class ProfileService {
  User user = null;
  bool get isLoggedIn => user != null;

  ProfileService(this._server, {bool tryProfileLoad: true}) {
    if (tryProfileLoad)
      _tryProfileLoad();
  }

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {

    if (isLoggedIn)
      throw new Exception("WTF 4234 - We shouldn't be logged in when signing up");

    return _server.signup(firstName, lastName, email, nickName, password);
   }

  Future<JsonObject> login(String email, String password) {
    return _server.login(email, password).then(_onLoginResponse);
  }

  Future<JsonObject> _onLoginResponse(JsonObject loginResponseJson) {
    _server.setSessionToken(loginResponseJson.sessionToken); // to make the getUserProfile call succeed

    return _server.getUserProfile()
                  .then((jsonObject) => _setProfile(loginResponseJson.sessionToken, new User.fromJsonObject(jsonObject), true));
  }

  Future<JsonObject> logout() {

    if (!isLoggedIn)
      throw new Exception("WTF 444 - We should be logged in when loging out");

    _setProfile(null, null, true);
    return new Future.value();
  }

  void _setProfile(String theSessionToken, User theUser, bool bSave) {
    _sessionToken = theSessionToken;
    _server.setSessionToken(_sessionToken);
    user = theUser;

    if (bSave) {
      _saveProfile();
    }
  }

  void _tryProfileLoad() {
    var storedSessionToken = window.localStorage['sessionToken'];
    var storedUser = window.localStorage['user'];

    if (storedSessionToken != null && storedUser != null) {
      _setProfile(storedSessionToken, new User.fromJsonString(storedUser), false);
    }
  }

  void _saveProfile() {
    if (user != null && _sessionToken != null) {
      window.localStorage['sessionToken'] = _sessionToken;
      window.localStorage['user'] = JSON.encode(user);
    }
    else {
      window.localStorage.remove('sessionToken');
      window.localStorage.remove('user');
    }
  }

  ServerService _server;
  String _sessionToken;
}