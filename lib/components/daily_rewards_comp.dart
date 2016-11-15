library daily_rewards_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'dart:html';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:logging/logging.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/reward.dart';

@Component(
    selector: 'daily-rewards',
    templateUrl: 'packages/webclient/components/daily_rewards_comp.html',
    useShadowDom: false
)
class DailyRewardsComp {

  static const List<Reward> EMPTY = const [];
  
  bool dailyRewardShow = false;
  List<Reward> get dailyRewards => _profileService.isLoggedIn? _profileService.user.dailyRewards : EMPTY;
  int get todayReward => _profileService.isLoggedIn? _profileService.user.consecutiveDays - 1 : 0;
  
  DailyRewardsComp(this._profileService) {
    _profileService.onRefreshProfile.listen(onProfileRefresh); 
    /*
     * EJEMPLO DE CHECK DE DAILYREWARDS
     */
    
    // Check DailyRewards
    /*if (_profileService.isLoggedIn && _profileService.user.canClaimReward) {
      Logger.root.info("dailyRewards: claimReward: ${_profileService.user.dailyRewards[_profileService.user.consecutiveDays-1].toString()}");
    }*/
  }
  
  void onProfileRefresh(User user) {
    if (user.canClaimReward) {
      dailyRewardShow = true;
    }
  }

  void claimReward() {
    // Cuando el usuario pulse "Aceptar" en el mensaje de información del popup del DailyReward, se solicitará al servidor que nos dé la recompensa
    _profileService.claimReward();
    dailyRewardShow = false;
  }
  
  String rewardData(Reward reward) {
    
    switch(reward.type) {
      case Reward.TYPE_GOLD:
        return "${reward.money.amount.toInt()} <img src='images/topBar/icon_coin_big.png'>";
    }
    return "";
  }
  

  ProfileService _profileService;
  
}