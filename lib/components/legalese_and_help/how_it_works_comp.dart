library how_it_works_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'how-it-works',
   templateUrl: 'how_it_works_comp.html'
)
class HowItWoksComp {
  
  ScreenDetectorService scrDet;
  
  String getLocalizedText(key, {group: "howitworks", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }
  
  HowItWoksComp(this.scrDet);
}