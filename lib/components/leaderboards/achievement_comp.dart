library achievement_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/models/achievement.dart';

@Component(
    selector: 'achievement',
    templateUrl: 'achievement_comp.html'
)

class AchievementComp {
 
  Achievement achiev;
  bool owned;
  
  @Input("key")
  void set Data(value) {
    if (value != null) {
      achiev = value;
    }
  }
  
  @Input("owned")
  void set isOwned(value) {
      owned = value;
  }
  
  String get theHtml => '''
        <div class="achievement ${achiev.style} ${owned? 'earned': ''}">
          <div class="achievement-icon">
            ${achiev.image != ''? '<img src="images/achievements/${achiev.image}">' : ''}
            ${achiev.level != -1? '<span class="achievement-level">${achiev.level}</span>' : ''}
          </div>
          <div class="achievement-name">${achiev.name}</div>
          <div class="achievement-description">${achiev.description}</div>
        </div>
      ''';
  
  static String toHtml(String achievementKey, {bool enabled: true}) {
    AchievementComp achComp = new AchievementComp();
    achComp.Data = achievementKey;
    achComp.owned = enabled;
    
    return achComp.theHtml;
  }
  
  AchievementComp() {}
  

}