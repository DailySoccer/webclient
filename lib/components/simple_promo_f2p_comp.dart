library simple_promo_f2p_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';

@Component(
   selector: 'simple-promo-f2p',
   template: ""
)
class SimplePromoF2PComp {

  SimplePromoF2PComp(this._router, this._rootElement) {
    createHTML();
  }

  void createHTML() {
    var theHTML = '''
      <div id="simplePromoF2PRoot">
        <img class="banner" src="images/promos/PromoF2PSample.jpg" />
      </div>
    ''';
    _rootElement.nativeElement.nodes.clear();
    _rootElement.nativeElement.appendHtml(theHTML);
  }

  void onButtonClick(event) {
    _router.navigate([promo["promoEnterUrl"],{}]);
  }

  void onScreenWidthChange(String screenSize){
    createHTML();
  }

  Map promo = {};
  ElementRef _rootElement;
  Router _router;
}