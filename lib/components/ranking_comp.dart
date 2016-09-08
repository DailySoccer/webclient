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
 
  @NgOneWay('ranking-points-data')
    set pointsList(List<Map> value) {
    if (value != null) {
      pointsUserList = value;
      myPointsData = pointsUserList.where((user) => user['id'] == profileService.user.userId).first;
    }
  }
  List<Map> pointsUserList;
  
  @NgOneWay('ranking-money-data')
  set moneyList(List<Map> value) {
    if (value != null) {
      moneyUserList = value;
      myMoneyData = moneyUserList.where((user) => user['id'] == profileService.user.userId).first;
    }
  }
  List<Map> moneyUserList;
  
  Map myPointsData;
  Map myMoneyData;
  
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
      myPointsData = pointsUserList.where((user) => user['id'] == profileService.user.userId).first;
    
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