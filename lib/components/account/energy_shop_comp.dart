library energy_shop_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';


@Component(
    selector: 'energy-shop-comp',
    templateUrl: 'packages/webclient/components/account/energy_shop_comp.html',
    useShadowDom: false
)
class EnergyShopComp {
  
  List<Map> products;
  
  String get timeLeft => _userProfile.user.printableEnergyTimeLeft;
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "energyshop");
  }
  
  EnergyShopComp(this._flashMessage, this._userProfile) {
    products = [ 
       {"id" : "e1", "description" : getLocalizedText("maxrefill"),  "captionImage" : "icon-FullEnergy.png",   "purchasable": true, "price": "30€"}
      ,{"id" : "e2", "description" : getLocalizedText("autorefill"), "captionImage" : "Icon-EnergyLevelUp.png","purchasable": false}
    ];
  }
  
  String getShopBanner() {
    return "images/shopBannerSample.jpg";
  }
  
  void buyEnergy(String id) {
    if (id == "e1" ) {
      _flashMessage.addGlobalMessage("DEBUG: Quieres comprar elemento [ Recarga  Completa ]", 1);
    }
  }
  
  void CloseModal() {
    ModalComp.close();
  }
  
  FlashMessagesService _flashMessage;
  ProfileService _userProfile;
  
}