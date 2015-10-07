library gold_shop_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/modal_comp.dart';

@Component(
    selector: 'gold-shop-comp',
    templateUrl: 'packages/webclient/components/account/gold_shop_comp.html',
    useShadowDom: false
)
class GoldShopComp {
  
  List<Map> products = [
    {"id" : "1", "name" : "primero"},
    {"id" : "2", "name" : "segundo"},
    {"id" : "3", "name" : "tercero"}
  ];
  
  GoldShopComp();
  
  buyItem(String id) {
    modalShow("Gold Shop", "Quieres comprar elemento [" + id + "]");
  }  
}

