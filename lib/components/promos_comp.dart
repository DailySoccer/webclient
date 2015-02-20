library promos_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
    selector: 'promos',
    templateUrl: 'packages/webclient/components/promos_comp.html',
    useShadowDom: false
)
class PromosComp implements DetachAware{

  ScreenDetectorService scrDet;
  PromosService promosService;
  Map<String,Map> promos;

  PromosComp(this.scrDet, this.promosService, this._router) {
    int quantity = scrDet.isXsScreen? 1: 2;
    promos = promosService.getRandomPromo(quantity);
    _screenWidthChangeDetector = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void gotoPromo(int promoId) {
    //TODO: elegir el link, pero tiene preferencia el directUrl.
    GameMetrics.logEvent(GameMetrics.PROMO, {"code": promos.values.toList()[promoId]['name']});
    _router.go('restricted', {});
  }

  void onScreenWidthChange(String size) {
    int quantity = scrDet.isXsScreen? 1: 2;
    promos = promosService.getRandomPromo(quantity);
  }

  String getThumb(int pos, String thumbSize) {
    return promos.values.toList()[pos][thumbSize];
  }

  @override
  void detach() {
    _screenWidthChangeDetector.cancel();
  }

  Router _router;
  var _screenWidthChangeDetector;



}