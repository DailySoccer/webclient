library simple_prome_viewer_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
   selector: 'simple-promo-viewer',
   useShadowDom: false
)
class SimplePromoViewerComp implements DetachAware {

  @NgOneWay("promo-image-lg")
  String promoImageLg;

  @NgOneWay("promo-image-xs")
  String promoImageXs;

  @NgOneWay("promo-text")
  String promoText;

  @NgOneWay('promo-enter-url')
  String promoEnterUrl;

  @NgOneWay('promo-button-caption')
  String promoButtonCaption;


  SimplePromoViewerComp(this._router, this._routeProvider, this._scrDet, this._rootElement){
    _screenWidthChangeDetector = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
    var promoId = _routeProvider.route.parameters['contestId'];
    createHTML();
  }

  void createHTML() {
    var theHTML = '''
      <div id="simplePromoViewerRoot">
        <img class="img-responsive" src="${_scrDet.isXsScreen ? promoImageXs : promoImageLg}">
        <div class="promo-text>${promoText}</div>
        <div class="autocentered-buttons-wrapper">
          <div class="button-box"><button class="ok-button">${promoButtonCaption == "" ? "Enter the Promo" : promoButtonCaption}</button><div>
        </div>
      </div>
    ''';
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll("[buttonOnclick]").onClick.listen(onButtonClick);
  }

  void onButtonClick(event) {
    _router.go(promoEnterUrl,{});
  }

  void onScreenWidthChange(String screenSize){
    createHTML();
  }

  @override
  void detach() {
    _screenWidthChangeDetector.cancel();
  }

  var _screenWidthChangeDetector;
  Element _rootElement;
  ScreenDetectorService _scrDet;
  RouteProvider _routeProvider;
  Router _router;
}