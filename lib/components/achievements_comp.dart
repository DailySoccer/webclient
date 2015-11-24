library achivements_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'achievements',
    templateUrl: 'packages/webclient/components/achievements_comp.html',
    useShadowDom: false
)

class AchievementsComp {
/*
  LoadingService loadingService;
  ProfileService profileService;
*/
  AchievementComp (/*this.loadingService, this.profileService*/) {
  }
  
  List<Achievement> achievementList = [
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'Training', earned: true),
      new Achievement(name: "xcv", description: "qweqweqweqwe", image: '', style: 'Training', earned: true),
      new Achievement(name: "ser", description: "eeeeeeee", image: '', style: 'Oficial', earned: false),
      new Achievement(name: "sds", description: "ddddddd", image: '', style: 'Oficial', earned: true),
      new Achievement(name: "asd", description: "cccccccc", image: '', style: 'Training', earned: true),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'Training', earned: true),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'Oficial', earned: true),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'ManagerLevel', earned: true),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'Player', earned: true),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'SkillLevel', earned: true, level: 1),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'SkillLevel', earned: true, level: 2),
      new Achievement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'SkillLevel', earned: true, level: 3)
    ];
}

class Achievement {

  String name;
  String description;
  String image;
  String style;
  bool earned;
  int level;

  static const BASIC_STYLE = "basic";
  static const ORANGE_STYLE = "orange";
  
  Achievement({String name: "", String description: "", String image: "", String style: BASIC_STYLE, bool earned: false, int level: -1}) {
    this.name = name;
    this.description = description;
    this.image = image;
    this.style = style;
    this.earned = earned;
  }
  
}