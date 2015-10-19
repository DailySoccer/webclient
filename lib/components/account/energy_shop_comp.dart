library energy_shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/product.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:html';
import 'package:webclient/models/money.dart';


@Component(
    selector: 'energy-shop-comp',
    templateUrl: 'packages/webclient/components/account/energy_shop_comp.html',
    useShadowDom: false
)
class EnergyShopComp {

  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";

  List<Map> products;
  Map<String, Map> errorMap;

  String get timeLeft => _profileService.user.printableEnergyTimeLeft;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "energyshop", substitutions);
  }

  EnergyShopComp(this._flashMessage, this._profileService, this._catalogService, this._router) {
    products = [];

    errorMap = {
      // TODO: Avisamos al usuario de que no dispone del dinero suficiente pero, cuando se integre la branch "paypal-ui", se le redirigirá a "añadir fondos"
      ERROR_USER_BALANCE_NEGATIVE: {
        "title"   : getLocalizedText("erroruserbalancenegativetitle"),
        "generic" : getLocalizedText("erroruserbalancenegativegeneric")
      },
      "_ERROR_DEFAULT_": {
          "title"   : getLocalizedText("errordefaulttitle"),
          "generic" : getLocalizedText("errordefaultgeneric")
      }
    };

    _catalogService.getCatalog()
      .then((catalog) {
        for (Product info in catalog.where((product) => product.gained.isEnergy)) {
          Map product = {};
          product["info"]         = info;
          product["id"]           = info.id;
          product["description"]  = getLocalizedText(info.name);
          product["captionImage"] = info.imageUrl;
          product["price"]        = info.price.toString();
          product["quantity"]     = info.gained.amount.toInt().toString();
          product["purchasable"]  = true;
          products.add(product);
        }

        products.addAll([
          {"id" : "AUTO_REFILL", "description" : getLocalizedText("autorefill"), "captionImage" : "images/icon-EnergyLevelUp.png","purchasable": false}
        ]);
    });
  }

  String getShopBanner() => "images/shopBannerSample.jpg";

  void buyEnergy(String id) {
    Map product = products.firstWhere((product) => product["id"] == id, orElse: () => {});
    if (product["purchasable"]) {
      // Tenemos el dinero suficiente para comprarlo?
      Money price = product["info"].price;
      if (_profileService.user.hasMoney(price)) {
        _catalogService.buyProduct(id)
          .then( (_) {
            _flashMessage.addGlobalMessage("Has comprado [ Recarga  Completa ]", 1);

            if (window.localStorage.containsKey("add_energy_success")) {
              CloseModal();
              window.location.assign(window.localStorage["add_energy_success"]);
            }
          })
          .catchError((ServerError error) {
              String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );
              modalShow(errorMap[keyError]["title"],errorMap[keyError]["generic"]);
          });
      }
      else {
        alertNotEnoughResources(price);
      }
    }
  }

  void alertNotEnoughResources(Money goldNeeded) {
    modalShow(
      "",
      getNotEnoughGoldContent(goldNeeded),
      onOk: getLocalizedText("buy-gold-button"),
      closeButton:true
    )
    .then((_) {
      _router.go('shop.gold', {});
    });
  }

  String getNotEnoughGoldContent(Money goldNeeded) {
    return '''
    <div class="content-wrapper">
      <img class="main-image" src="images/iconNoGold.png">
      <span class="not-enough-resources-count">${goldNeeded}</span>
      <p class="content-text">
        <strong>${getLocalizedText("alert-no-gold-message")}</strong>
        <br>
        ${getLocalizedText('alert-user-gold-message', substitutions: {'MONEY': _profileService.user.goldBalance})}
        <img src="images/icon-coin-xs.png">
      </p>
    </div>
    ''';
  }

  void CloseModal() {
    ModalComp.close();
  }

  Router _router;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  CatalogService _catalogService;
}