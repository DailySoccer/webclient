library leaderboard_service;

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import 'package:webclient/services/profile_service.dart';

@Injectable()
class LeaderboardService {

  List<User> users;

  LeaderboardService(this._server, this._profileService);

  Future<List<User>> getUsers() {
    var completer = new Completer();

    // Tenemos la leaderboard cargada?
    bool updated = (users != null);

    if (updated && _profileService.isLoggedIn) {
      // La tenemos correctamente actualizada? (puntos iguales a los del propio perfil de usuario)
      User userInLeaderboard = users.firstWhere( (user) => user.userId == _profileService.user.userId, orElse: () => null);
      if (userInLeaderboard != null && userInLeaderboard.trueSkill != _profileService.user.trueSkill) {
        updated = false;
      }
    }

    // Tenemos actualizada la leaderboard?
    if (updated) {
      completer.complete(users);
    }
    else {
      // Solicitamos al server la leaderboard
      _server.getLeaderboard()
        .then((jsonMapRoot) {
            users = jsonMapRoot.containsKey("users") ? jsonMapRoot["users"].map((jsonObject) => new User.fromJsonObject(jsonObject)).toList() : [];
            completer.complete(users);
          });
    }

    return completer.future;
  }

  ServerService _server;
  ProfileService _profileService;
}