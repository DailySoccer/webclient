library gold_shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/product.dart';

@Component(
    selector: 'gold-shop-comp',
    templateUrl: 'packages/webclient/components/account/gold_shop_comp.html',
    useShadowDom: false
)
class GoldShopComp {

  List<Map> products;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "goldshop");
  }

  GoldShopComp(this._flashMessage, this._catalogService) {
    products = [];

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
          products.add(product);
        }
    });
  }

  String getShopBanner() => "images/shopBannerSample.jpg";

  void buyItem(String id) {
    _catalogService.buyProduct(id)
      .then( (_) {
        Map product = products.firstWhere((product) => product["id"] == id, orElse: () => {});
        _flashMessage.addGlobalMessage("Has comprado [${product["description"]}]", 1);
    });
  }

  void CloseModal() {
    ModalComp.close();
  }

  FlashMessagesService _flashMessage;
  CatalogService _catalogService;
}

