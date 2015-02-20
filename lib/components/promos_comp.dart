library promos_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';

@Component(
    selector: 'promos',
    templateUrl: 'packages/webclient/components/promos_comp.html',
    useShadowDom: false
)
class PromosComp {

  ScreenDetectorService scrDet;
  PromosService promosService;
  Map<String,Map> promos;

  PromosComp(this.scrDet, this.promosService, this._router) {
    int quantity = scrDet.isXsScreen? 1: 2;
    promos = promosService.getRandomPromo(quantity);
  }

  void gotoPromo(int promoId) {
    //TODO: elegir el link, pero tiene preferencia el directUrl.
    _router.go('restricted', {});
  }

  String getThumb(int pos, String thumbSize) {
    return promos.values.toList()[pos][thumbSize];
  }

  Router _router;

}