library shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/product.dart';

@Component(
    selector: 'shop-comp',
    templateUrl: 'packages/webclient/components/account/shop_comp.html',
    useShadowDom: false
)
class ShopComp {

  LoadingService loadingService;

  List<Map> goldProducts;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "shop");
  }
  

  ShopComp(this._flashMessage, this._catalogService) {
    goldProducts = [];

    _catalogService.getCatalog()
      .then((catalog) {
        for (Product info in catalog.where((product) => product.gained.isGold)) {
          Map product = {};
          product["id"]             = info.id;
          product["description"]    = getLocalizedText(info.name);
          product["captionImage"]   = info.imageUrl;
          product["price"]          = info.price.toStringWithCurrency();
          product["quantity"]       = info.gained.amount.toInt().toString();
          product["freeIncrement"]  = info.free.amount.toInt();
          product["isMostPopular"]  = info.mostPopular;
          product["purchasable"]    = true;
          goldProducts.add(product);
        }
    });
  }
  
  void buyItem(String id) {
    _catalogService.buyProduct(id)
      .then( (_) {
        if (window.localStorage.containsKey("add_gold_success")) {

          window.location.assign(window.localStorage["add_gold_success"]);
        }
        else {
          Map product = goldProducts.firstWhere((product) => product["id"] == id, orElse: () => {});
          _flashMessage.addGlobalMessage("Has comprado [${product["description"]}]", 1);
        }
    });
  }

  FlashMessagesService _flashMessage;
  CatalogService _catalogService;
}

