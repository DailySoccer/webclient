library catalog_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/models/product.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';

@Injectable()
class CatalogService {

  HashMap<String, Product> productsMap;
  List<Product> products;

  static CatalogService get Instance => _instance;
  
  CatalogService(this._server, this._profileService, this._paymentService) {
    _instance = this;
  }

  void updateProductInfo(String productId, String title, String price) {
    Logger.root.info("-> UpdateProductInfo: $productId : $title : $price");
    if (productsMap.containsKey(productId)) {
      Product product = productsMap[productId];
      product.updateInfo(title, price);
    }
  }
  
  Future buyProduct(String productId) {
    if (productsMap.containsKey(productId) && productsMap[productId].price.currencyUnit == Money.EUR) {
      Completer completer = new Completer();
      
      // _paymentService.expressCheckoutWithPaypal(productId: productId);
      JsUtils.runJavascript(null, "buyConsumable", [productId], 'epicStore');
      
      return completer.future;
    }
    return _server.buyProduct(productId)
      .then((jsonMap) {
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
      });
  }

  Future buySoccerPlayer(String contestId, String soccerPlayerId) {
    return _server.buySoccerPlayer(contestId, soccerPlayerId)
      .then((jsonMap) {
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }
      });
  }

  Future<List<Product>> getCatalog() {
    var completer = new Completer();

    // Tenemos cargado el catálogo solicitado?
    if (products != null) {
      // JsUtils.runJavascript(null, "refresh", null, 'epicStore');
      completer.complete(products);
    }
    else {
      // Solicitud el catálogo específico de iTunes Connect
      (HostServer.isAndroidPlatform ? _server.getPlayStoreCatalog() : _server.getiTunesCatalog())
        .then((jsonMapRoot) {
            if (jsonMapRoot.containsKey("products")) {
              products = [];
              productsMap = {};

              jsonMapRoot["products"].forEach((jsonMap) {
                Product product = new Product.initFromJsonObject(jsonMap);
                products.add(product);
                productsMap[product.id] = product;
              });

              // Registrar los Productos para el iTunes Connect o Play Store
              List<Map> productsGold = products.where((product) => product.gained.isGold).map((product) {
                Map gProduct = {};
                gProduct["id"]      = product.id;
                gProduct["storeId"] = product.storeId;
                return gProduct;
              }).toList();

              //TODO: descomentar en versión final
              //JsUtils.runJavascript(null, "registerConsumable", [productsGold], 'epicStore');
            }
            completer.complete(products);
          });
    }

    return completer.future;
  }

  ServerService _server;
  ProfileService _profileService;
  PaymentService _paymentService;
  static CatalogService _instance;
}