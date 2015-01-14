library withdraw_funds_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';


@Component(
    selector: 'withdraw-funds',
    templateUrl: 'packages/webclient/components/account/withdraw_funds_comp.html',
    useShadowDom: false
)
class WithdrawFundsComp implements ShadowRootAware {
  int selectedValue = 0;

  dynamic get userData => _profileManager.user;
  
  WithdrawFundsComp(this._profileManager);

  @override void onShadowRoot(emulatedRoot) {
    if (userData.balance < 20) {
      (querySelector("#withdrawFundsButton") as ButtonElement).disabled = true;
      (querySelector("#customEurosAmount") as NumberInputElement).valueAsNumber = 0;
      (querySelector("#customEurosAmount") as NumberInputElement).disabled = true;
      selectedValue = 0;
    } else {
      querySelector("#customEurosAmount").onChange.listen(onCustomEurosAmountChange);
      querySelector("#customEurosAmount").onKeyUp.listen(updateSelectedPrize);

      querySelector("#withdrawFundsButton").onClick.listen(withdrawFunds);
      onCustomEurosAmountChange(null);
    }
  }

  /* Chequeos de los input */

  void onCustomEurosAmountChange(Event e) {
    updateSelectedPrize(e);
    if (selectedValue < 20) {
      selectedValue = 20;
    }
    (querySelector("#customEurosAmount") as NumberInputElement).valueAsNumber = selectedValue;
  }

  void updateSelectedPrize(Event e) {
    NumberInputElement input = querySelector("#customEurosAmount") as NumberInputElement;
    
    try {
      selectedValue = input.valueAsNumber.isNaN? 0 : input.valueAsNumber.toInt().abs();
    } on Exception {
      selectedValue = 0;
    }
    if(selectedValue > userData.balance.toInt()){
      selectedValue = userData.balance.toInt();
    }
  }

  /* Enviar la peticion */

  void withdrawFunds (Event e) {
    print("i want to withdraw $selectedValue €");
    (querySelector("#withdrawFundsButton") as ButtonElement).disabled = true;
  }

  ProfileService _profileManager;
}
