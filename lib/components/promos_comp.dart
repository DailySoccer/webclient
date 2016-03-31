library promos_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'dart:html';
import 'package:webclient/services/refresh_timers_service.dart';

@Component(
    selector: 'promos',
    templateUrl: 'packages/webclient/components/promos_comp.html',
    useShadowDom: false
)
class PromosComp {

  static final int QUANTITY = 4;

  ScreenDetectorService scrDet;
  PromosService promosService;
  Map<String,Map> promos = {};

  PromosComp(this.scrDet, this.promosService, this._router, this._refreshTimersService) {
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_PROMOS, refreshPromos);
  }

  void gotoPromo(int pos) {
    //TODO: elegir el link, pero tiene preferencia el directUrl.
    // GameMetrics.logEvent(GameMetrics.PROMO, {"code": promos.values.toList()[pos]['codeName']});
    String url = promos.values.toList()[pos]['url'] == '' ? 'view_promo' : promos.values.toList()[pos]['url'];
    Map params = promos.values.toList()[pos]['url'] == '' ? {"promoId" : pos} : {};

    if (url.contains("#")) {
      window.location.assign(url);
    }
    else {
      _router.go(url, params);
    }
  }

  void refreshPromos() {
    promosService.getRandomPromo(QUANTITY).then((promoMap) => promos = promoMap);
  }

  bool hasPromos() {
    return promos.length > 0;
  }
  String getThumb(int pos, String thumbSize) {
    if (promos != null && promos.length>pos)
      return promos.values.toList()[pos][thumbSize];
    else return '';
  }

  Router _router;
  RefreshTimersService _refreshTimersService;

}