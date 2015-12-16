library shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/product.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/user.dart';

@Component(
    selector: 'shop-comp',
    templateUrl: 'packages/webclient/components/account/shop_comp.html',
    useShadowDom: false
)
class ShopComp implements DetachAware{

  LoadingService loadingService;

  List<Map> goldProducts;
  List<Map> energyProducts;

  Map<String, Map> errorMap;

  DateTime t = new DateTime.now();

  String get timeLeft => _profileService.user.printableEnergyTimeLeft;

  String getLocalizedText(key, {group: "shop", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }

  ShopComp(this._flashMessage, this._profileService, this._catalogService, this._tutorialService) {
    goldProducts = [];
    energyProducts = [];

    _catalogService.getCatalog()
      .then((catalog) {
        for (Product info in catalog.where((g) => g.gained.isGold)) {
          Map gProduct = {};
          gProduct["id"]             = info.id;
          gProduct["description"]    = getLocalizedText(info.name);
          gProduct["captionImage"]   = info.imageUrl;
          gProduct["price"]          = info.price.toStringWithCurrency();
          gProduct["quantity"]       = info.gained.amount.toInt().toString();
          gProduct["freeIncrement"]  = info.free.amount.toInt();
          gProduct["isMostPopular"]  = info.mostPopular;
          gProduct["purchasable"]    = true;
          goldProducts.add(gProduct);
        }

        for (Product info in catalog.where((e) => e.gained.isEnergy)) {
          Map eProduct = {};
          eProduct["info"]         = info;
          eProduct["id"]           = info.id;
          eProduct["description"]  = getLocalizedText(info.name);
          eProduct["captionImage"] = info.imageUrl ;
          eProduct["price"]        = info.price.toString();
          eProduct["quantity"]     = info.gained.amount.toInt().toString();
          eProduct["purchasable"]  = true;
          energyProducts.add(eProduct);
        }
    });

    _tutorialService.triggerEnter("shop", component: this, activateIfNeeded: false);
  }

  void buyGold(String id) {
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

  void buyEnergy(String id) {
    Map product = energyProducts.firstWhere((product) => product["id"] == id, orElse: () => {});
    if (product["purchasable"]) {
      // Tenemos el dinero suficiente para comprarlo?
      Money price = product["info"].price;
      if (_profileService.user.hasMoney(price)) {
        _catalogService.buyProduct(id)
          .then( (_) {
            _flashMessage.addGlobalMessage( (product["id"] == "ENERGY_ALL") ? "Has comprado [Recarga  Completa]" : "Has comprado [Recarga +1]", 1);

            if (window.localStorage.containsKey("add_energy_success")) {
              ModalComp.close();
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
       ""
       , getNotEnoughGoldContent(goldNeeded)
       , onOk: getLocalizedText("buy-gold-button")
       , closeButton:true
       , aditionalClass: "noGold"
     )
     /*.then((_) {
       _router.go('shop.gold', {});
     })*/;
   }

   String getNotEnoughGoldContent(Money goldNeeded) {
     return '''
            <div class="content-wrapper">
              <h1 class="alert-content-title">${getLocalizedText("alert-no-gold-message")}</h1>
              <div class="gold-needed-icon-wrapper">
                <img class="gold-image" src="images/EpicCoinModales.png">
                <span class="not-enough-resources-count">${goldNeeded}</span>
              </div>
              <h2 class="alert-content-subtitle">${getLocalizedText('alert-user-gold-message', substitutions:{'MONEY': _profileService.user.goldBalance})}<span class="gold-icon-tiny"></span></h2>
            </div>
          ''';
   }

   void detach() {
     window.localStorage.remove("add_funds_success");
     window.localStorage.remove("add_gold_success");
     window.localStorage.remove("add_energy_success");
   }
   
  bool get canBuyEnergy => _profileService.user.energyBalance.amount < User.MAX_ENERGY;

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  CatalogService _catalogService;
  TutorialService _tutorialService;
}

