library profile_service;

import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/server_service.dart';


class ProfileService {
  User user = null;
  String sessionToken;
  bool get isLoggedIn => user != null && sessionToken != null;

  ProfileService(this._server);

  Future signup(String firstName, String lastName, String email, String nickName, String password) {
    return _server.signup(firstName, lastName, email, nickName, password)
                  .then((jsonObject) => login(email, password))
                  .catchError((error) => print("TODO: Tratar errores $error"));
  }

  Future login(String email, String password) {
    return _server.login(email, password).then(_onLoginResponse).catchError((error) => print("TODO: tratar errores $error"));
  }

  Future _onLoginResponse(JsonObject jsonObject) {
    sessionToken = jsonObject.sessionToken;

    return _server.getUserProfile()
                  .then((jsonObject) => user = new User.initFromJSONObject(jsonObject))
                  .catchError((error) => print("TODO: Tratar errores $error"));
  }

  Future logout() {
    user = null;
    sessionToken = null;
    return new Completer.sync().future;
  }

  ServerService _server;
}