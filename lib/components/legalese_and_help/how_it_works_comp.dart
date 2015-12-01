library how_it_works_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'how-it-works',
   templateUrl: 'packages/webclient/components/legalese_and_help/how_it_works_comp.html',
   useShadowDom: false
)
class HowItWoksComp {
  
  ScreenDetectorService scrDet;
  
  String getLocalizedText(key, {group: "howitworks", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }
  
  HowItWoksComp(this.scrDet);
}