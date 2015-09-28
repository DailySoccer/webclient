library simple_promo_f2p_comp;

import 'dart:html';
import 'package:angular/angular.dart';

@Component(
   selector: 'simple-promo-f2p',
   useShadowDom: false
)
class SimplePromoF2PComp {

  SimplePromoF2PComp(this._router, this._rootElement) {
    createHTML();
  }

  void createHTML() {
    var theHTML = '''
      <div id="simplePromoF2PRoot">
        <img class="banner" src="images/promos/PromoF2PSample.jpg"></img>
      </div>
    ''';
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
  }

  void onButtonClick(event) {
    _router.go(promo["promoEnterUrl"],{});
  }

  void onScreenWidthChange(String screenSize){
    createHTML();
  }

  Map promo = {};
  Element _rootElement;
  Router _router;
}