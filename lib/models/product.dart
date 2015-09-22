library product;

import 'package:webclient/models/money.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:logging/logging.dart';

class Product {
  String id;
  String storeId;
  String name;
  Money price;
  String storePrice;
  Money gained;
  Money free;
  String imageUrl;
  bool mostPopular;
  
  bool isValid = false;

  String getLocalizedText(key, {group: "catalog", substitutions: null}) {
    return StringUtils.translate(key, group, substitutions);
  }
  
  void updateInfo(String title, String strPrice) {
    _description = title;
    storePrice = strPrice;
    
    isValid = true;
  }
  
  String get description => (_description != null && _description.isNotEmpty) ? _description : getLocalizedText(name);
  String _description;

  Product.initFromJsonObject(Map jsonMap) {
    id = jsonMap.containsKey("productId") ? jsonMap["productId"] : "";
    storeId = jsonMap.containsKey("storeId") ? jsonMap["storeId"] : "";
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    price = jsonMap.containsKey("price") ? new Money.fromJsonObject(jsonMap["price"]) : new Money.zero();
    storePrice = price.toStringWithCurrency();
    free = jsonMap.containsKey("free") ? new Money.fromJsonObject(jsonMap["free"]) : "";
    gained = jsonMap.containsKey("gained") ? new Money.fromJsonObject(jsonMap["gained"]) : "";
    imageUrl = jsonMap.containsKey("imageUrl") ? jsonMap["imageUrl"] : "";
    mostPopular = jsonMap.containsKey("mostPopular") ? jsonMap["mostPopular"] : false;
  }
}