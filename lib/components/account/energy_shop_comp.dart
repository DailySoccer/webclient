library energy_shop_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/modal_comp.dart';

@Component(
    selector: 'energy-shop-comp',
    templateUrl: 'packages/webclient/components/account/energy_shop_comp.html',
    useShadowDom: false
)
class EnergyShopComp {
  
  List<Map> products = [
    {"id" : "1", "name" : "primero"},
    {"id" : "2", "name" : "segundo"},
    {"id" : "3", "name" : "tercero"}
  ];
  
  EnergyShopComp();
  
  buyItem(String id) {
    modalShow("Energy Shop", "Quieres comprar elemento [" + id + "]");
  }  
}

