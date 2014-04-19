library profile_service;

import 'dart:async';
import 'package:angular/angular.dart';
import '../models/user.dart';


class ProfileService {
  User user = null;
  bool get isLoggedIn => user != null;


  ProfileService(this._http);


  Future signup(User newUser) {

    //_http.get("$HostServer");

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

  Http  _http;
}