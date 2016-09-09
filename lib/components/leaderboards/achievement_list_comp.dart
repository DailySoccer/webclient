library achievement_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';


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
    _userShown = userShown;
  }

  String earneds;
  bool achievementEarned(achievementKey) => _userShown != null? _userShown.hasAchievement(achievementKey) : false;

  AchievementListComp ( this.profileService /*, this.loadingService*/) {
  
    // TEST: Dar premios al usuario
    if (profileService.isLoggedIn) {
      profileService.user.achievements.add(Achievement.PLAYED_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_OFFICIAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.DIFF_FP_OFFICIAL_CONTEST_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_SAVES_SHOTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_RED_CARD);
      profileService.user.achievements.add(Achievement.GOALKEEPER_SAVES_SHOTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.MANAGER_LEVEL_5);
    }
  
    countAchievementsEarned();
  }
  
  void countAchievementsEarned() {
    int count = 0;
    achievementList.forEach((ach) {
        if (achievementEarned(ach.id))
          count++;
    });
    earneds = count.toString();
  }
  
  List<Achievement> achievementList = Achievement.AVAILABLES.map( (achievementMap) => new Achievement.fromJsonObject(achievementMap)).toList();
  
  User _userShown = null;
}
