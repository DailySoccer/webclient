library leaderboard_service;

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";

@Injectable()
class LeaderboardService {

  List<User> users;

  LeaderboardService(this._server);

  Future<List<User>> getUsers() {
    var completer = new Completer();

    // Tenemos cargada la leaderboard solicitada?
    if (users != null) {
      completer.complete(users);
    }
    else {
      // Solicitamos al server la leaderboard
      var random = new Random();
      _server.getLeaderboard()
        .then((jsonMapRoot) {
            users = jsonMapRoot.containsKey("users") ? jsonMapRoot["users"].map((jsonObject) => new User.fromJsonObject(jsonObject)).toList() : [];
            users.forEach((User u) {
              u.earnedMoney.amount = random.nextInt(300);
              u.trueSkill = random.nextInt(3000);
            });
            completer.complete(users);
          });
    }

    return completer.future;
  }

  ServerService _server;
}