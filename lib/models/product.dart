library product;

import 'package:webclient/models/money.dart';

class Product {
  String id;
  String name;
  Money price;
  Money gained;
  Money free;
  String imageUrl;
  bool mostPopular;

  Product.initFromJsonObject(Map jsonMap) {
    id = jsonMap.containsKey("productId") ? jsonMap["productId"] : "";
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    price = jsonMap.containsKey("price") ? new Money.fromJsonObject(jsonMap["price"]) : "";
    free = jsonMap.containsKey("free") ? new Money.fromJsonObject(jsonMap["free"]) : "";
    gained = jsonMap.containsKey("gained") ? new Money.fromJsonObject(jsonMap["gained"]) : "";
    imageUrl = jsonMap.containsKey("imageUrl") ? jsonMap["imageUrl"] : "";
    mostPopular = jsonMap.containsKey("mostPopular") ? jsonMap["mostPopular"] : false;
  }
}