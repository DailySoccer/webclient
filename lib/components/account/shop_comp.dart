library shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'shop-comp',
    templateUrl: 'packages/webclient/components/account/shop_comp.html',
    useShadowDom: false
)
class ShopComp {

  LoadingService loadingService;

  List<Map> shops;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "shop");
  }

  ShopComp(this._router) {
    shops = [
        {"name" : "gold",           "image" : "images/shopItemCoin.png",          "description" : getLocalizedText('goldshopdescription')}
       // ,{"name" : "trainer_points", "image" : "images/shopItemTrainerPoints.png", "description" : getLocalizedText('trainerpointsshopdescription')}
       ,{"name" : "energy",         "image" : "images/shopItemEnergy.png",        "description" : getLocalizedText('energyshopdescription')}
    ];
  }

  void openShop(String name) {
    if (name != 'trainer_points') {
      ModalComp.open(_router, "shop." + name, {});
    }
  }

  Router _router;
}

