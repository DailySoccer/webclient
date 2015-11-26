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
  
  @NgOneWay("data")
  void set Data(value) {
    if (value != null) {
      achiev = value;
    }
  }
  
  AchievementComp() {}
  

}