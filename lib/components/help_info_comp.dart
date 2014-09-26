library help_info_comp;

import 'dart:html';
import 'package:angular/angular.dart';

@Component(
   selector: 'help-info',
   templateUrl: 'packages/webclient/components/help_info_comp.html',
   publishAs: 'helpInfo',
   useShadowDom: false
)
class HelpInfoComp {

  HelpInfoComp();

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll("#helpInfo .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

  }

}