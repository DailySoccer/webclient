library profile_service;

import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/server_request.dart';


class ProfileService {
  User user = null;
  bool get isLoggedIn => user != null;

  ProfileService(this._server);

  Future signup(User newUser) {
    _server.signup(newUser.firstName, newUser.lastName, newUser.email, newUser.nickName, newUser.password)
        .then((jsonObject) {

           var veamos = 0;

        }).catchError((e) {
          print("TODO: Tratar errores $e");
        });

    var completer = new Completer();
    return completer.future;
  }


  Future login(String login, String password) {

    var completer = new Completer();
    return completer.future;
  }


  Future logout() {
    var completer = new Completer();

    return completer.future;
  }

  ServerRequest _server;
}