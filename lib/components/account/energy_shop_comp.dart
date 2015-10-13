library energy_shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/product.dart';


@Component(
    selector: 'energy-shop-comp',
    templateUrl: 'packages/webclient/components/account/energy_shop_comp.html',
    useShadowDom: false
)
class EnergyShopComp {

  List<Map> products;

  String get timeLeft => _userProfile.user.printableEnergyTimeLeft;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "energyshop");
  }

  EnergyShopComp(this._flashMessage, this._userProfile, this._catalogService) {
    products = [];

    _catalogService.getCatalog()
      .then((catalog) {
        for (Product info in catalog.where((product) => product.gained.isEnergy)) {
          Map product = {};
          product["description"] = getLocalizedText(info.name);
          product["captionImage"] = info.imageUrl;
          product["price"] = info.price.toString();
          product["quantity"] = info.gained.amount.toInt().toString();
          product["purchasable"] = true;
          products.add(product);
        }

        products.addAll([
          {"id" : "ENERGY_2", "description" : getLocalizedText("autorefill"), "captionImage" : "images/icon-EnergyLevelUp.png","purchasable": false}
        ]);
    });
  }

  String getShopBanner() => "images/shopBannerSample.jpg";

  void buyEnergy(String id) {
    if (products.firstWhere((product) => product["id"] == id, orElse: () => {})["purchasable"]) {
      _flashMessage.addGlobalMessage("DEBUG: Quieres comprar elemento [ Recarga  Completa ]", 1);
    }
  }

  void CloseModal() {
    ModalComp.close();
  }

  FlashMessagesService _flashMessage;
  ProfileService _userProfile;
  CatalogService _catalogService;
}