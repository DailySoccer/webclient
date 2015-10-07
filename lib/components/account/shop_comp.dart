library shop_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/loading_service.dart';


@Component(
    selector: 'shop-comp',
    templateUrl: 'packages/webclient/components/account/shop_comp.html',
    useShadowDom: false
)
class ShopComp {
  LoadingService loadingService;
  List<Map> shops = [
     {"name" : "gold",           "image" : "shopItemCoin.png",          "description" : "Compra Monedas y accede a torneos <strong>oficiales</strong>"}
    ,{"name" : "trainer_points", "image" : "shopItemTrainerPoints.png", "description" : "Compra Monedas y accede a <strong>torneos oficiales</strong>"}
    ,{"name" : "energy",         "image" : "shopItemEnergy.png",        "description" : "Recárgate de energía para acceder a torneos de <strong>entrenamiento</strong>"}
  ];
  
  ShopComp(this._router);
  
  void openShop(String name) {
    ModalComp.open(_router, "shop." + name, {});
  }
  
  Router _router;  
}

