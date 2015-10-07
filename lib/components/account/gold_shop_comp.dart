library gold_shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'gold-shop-comp',
    templateUrl: 'packages/webclient/components/account/gold_shop_comp.html',
    useShadowDom: false
)
class GoldShopComp {
  
  List<Map> products;
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "goldshop");
  }
  
  GoldShopComp() {
    products = [
         {"id" : "1", "description" : getLocalizedText('product1'), "captionImage" : "icon-BuyGold1.png", "price": "2,60€"  , "quantity" : 30,    "freeIncrement" : 0,  "isMostPopular" : false}
        ,{"id" : "2", "description" : getLocalizedText('product2'), "captionImage" : "icon-BuyGold2.png", "price": "4,20€"  , "quantity" : 55,    "freeIncrement" : 5,  "isMostPopular" : true}
        ,{"id" : "3", "description" : getLocalizedText('product3'), "captionImage" : "icon-BuyGold3.png", "price": "7,60€"  , "quantity" : 115,   "freeIncrement" : 15, "isMostPopular" : false}
        ,{"id" : "4", "description" : getLocalizedText('product4'), "captionImage" : "icon-BuyGold4.png", "price": "12,90€" , "quantity" : 250,   "freeIncrement" : 50, "isMostPopular" : false}
        ,{"id" : "5", "description" : getLocalizedText('product5'), "captionImage" : "icon-BuyGold5.png", "price": "32€"    , "quantity" : 900,   "freeIncrement" : 400,"isMostPopular" : false}
        ,{"id" : "6", "description" : getLocalizedText('product6'), "captionImage" : "icon-BuyGold6.png", "price": "99,95€" , "quantity" : 1650,  "freeIncrement" : 650,"isMostPopular" : false}
      ];
  }
  
  String getShopBanner() {
    return "images/shopBannerSample.jpg";
  }
  
  buyItem(String id) {
    modalShow("Gold Shop", "Quieres comprar elemento [" + id + "]");
  }  
}

