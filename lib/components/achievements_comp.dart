library achievements_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/services/profile_service.dart';


@Component(
    selector: 'achievements',
    templateUrl: 'packages/webclient/components/achievements_comp.html',
    useShadowDom: false
)

class AchievementsComp {

  ProfileService profileService;
/*
  LoadingService loadingService;
*/

  bool achievementEarned(achievementKey) => profileService.isLoggedIn && profileService.user.hasAchievement(achievementKey);

  AchievementsComp ( this.profileService /*, this.loadingService*/) {
    /*
    // TEST: Dar premios al usuario
    if (profileService.isLoggedIn) {
      profileService.user.achievements.add(Achievement.PLAYED_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_VIRTUAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.WON_OFFICIAL_CONTESTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.DIFF_FP_OFFICIAL_CONTEST_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_SAVES_SHOTS_LEVEL_1);
      profileService.user.achievements.add(Achievement.GOALKEEPER_RED_CARD);
      profileService.user.achievements.add(Achievement.GOALKEEPER_SAVES_SHOTS_LEVEL_1);
    }*/
  }

  List<Achievement> achievementList = Achievement.AVAILABLES.map( (achievementMap) => new Achievement.fromJsonObject(achievementMap)).toList();
}
