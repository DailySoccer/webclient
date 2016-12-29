library ranking_comp;

import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/models/user_ranking.dart';

@Component(
    selector: 'ranking',
    templateUrl: 'packages/webclient/components/leaderboards/ranking_comp.html',
    useShadowDom: false
)

class RankingComp {
 
  @NgOneWay('ranking-points-data')
    set pointsList(List<UserRanking> value) {
    if (value != null) {
      pointsUserList = value.where((UserRanking user) => user != null).toList();
      myPointsData = pointsUserList.where((user) => user.userId == profileService.user.userId).first;
    }
  }
  List<UserRanking> pointsUserList;
  
  @NgOneWay('ranking-money-data')
  set moneyList(List<UserRanking> value) {
    if (value != null) {
      moneyUserList = value.where((UserRanking user) => user != null).toList();
      myMoneyData = moneyUserList.where((user) => user.userId == profileService.user.userId).first;
    }
  }
  List<UserRanking> moneyUserList;
  
  UserRanking myPointsData;
  UserRanking myMoneyData;
  
  @NgCallback('on-show-ranking-points')
  Function showPointsRanking;
  
  @NgCallback('on-show-ranking-money')
  Function showMoneyRanking;
    
  LoadingService loadingService;
  ProfileService profileService;
  
  String userId = null;
  String getLocalizedText(key, [group = "ranking"]) { return StringUtils.translate(key, group); }
  
  RankingComp (this.loadingService, LeaderboardService leaderboardService, this.profileService) {
    if (myPointsData != null)
      myPointsData = pointsUserList.where((user) => user != null && user.userId == profileService.user.userId).first;
    
    GameMetrics.screenVisitEvent(GameMetrics.SCREEN_RANKING);
     // myMoneyData = moneyUserList.where((user) => user['id'] == profileService.user.userId).first;
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