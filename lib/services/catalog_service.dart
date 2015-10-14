library catalog_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/models/product.dart';
import 'package:webclient/services/profile_service.dart';

@Injectable()
class CatalogService {

  HashMap<String, Product> productsMap;
  List<Product> products;

  CatalogService(this._server, this._profileService);

  Future buyProduct(String productId) {
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

  ServerService _server;
  ProfileService _profileService;
}