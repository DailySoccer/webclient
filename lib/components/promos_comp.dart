library promos_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'promos',
    templateUrl: '/packages/webclient/components/promos_comp.html',
    useShadowDom: false
)
class PromosComp {

  ScreenDetectorService scrDet;

  PromosComp(this.scrDet);
}