library how_to_create_contest_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'how-to-create-contest',
   templateUrl: 'how_to_create_contest_comp.html'
)
class HowToCreateContestComp {
  
  ScreenDetectorService scrDet;
  
  String getLocalizedText(key, {group: "howtocreatecontest", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }
  
  HowToCreateContestComp(this.scrDet, this._router);
  
  void goToPage(String page) {
    _router.navigate([page, {}]);
  }
  
  Router _router;
}