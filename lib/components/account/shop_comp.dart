library shop_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'shop-comp',
    templateUrl: 'packages/webclient/components/account/shop_comp.html',
    useShadowDom: false
)
class ShopComp {
  
  Map shopData;
  
  ShopComp(this._scrDet) {
    
  }
  
  
  ScreenDetectorService _scrDet;
}

