library how_to_create_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'how-to-create-contest',
   templateUrl: 'packages/webclient/components/legalese_and_help/how_to_create_contest_comp.html',
   useShadowDom: false
)
class HowToCreateContestComp {
  
  ScreenDetectorService scrDet;
  
  String getLocalizedText(key, {group: "howtocreatecontest", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }
  
  HowToCreateContestComp(this.scrDet, this._router);
  
  void goToPage(String page) {
    _router.go(page, {});
  }
  
  Router _router;
}