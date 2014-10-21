library help_info_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
   selector: 'help-info',
   templateUrl: '/packages/webclient/components/legalese_and_help/help_info_comp.html',
   useShadowDom: false
)
class HelpInfoComp {
  ScreenDetectorService scrDet;

  HelpInfoComp(this.scrDet, this._router);

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll("#helpInfo .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

  }

  void goTo(String path) {
    _router.go(path, {});
  }

  Router _router;
}