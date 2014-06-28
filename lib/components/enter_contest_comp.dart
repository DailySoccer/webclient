library enter_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/enter_contest_service.dart';


@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class EnterContestComp {

  ScreenDetectorService scrDet;
  EnterContestService enterContestService;

  EnterContestComp(this.scrDet, this.enterContestService);
}
