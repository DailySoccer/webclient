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
  
  Map storeIdMap = {
    "GOLD_1" : "com.epiceleven.futbolcuatro.gold_1",
    "GOLD_2" : "com.epiceleven.futbolcuatro.gold_2",
    "GOLD_3" : "com.epiceleven.futbolcuatro.gold_3",
    "GOLD_4" : "com.epiceleven.futbolcuatro.gold_4",
    "GOLD_5" : "com.epiceleven.futbolcuatro.gold_5",
    "GOLD_6" : "com.epiceleven.futbolcuatro.gold_6"
  };
  
  void updateInfo(String title, String strPrice) {
    _description = title;
    storePrice = strPrice;
    
    isValid = true;
  }
  
  String get description => (_description != null && _description.isNotEmpty) ? _description : getLocalizedText(name);
  String _description;

  Product.initFromJsonObject(Map jsonMap) {
    id = jsonMap.containsKey("productId") ? jsonMap["productId"] : "";
    storeId = storeIdMap.containsKey(id) ? storeIdMap[id] : "";
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    price = jsonMap.containsKey("price") ? new Money.fromJsonObject(jsonMap["price"]) : new Money.zero();
    storePrice = price.toStringWithCurrency();
    free = jsonMap.containsKey("free") ? new Money.fromJsonObject(jsonMap["free"]) : "";
    gained = jsonMap.containsKey("gained") ? new Money.fromJsonObject(jsonMap["gained"]) : "";
    imageUrl = jsonMap.containsKey("imageUrl") ? jsonMap["imageUrl"] : "";
    mostPopular = jsonMap.containsKey("mostPopular") ? jsonMap["mostPopular"] : false;
  }
}