library ranking_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'dart:math';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
    selector: 'ranking',
    templateUrl: 'ranking_comp.html'
)

class RankingComp {
 
  @Input('ranking-points-data')
  set pointsList(List<Map> value) {
    if (value != null) {
      pointsUserList = value;
      myPointsData = pointsUserList.where((user) => user['id'] == profileService.user.userId).first;
    }
  }
  List<Map> pointsUserList;
  
  @Input('ranking-money-data')
  set moneyList(List<Map> value) {
    if (value != null) {
      moneyUserList = value;
      myMoneyData = moneyUserList.where((user) => user['id'] == profileService.user.userId).first;
    }
  }
  List<Map> moneyUserList;
  
  Map myPointsData;
  Map myMoneyData;
  
  @Input('on-show-ranking-points')
  Function showPointsRanking;
  
  @Input('on-show-ranking-money')
  Function showMoneyRanking;
    
  LoadingService loadingService;
  ProfileService profileService;
  
  String userId = null;
  String getLocalizedText(key, [group = "ranking"]) { return StringUtils.translate(key, group); }
  
  RankingComp (this.loadingService, LeaderboardService leaderboardService, this.profileService) {
    if (myPointsData != null)
      myPointsData = pointsUserList.where((user) => user['id'] == profileService.user.userId).first;
    
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