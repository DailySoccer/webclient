library simple_prome_viewer_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';

@Component(
   selector: 'simple-promo-viewer',
   useShadowDom: false
)
class SimplePromoViewerComp implements DetachAware {

  SimplePromoViewerComp(this._router, this._routeProvider, this._scrDet, this._rootElement, this._promosService){
    var promoId = _routeProvider.route.parameters['promoId'];
    promo = _promosService.getPromo(promoId);
    createHTML();
    _screenWidthChangeDetector = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void createHTML() {
    var theHTML = '''
      <div id="simplePromoViewerRoot">
        <img class="img-responsive" src="${_scrDet.isXsScreen ? promo["imageXs"] : promo["imageLg"]}">
        <div class="promo-text>${promo["text"]}</div>
        <div class="autocentered-buttons-wrapper">
          <div class="button-box"><button class="ok-button">${promo["buttonCaption"] == "" ? "Enter the Promo" : promo["buttonCaption"]}</button><div>
        </div>
      </div>
    ''';
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll("[buttonOnclick]").onClick.listen(onButtonClick);
  }

  void onButtonClick(event) {
    _router.go(promo["enterUrl"],{});
  }

  void onScreenWidthChange(String screenSize){
    createHTML();
  }

  @override
  void detach() {
    _screenWidthChangeDetector.cancel();
  }

  Map promo = {};
  var _screenWidthChangeDetector;
  Element _rootElement;
  PromosService _promosService;
  ScreenDetectorService _scrDet;
  RouteProvider _routeProvider;
  Router _router;
}