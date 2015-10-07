library trainer_points_shop_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/modal_comp.dart';

@Component(
    selector: 'trainer-points-shop-comp',
    templateUrl: 'packages/webclient/components/account/gold_shop_comp.html',
    useShadowDom: false
)
class TrainerPointsShopComp {
  
  List<Map> products = [
    {"id" : "1", "name" : "primero"},
    {"id" : "2", "name" : "segundo"},
    {"id" : "3", "name" : "tercero"}
  ];
  
  TrainerPointsShopComp();
  
  buyItem(String id) {
    modalShow("Trainer Points Shop", "Quieres comprar elemento [" + id + "]");
  }  
}

