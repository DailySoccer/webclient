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


@Component(
    selector: 'energy-shop-comp',
    templateUrl: 'packages/webclient/components/account/energy_shop_comp.html',
    useShadowDom: false
)
class EnergyShopComp {

  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";

  List<Map> products;
  Map<String, Map> errorMap;

  String get timeLeft => _userProfile.user.printableEnergyTimeLeft;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "energyshop");
  }

  EnergyShopComp(this._flashMessage, this._userProfile, this._catalogService) {
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
    if (products.firstWhere((product) => product["id"] == id, orElse: () => {})["purchasable"]) {
      _catalogService.buyProduct(id)
        .then( (_) {
          _flashMessage.addGlobalMessage("DEBUG: Has comprado [ Recarga  Completa ]", 1);
        })
        .catchError((ServerError error) {
            String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );
            modalShow(errorMap[keyError]["title"],errorMap[keyError]["generic"]);
        });
    }
  }

  void CloseModal() {
    ModalComp.close();
  }

  FlashMessagesService _flashMessage;
  ProfileService _userProfile;
  CatalogService _catalogService;
}