library achivements_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/services/profile_service.dart';


@Component(
    selector: 'achivements',
    templateUrl: 'packages/webclient/components/achivements_comp.html',
    useShadowDom: false
)

class AchivementsComp {

  ProfileService profileService;
/*
  LoadingService loadingService;
*/

  bool achievementEarned(achievementKey) => profileService.isLoggedIn && profileService.user.hasAchievement(achievementKey);

  AchivementsComp ( this.profileService /*, this.loadingService*/) {
    /*
    // TEST: Dar premios al usuario
    if (profileService.isLoggedIn) {
      profileService.user.achievements.add(Achievement.PLAYED_VIRTUAL_CONTESTS_LEVEL_1);
    }
     */
  }

  List<Achievement> achivementList = Achievement.AVAILABLES.map( (achievementMap) => new Achievement.fromJsonObject(achievementMap)).toList();
}
