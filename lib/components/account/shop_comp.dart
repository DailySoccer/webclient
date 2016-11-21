library shop_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

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
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/game_info.dart';
//import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/utils/host_server.dart';
//import 'package:logging/logging.dart';

@Component(
    selector: 'shop-comp',
    templateUrl: 'shop_comp.html'
)
class ShopComp implements OnDestroy {
  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";

  LoadingService loadingService;

  List<Map> goldProducts;
  List<Map> energyProducts;

  Map<String, Map> errorMap;

  DateTime t = new DateTime.now();

  String get timeLeft => _profileService.user.printableEnergyTimeLeft;

  String getLocalizedText(key, {group: "shop", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }

  ShopComp(this._loadingService, this._flashMessage, this._profileService, this._catalogService, this._tutorialService, this._paymentService, this._appStateService, this._router) {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection(getLocalizedText("name"));
    _appStateService.appTopBarState.activeState.onLeftColumn = AppTopBarState.GOBACK;
    _appStateService.appTabBarState.show = false;
    _appStateService.appSecondaryTabBarState.tabList = [];
    
    _loadingService.isLoading = true;
    
    goldProducts = [];
    energyProducts = [];
    
    errorMap = {
      "_ERROR_DEFAULT_": {
          "title"   : getLocalizedText("errordefaulttitle"),
          "generic" : getLocalizedText("errordefaultgeneric")
      }
    };

    // Si no viene con una solicitud de "buy", quitamos las cookies
    if (!window.location.toString().contains("buy")) {
      clearCookies();
    }

    if (HostServer.isDevice) {
      _catalogService.getCatalog()
        .then((catalog) {
          for (Product info in catalog.where((e) => e.gained.isEnergy)) {
            Map eProduct = {};
            eProduct["info"]         = info;
            eProduct["id"]           = info.id;
            eProduct["description"]  = info.description.toLowerCase().replaceAll('(futbol cuatro)', '');
            eProduct["captionImage"] = info.imageUrl;
            eProduct["price"]        = info.price.toString();
            eProduct["quantity"]     = info.gained.amount.toInt().toString();
            eProduct["purchasable"]  = true;
            energyProducts.add(eProduct);
          }
          
          // Esperar a que iTunes Connect actualice correctamente los productos de GOLD
          return _paymentService.waitingForReady();
        })
        .then((_) {
          for (Product info in _catalogService.products.where((g) => g.gained.isGold && g.isValid)) {
            Map gProduct = {};
            gProduct["id"]             = info.id;
            gProduct["storeId"]        = info.storeId;
            gProduct["description"]    = info.description.toLowerCase().replaceAll('(futbol cuatro)', '');
            gProduct["captionImage"]   = info.imageUrl;
            gProduct["price"]          = info.storePrice; // info.price.toStringWithCurrency();
            // Sumamos la cantidad + el incremento gratuito
            gProduct["quantity"]       = (info.gained.amount.toInt() + info.free.amount.toInt()).toString();
            gProduct["freeIncrement"]  = 0;//info.free.amount.toInt();
            gProduct["isMostPopular"]  = info.mostPopular;
            gProduct["purchasable"]    = true;
            goldProducts.add(gProduct);
          }
          _loadingService.isLoading = false;
        });
    } else {
      _catalogService.getCatalog()
        .then((catalog) {
          for (Product info in _catalogService.products.where((g) => g.gained.isGold)) {
            Map gProduct = {};
            gProduct["id"]             = info.id;
            gProduct["storeId"]        = info.storeId;
            gProduct["description"]    = info.description.toLowerCase().replaceAll('(futbol cuatro)', '');
            gProduct["captionImage"]   = info.imageUrl;
            gProduct["price"]          = info.storePrice; // info.price.toStringWithCurrency();
            // Sumamos la cantidad + el incremento gratuito
            gProduct["quantity"]       = (info.gained.amount.toInt() + info.free.amount.toInt()).toString();
            gProduct["freeIncrement"]  = 0;//info.free.amount.toInt();
            gProduct["isMostPopular"]  = info.mostPopular;
            gProduct["purchasable"]    = true;
            goldProducts.add(gProduct);
          }
        _loadingService.isLoading = false;
        });
    }
    GameMetrics.screenVisitEvent(GameMetrics.SCREEN_SHOP);
    _tutorialService.triggerEnter("shop", component: this, activateIfNeeded: false);
  }
  
  void GoBack() {
    _router.navigate(["lobby", {}]);
  }

  void buyGold(String id) {
    Map product = goldProducts.firstWhere((product) => product["id"] == id, orElse: () => {});
    /*
    GameMetrics.logEvent(GameMetrics.REQUEST_BUY_GOLD, {'id': product["id"],
                                                        'price': product["price"],
                                                        'quantity': product["quantity"], 
                                                        'date' : DateTimeService.formatDateTimeLong(DateTimeService.now)});
*/
    _catalogService.buyProduct(id)
      .then( (_) {
        if (GameInfo.contains("add_gold_success")) {
          window.location.assign(GameInfo.get("add_gold_success"));
        }
        else {
          Map product = goldProducts.firstWhere((product) => product["id"] == id, orElse: () => {});
          _flashMessage.addGlobalMessage("Has comprado [${product["description"]}]", 1);
        }
    })
    .catchError((ServerError error) {
        String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );
        modalShow(errorMap[keyError]["title"],errorMap[keyError]["generic"]);
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

            if (GameInfo.contains("add_energy_success")) {
              ModalComp.close();
              window.location.assign(GameInfo.get("add_energy_success"));
            }
            
            //GameMetrics.logEvent(GameMetrics.ENERGY_BOUGHT, {'quantity':(product["id"] == "ENERGY_ALL")? 10 : 1});
            
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

   @override void ngOnDestroy() {
     clearCookies();
  }
   
  void clearCookies() {
    GameInfo.remove("add_funds_success");
    GameInfo.remove("add_gold_success");
    GameInfo.remove("add_energy_success");
  }

  bool get canBuyEnergy => _profileService.user.energyBalance.amount < User.MAX_ENERGY;

  Router _router;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  CatalogService _catalogService;
  TutorialService _tutorialService;
  PaymentService _paymentService;
  AppStateService _appStateService;

  LoadingService _loadingService;
}

