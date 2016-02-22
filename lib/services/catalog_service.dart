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

@Injectable()
class CatalogService {

  HashMap<String, Product> productsMap;
  List<Product> products;

  CatalogService(this._server, this._profileService, this._paymentService);

  Future buyProduct(String productId) {
    if (productsMap.containsKey(productId) && productsMap[productId].price.currencyUnit == Money.EUR) {
      Completer completer = new Completer();
      _paymentService.expressCheckoutWithPaypal(productId: productId);
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
      completer.complete(products);
    }
    else {
      _server.getCatalog()
        .then((jsonMapRoot) {
            if (jsonMapRoot.containsKey("products")) {
              products = [];
              productsMap = {};

              jsonMapRoot["products"].forEach((jsonMap) {
                Product product = new Product.initFromJsonObject(jsonMap);
                products.add(product);
                productsMap[product.id] = product;
              });
            }
            completer.complete(products);
          });
    }

    return completer.future;
  }

  List<Product> specialOffers() {
    return [
        new Product.initFromJsonObject({"productId": "GOLD_SPECIAL_1", "name": "offer_gold_1", "price": "EUR 0.99", "gained": "AUD 15.00",    "free": "AUD 0.00", "imageUrl": "images/icon-BuyGold1.png", "mostPopular": "true"}),
        new Product.initFromJsonObject({"productId": "GOLD_SPECIAL_2", "name": "offer_gold_2", "price": "EUR 1.99", "gained": "AUD 150.00",   "free": "AUD 0.00", "imageUrl": "images/icon-BuyGold2.png", "mostPopular": "true"}),
        new Product.initFromJsonObject({"productId": "GOLD_SPECIAL_3", "name": "offer_gold_3", "price": "EUR 2.99", "gained": "AUD 1500.00",  "free": "AUD 0.00", "imageUrl": "images/icon-BuyGold3.png", "mostPopular": "true"}),
        new Product.initFromJsonObject({"productId": "GOLD_SPECIAL_4", "name": "offer_gold_4", "price": "EUR 3.99", "gained": "AUD 15000.00", "free": "AUD 0.00", "imageUrl": "images/icon-BuyGold4.png", "mostPopular": "true"})
      ];
  }
  
  ServerService _server;
  ProfileService _profileService;
  PaymentService _paymentService;
}