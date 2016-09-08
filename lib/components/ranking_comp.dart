library ranking_comp;

import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';

@Component(
    selector: 'ranking',
    templateUrl: 'packages/webclient/components/ranking_comp.html',
    useShadowDom: false
)

class RankingComp {
 
  
  @NgCallback('on-show-ranking-points')
  Function showPointsRanking;
  
  @NgCallback('on-show-ranking-money')
  Function showMoneyRanking;
  
  List<Map> pointsUserList;
  List<Map> moneyUserList;
  
  //bool isThePlayer(id) => id == profileService.user.userId;
  
  LoadingService loadingService;
  ProfileService profileService;
  
  String userId = null;
  String getLocalizedText(key, [group = "ranking"]) { return StringUtils.translate(key, group); }
  
  RankingComp (this.loadingService, LeaderboardService leaderboardService, this.profileService) {
    
    loadingService.isLoading = true;
    userId = profileService.user.userId;

    leaderboardService.getUsers().then((List<User> users) {
      List<User> pointsUserListTmp = new List<User>.from(users);
      List<User> moneyUserListTmp = new List<User>.from(users);

      pointsUserListTmp.sort( (User u1, User u2) => u2.trueSkill.compareTo(u1.trueSkill) );
      moneyUserListTmp.sort( (User u1, User u2) => u2.earnedMoney.compareTo(u1.earnedMoney) );

      int i = 1;
      pointsUserList = pointsUserListTmp.map((User u) => {
        'position': i++,
        'id': u.userId,
        'name': u.nickName,
        'points': StringUtils.parseTrueSkill(u.trueSkill)
      }).toList();

      i = 1;
      moneyUserList = moneyUserListTmp.map((User u) => {
        'position': i++,
        'id': u.userId,
        'name': u.nickName,
        'points': u.earnedMoney
      }).toList();

      loadingService.isLoading = false;
    });       
  }
  
  void showFullPointsRanking() {
    print("Cambiando al ranking completo de puntos");
    showPointsRanking();
  }
  
  void showFullMoneyRanking() {
    print("Cambiando al ranking completo de dinerito");
    showMoneyRanking();
  }
}