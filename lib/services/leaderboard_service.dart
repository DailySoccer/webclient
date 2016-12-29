library leaderboard_service;

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/user.dart";
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/models/user_ranking.dart';
import 'package:logging/logging.dart';

@Injectable()
class LeaderboardService {
  static int SECONDS_TO_REFRESH_RANKING_POSITION = 1;
  
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
  
  List<UserRanking> users;
  int mySkillPosition;
  Map currentTrueSkillData;
  
  List<UserRanking> get goldRanking {
    if (_goldRanking == null) {
      // No recibimos la lista de usuarios completa
      Map<int, UserRanking> ranking = new Map<int, UserRanking>();
      for (int i=0; i<users.length; i++) {
        UserRanking user = users[i];
        ranking[user.goldRank - 1] = user;
      }
      
      // Garantizamos que tenemos las keys ordenadas
      List <int> keys = ranking.keys.toList();
      keys.sort( (int i1, int i2) => i1.compareTo(i2));
      
      // Convertimos el map a una lista ordenada
      _goldRanking = new List<UserRanking>(users.length);
      for (int i=0; i<keys.length; i++) {
        _goldRanking[i] = ranking[ keys[i] ];
      }
      // _goldRanking.sort( (UserRanking u1, UserRanking u2) => u1.goldRank.compareTo(u2.goldRank) );
    }
    return _goldRanking;
  }
  List<UserRanking> _goldRanking;

  List<UserRanking> get skillRanking {
    if (_skillRanking == null) {
      // No recibimos la lista de usuarios completa
      Map<int, UserRanking> ranking = new Map<int, UserRanking>();
      for (int i=0; i<users.length; i++) {
        UserRanking user = users[i];
        ranking[user.skillRank - 1] = user;
      }
      
      // Garantizamos que tenemos las keys ordenadas
      List <int> keys = ranking.keys.toList();
      keys.sort( (int i1, int i2) => i1.compareTo(i2));
      
      // Convertimos el map a una lista ordenada
      _skillRanking = new List<UserRanking>(users.length);
      for (int i=0; i<keys.length; i++) {
        _skillRanking[i] = ranking[ keys[i] ];
      }
      // _skillRanking.sort( (UserRanking u1, UserRanking u2) => u1.skillRank.compareTo(u2.skillRank) );
    }
    return _skillRanking;
  }
  List<UserRanking> _skillRanking;
  
  void calculateMyTrueSkillData() {
    if (!_profileService.isLoggedIn) {
      currentTrueSkillData = trueSkillDataList.first;
      return;
    }
    
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
      if (currentTrueSkillData['id'] == trueSkillDataList.last['id'] && mySkillPosition <= 10) {
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
  
  //Timer uppdateMyLeaderBoradData;
  
  LeaderboardService(this._server, this._profileService){
    //calculateMyTrueSkillData();
    
    //uppdateMyLeaderBoradData = new Timer(new Duration(seconds: SECONDS_TO_REFRESH_RANKING_POSITION), calculateMyTrueSkillData);    
  }

  UserRanking getUser (String userId) => users.firstWhere( (user) => user.userId == userId, orElse: () => null);
  
  Future<List<UserRanking>> getUsers() {
    var completer = new Completer();

    // Tenemos la leaderboard cargada?
    bool updated = (users != null);

    if (updated && _profileService.isLoggedIn) {
      // La tenemos correctamente actualizada? (puntos iguales a los del propio perfil de usuario)
      UserRanking userInLeaderboard = getUser(_profileService.user.userId);
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
            users = jsonMapRoot.containsKey("users") ? jsonMapRoot["users"].map((jsonObject) => new UserRanking.fromJsonObject(jsonObject)).toList() : [];
            for (int i = 0; i<users.length; i++) {
              if (users[i].userId == _profileService.user.userId) {
                mySkillPosition = users[i].skillRank;
                break;
              }
            }            
            
            _goldRanking = _skillRanking = null;
            
            completer.complete(users);
          });
    }

    return completer.future;
  }

  ServerService _server;
  ProfileService _profileService;
}