library achievement_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/achievement.dart';


@Component(
    selector: 'achievement',
    templateUrl: 'packages/webclient/components/achievement_comp.html',
    useShadowDom: false
)

class AchievementComp {
 
  Achievement achiev;
  bool earned;
  
  @NgOneWay("key")
  void set Data(value) {
    if (value != null) {
      achiev = Achievement.getAchievementWithKey(value);
    }
  }
  
  @NgOneWay("enabled")
  void set Earned(value) {
      earned = value;
  }
  
  AchievementComp() {}
  

}