library leaderboard_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';


@Component(
    selector: 'leaderboard',
    templateUrl: 'packages/webclient/components/leaderboard_comp.html',
    useShadowDom: false
)

class LeaderboardComp {

  String pointsColumnName = "Points";
  String moneyColumnName = "Money";

  String playerPointsHint = 'Eres un crack!!';
  String playerMoneyHint = 'Paquete';
  bool isThePlayer(id) => id == '123b'/*get del singleton*/;

  List<Map> pointsUserList = [
    {'position':'1', 'id':'123',  'name': 'Juan Carlos Ruiz', 'points': '3527'},
    {'position':'2', 'id':'123s', 'name': 'Rodrigo Lara',     'points': '3333'},
    {'position':'3', 'id':'123b', 'name': 'Flaco',            'points': '3250'},
    {'position':'4', 'id':'123c', 'name': 'Gregorio Iniesta Ovejero', 'points': '100'},
    {'position':'5', 'id':'123d', 'name': 'Juan Carlos Ruiz', 'points': '100'},
    {'position':'6', 'id':'123e', 'name': 'Juan Carlos Ruiz', 'points': '100'}
  ];

  List<Map> moneyUserList = [
    {'position':'1',    'id':'123',   'name': 'Juan Carlos Ruiz', 'points': '352'},
    {'position':'2',    'id':'123s',  'name': 'Juan Carlos Ruiz', 'points': '29'},
    {'position':'3',    'id':'123d',  'name': 'Rodrigo Lara',     'points': '28'},
    {'position':'4',    'id':'123c',  'name': 'Juan Carlos Ruiz', 'points': '28'},
    {'position':'5',    'id':'123e',  'name': 'Juan Carlos Ruiz', 'points': '27'},
    {'position':'6666', 'id':'123b',  'name': 'Flaco',            'points': '25'}
  ];

  Map playerPointsCache = null;
  Map playerMoneyCache = null;

  LeaderboardComp (LeaderboardService leaderboardService) {
    leaderboardService.getUsers()
      .then((List<User> users) {
        print("Users: ${users.length}");
      });
  }

  void tabChange(String tab) {
    querySelectorAll("#leaderboard-wrapper .tab-pane").classes.remove('active');
    querySelector("#${tab}").classes.add("active");
  }

  Map get playerPointsInfo {
    if (playerPointsCache == null) {
      playerPointsCache = pointsUserList.firstWhere( (u) => isThePlayer(u['id']));
    }
    return playerPointsCache;
  }

  Map get playerMoneyInfo {
    if (playerMoneyCache == null) {
      playerMoneyCache = moneyUserList.firstWhere( (u) => isThePlayer(u['id']));
    }
    return playerMoneyCache;
  }


}