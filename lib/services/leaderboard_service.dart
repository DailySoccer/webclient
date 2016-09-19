library leaderboard_service;

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import 'package:webclient/services/profile_service.dart';

@Injectable()
class LeaderboardService {

  static const String TRUESKILL_TOP_LEVEL = "LEYENDA";
  static const List<Map> trueSkillNameList = const [
    const {
      'name': "NOVATO",
      'limiteInf' : null,
      'limiteSup' : 1500
    },
    const {
      'name': "AMATEUR",
      'limiteInf' : 1501,
      'limiteSup' : 3000
    },
    const {
      'name': "PROFESIONAL",
      'limiteInf' : 3001,
      'limiteSup' : 4000
    },
    const {
      'name': "CRACK",
      'limiteInf' : 4001,
      'limiteSup' : 5000
    },
    const {
      'name': "ESTRELLA",
      'limiteInf' : 5001,
      'limiteSup' : null
    }
  ];
  
  List<User> users;
  int myPosition;

  String get myTrueSkillName {
    getUsers();
    
    String name = trueSkillNameList.firstWhere((lvl) {
      if (lvl['limiteInf'] == null) {
        return  _profileService.user.trueSkill <= lvl['limiteSup'];
      }
      if (lvl['limiteSup'] == null) {
        return  lvl['limiteInf'] <= _profileService.user.trueSkill;
      }
      
      if (lvl['limiteInf'] <= _profileService.user.trueSkill  && _profileService.user.trueSkill <= lvl['limiteSup'])
        return true;
      else
        return false;
    }, orElse: () => trueSkillNameList[0])['name'];
    
    if (users != null) {
      if (name == trueSkillNameList.last['name'] && myPosition <= 10) {
        name = TRUESKILL_TOP_LEVEL;
      }
    }
    
    return name;
  }
  
  
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
            for (int i = 0; i<users.length; i++) {
              if (users[i].userId == _profileService.user.userId)
                myPosition = i + 1;
            }            
            completer.complete(users);
          });
    }

    return completer.future;
  }

  ServerService _server;
  ProfileService _profileService;
}