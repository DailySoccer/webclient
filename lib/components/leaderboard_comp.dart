library leaderboard_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';


@Component(
    selector: 'leaderboard',
    templateUrl: 'packages/webclient/components/leaderboard_comp.html',
    useShadowDom: false
)

class LeaderboardComp {

  LoadingService loadingService;
  ProfileService profileService;

  int usersToShow = 7;  
  
  String pointsColumnName = "Points";
  String moneyColumnName = "Money";

  String playerPointsHint = 'Eres un crack!!';
  String playerMoneyHint = 'Paquete';
  
  bool isThePlayer(id) => id == profileService.user.userId/*get del singleton*/;

  List<Map> pointsUserList;
  List<Map> moneyUserList;
  Map playerPointsInfo = {'position':'_', 'id':'', 'name': '', 'points': ' '};
  Map playerMoneyInfo = {'position':'_', 'id':'', 'name': '', 'points': '\$ '};

  LeaderboardComp (LeaderboardService leaderboardService, this.loadingService, this.profileService) {
    loadingService.isLoading = true;
    leaderboardService.getUsers()
      .then((List<User> users) {
        List<User> pointsUserListTmp = new List<User>.from(users);
        List<User> moneyUserListTmp = new List<User>.from(users);
        
        pointsUserListTmp.sort( (User u1, User u2) => u2.trueSkill.compareTo(u1.trueSkill) );
        moneyUserListTmp.sort( (User u1, User u2) => u2.earnedMoney.compareTo(u1.earnedMoney) );
        
        int i = 1;
        pointsUserList = pointsUserListTmp.map((User u) => {'position': i++, 'id':u.userId, 'name':u.nickName, 'points':u.trueSkill}).toList();
        i = 1;
        moneyUserList = moneyUserListTmp.map((User u) => {'position': i++, 'id':u.userId, 'name':u.nickName, 'points':u.earnedMoney}).toList();
        
        playerPointsInfo = pointsUserList.firstWhere( (u) => isThePlayer(u['id']));
        playerMoneyInfo = moneyUserList.firstWhere( (u) => isThePlayer(u['id']));
        
        loadingService.isLoading = false;
        print("Users: ${users.length}");
      });
  }

  void tabChange(String tab) {
    querySelectorAll("#leaderboard-wrapper .tab-pane").classes.remove('active');
    querySelector("#${tab}").classes.add("active");
  }

}