library user_manager;

import 'dart:async';

import '../models/user.dart';

class UserManager {
  User user = null;

  bool get isLoggedIn => user != null;

  UserManager() {
  }

  Future signup(User newUser) {
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
}