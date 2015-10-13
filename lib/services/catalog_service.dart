library catalog_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/models/product.dart';

@Injectable()
class CatalogService {

  HashMap<String, Product> productsMap;
  List<Product> products;

  CatalogService(this._server);

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
}