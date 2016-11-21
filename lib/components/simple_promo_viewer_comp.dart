library simple_prome_viewer_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/promos_service.dart';

@Component(
   selector: 'simple-promo-viewer',
   template: ""
)
class SimplePromoViewerComp implements OnDestroy {

  SimplePromoViewerComp(this._router, this._routeParams, this._scrDet, this._rootElement, this._promosService){
    var promoId = _routeParams.get('promoId');
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
    _rootElement.nativeElement.nodes.clear();
    _rootElement.nativeElement.appendHtml(theHTML);
    _rootElement.nativeElement.querySelectorAll(".button-ok").onClick.listen(onButtonClick);
  }

  String getPromoImg(){
    ImageElement image = new ImageElement(src: promo["imageXs"]);
    if (_scrDet.isXsScreen) {
        return '<img class="banner" src="${promo["imageXs"]}" onerror="this.parentNode.removeChild(this)">';
    }
    else {
        return '<img class="banner" src="${promo["imageDesktop"]}" onerror="this.parentNode.removeChild(this)">';
    }
    return '';
  }

  void onButtonClick(event) {
    _router.navigate([promo["promoEnterUrl"],{}]);
  }

  void onScreenWidthChange(String screenSize){
    createHTML();
  }

  @override void ngOnDestroy() {
    _screenWidthChangeDetector.cancel();
  }

  Map promo = {};
  var _screenWidthChangeDetector;
  ElementRef _rootElement;
  PromosService _promosService;
  ScreenDetectorService _scrDet;
  RouteParams _routeParams;
  Router _router;
}