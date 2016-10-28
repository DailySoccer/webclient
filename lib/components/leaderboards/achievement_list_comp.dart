library achievement_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/utils/game_metrics.dart';


@Component(
    selector: 'achievement-list',
    templateUrl: 'packages/webclient/components/leaderboards/achievement_list_comp.html',
    useShadowDom: false
)

class AchievementListComp {

  ProfileService profileService;
/*
  LoadingService loadingService;
*/
  @NgOneWay("user")
  void set user(User userShown) {
    if (userShown != null)
      _userShown = userShown;
    else
      _userShown = profileService.user;
  }

  String get earneds => countAchievementsEarned();
  bool achievementEarned(achievementKey) {
    bool ret;
    if (_userShown != null){
        ret = _userShown.achievements.contains(achievementKey);
    }
    else { 
      ret = false;
    }
    return ret;
  }

  AchievementListComp ( this.profileService, this._appStateService, this._router /*, this.loadingService*/) {
  
    // TEST: Dar premios al usuario
    if (profileService.isLoggedIn) {
      /*profileService.user.achievements.add(Achievement.PLAYED_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_OFFICIAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.DIFF_FP_OFFICIAL_CONTEST_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_SAVES_SHOTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_RED_CARD);
      profileService.user.achievements.add(Achievement.MANAGER_LEVEL_5);*/
    }
  
    //countAchievementsEarned();
    
    _appStateService.appSecondaryTabBarState.tabList = [];
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Listado de Logros");
    _appStateService.appTopBarState.activeState.onLeftColumn = AppTopBarState.GOBACK;
    _appStateService.appTabBarState.show = false;

    GameMetrics.screenVisitEvent(GameMetrics.SCREEN_ACHIEVEMENTS);    
  }
  /*
  void GoBack() {
    _router.go("user_profile", {});
  }
  */
  String countAchievementsEarned() {
    int count = 0;
    achievementList.forEach((ach) {
        if (achievementEarned(ach.id))
          count++;
    });
    return count.toString();
  }
  
  List<Achievement> achievementList = Achievement.AVAILABLES.map( (achievementMap) {
    return new Achievement.fromJsonObject(achievementMap);
  }).toList();
  
  User _userShown = null;
  AppStateService _appStateService;
  Router _router;
}
