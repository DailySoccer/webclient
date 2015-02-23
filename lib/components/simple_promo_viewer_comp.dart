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
        ${getPromoImg()}
        <div class="${promo['name'] == '404' ? 'promo-text-centered' : 'promo-text'}">${promo["text"]}</div>
        <div class="button-box">
            <button class="button-ok">${promo["buttonCaption"] == "" ? "Reserve your Spot" : promo["buttonCaption"]}</button>
        </div>
      </div>
    ''';
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll(".button-ok").onClick.listen(onButtonClick);
  }

  String getPromoImg(){
    ImageElement image = new ImageElement(src: promo["imageXs"]);
    if (_scrDet.isXsScreen) {
        return '<img class="banner" src="${promo["imageXs"]}" onerror="this.parentNode.removeChild(this)">';
    }
    else {
        return '<img class="banner" src="${promo["imageLg"]}" onerror="this.parentNode.removeChild(this)">';
    }
    return '';
  }

  void onButtonClick(event) {
    _router.go(promo["promoEnterUrl"],{});
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