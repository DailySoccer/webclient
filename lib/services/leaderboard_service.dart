library leaderboard_service;

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import 'package:webclient/services/profile_service.dart';

@Injectable()
class LeaderboardService {
    
  static const List<Map> trueSkillDataList = const [
    const {
      'id' : 1,
      'name': "NOVATO",
      'limiteInf' : null,
      'limiteSup' : 1500
    },
    const {
      'id' : 2,
      'name': "AMATEUR",
      'limiteInf' : 1501,
      'limiteSup' : 3000
    },
    const {
      'id' : 3,
      'name': "PROFESIONAL",
      'limiteInf' : 3001,
      'limiteSup' : 4000
    },
    const {
      'id' : 4,
      'name': "CRACK",
      'limiteInf' : 4001,
      'limiteSup' : 5000
    },
    const {
      'id' : 5,
      'name': "ESTRELLA",
      'limiteInf' : 5001,
      'limiteSup' : null
    }
  ];
  
  static const Map topTrueSkillData = const {
      'id' : 6,
      'name': "LEYENDA"
  };
  
  List<User> users;
  int myPosition;
  Map currentTrueSkillData;

  void calculateMyTrueSkillData() {
    getUsers();
    
    currentTrueSkillData = trueSkillDataList.firstWhere((lvl) {
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
    }, orElse: () => trueSkillDataList[0]);
    
    if (users != null) {
      if (currentTrueSkillData['id'] == trueSkillDataList.last['id'] && myPosition <= 10) {
        currentTrueSkillData = topTrueSkillData;
      }
    }
  }
  
  String get myTrueSkillName {
    return currentTrueSkillData['name'];
  }
  
  String get myTrueSkillImage {
    return 'nivel' + currentTrueSkillData['id'].toString() + '.png';
  }
  
  
  LeaderboardService(this._server, this._profileService){
    calculateMyTrueSkillData();
  }

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