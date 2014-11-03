library profile_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/server_service.dart';


@Injectable()
class ProfileService {

  User user = null;
  bool get isLoggedIn => user != null;

  static bool get isLoggedInStatic => _instance.isLoggedIn;  // Si te peta en esta linea te obliga a pensar, lo que es Una Buena Cosa@.
                                                             // Una pista... quiza te ha pasado pq has quitado componentes del index?

  ProfileService(this._server) {
    _instance = this;
    _tryProfileLoad();
  }

  Future<Map> verifyPasswordResetToken(String stormPathTokenId) {
    return _server.verifyPasswordResetToken(stormPathTokenId);
  }

  Future<Map>resetPassword(String password, String stormPathTokenId) {
    return _server.resetPassword(password, stormPathTokenId).then(_onLoginResponse);
  }

  Future<Map> signup(String firstName, String lastName, String email, String nickName, String password) {

    if (isLoggedIn)
      throw new Exception("WTF 4234 - We shouldn't be logged in when signing up");

    return _server.signup(firstName, lastName, email, nickName, password);
   }

  Future<Map> login(String email, String password) {
    return _server.login(email, password).then(_onLoginResponse);
  }

  Future<Map> _onLoginResponse(Map loginResponseJson) {

    _server.setSessionToken(loginResponseJson["sessionToken"]); // to make the getUserProfile call succeed
    return _server.getUserProfile()
                      .then((jsonMap) => _setProfile(loginResponseJson["sessionToken"], new User.fromJsonObject(jsonMap), true));
  }

  Future<Map> refreshUserProfile() {
    return _server.getUserProfile()
                      .then((jsonMap) => _setProfile(_sessionToken, new User.fromJsonObject(jsonMap), true));
  }

  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password) {

    if (!isLoggedIn)
      throw new Exception("WTF 4288 - We should be logged in when change User Profile");

    return _server.changeUserProfile(firstName, lastName, email, nickName, password);
  }

  Future<Map> logout() {

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
      _setProfile(storedSessionToken, new User.fromJsonObject(JSON.decode(storedUser)), false);
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

  static ProfileService _instance;

  ServerService _server;
  String _sessionToken;
}