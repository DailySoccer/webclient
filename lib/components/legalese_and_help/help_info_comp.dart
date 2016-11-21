library help_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
   selector: 'help-info',
   templateUrl: 'help_info_comp.html'
)
class HelpInfoComp {
  ScreenDetectorService scrDet;

  HelpInfoComp(this.scrDet, this._router) {
    //GameMetrics.logEvent(GameMetrics.HELP);
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll("#helpInfo .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
    /*
    switch (tab) {
      case 'tutorial-content':
        GameMetrics.logEvent(GameMetrics.TUTORIAL_LIST);
      break;
      case 'how-works-content':
        GameMetrics.logEvent(GameMetrics.HOW_IT_WORKS);
      break;
      case 'rules-scores-content':
        GameMetrics.logEvent(GameMetrics.RULES);
      break;
    }
    */
  }

  void goTo(String path) {
    _router.navigate([path, {}]);
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "help");
  }
  
  Router _router;
}