library add_funds_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/payment_service.dart';


@Component(
    selector: 'add-funds',
    templateUrl: 'packages/webclient/components/account/add_funds_comp.html',
    useShadowDom: false
)
class AddFundsComp implements ShadowRootAware {
  int selectedValue = 25;

  AddFundsComp(this._paymentService);

  @override void onShadowRoot(emulatedRoot) {
    querySelector("#firstOffer").onChange.listen(updateSelectedPrize);
    querySelector("#secondOffer").onChange.listen(updateSelectedPrize);
    querySelector("#thirdOffer").onChange.listen(updateSelectedPrize);
    querySelector("#customEuros").onChange.listen(updateSelectedPrize);
    querySelector("#customEurosAmount").onChange.listen(onCustomEurosAmountChange);
    querySelector("#customEurosAmount").onKeyUp.listen(updateSelectedPrize);
    querySelector("#customEurosAmount").onFocus.listen(checkCustom);

    querySelector("#addFundsButton").onClick.listen(addFunds);
  }

  /* Chequeos de los input */

  void checkCustom(Event e){
    querySelector("#customEuros").click();
  }

  void onCustomEurosAmountChange(Event e) {
    updateSelectedPrize(e);
    if (selectedValue < 10) {
      selectedValue = 10;
      querySelector("#selectedAmountInfo").text = "$selectedValue €";
    }
    (querySelector("#customEurosAmount") as InputElement).value = "$selectedValue";
  }

  void updateSelectedPrize(Event e) {
    Element customEurosCheckBox = querySelector("#customEuros");
    InputElement input = (e.target != customEurosCheckBox? e.target : querySelector("#customEurosAmount")) as InputElement;

    try {
      selectedValue = input.value == ""? 0 : int.parse(input.value).abs();
    } on FormatException {
      selectedValue = 0;
    }
    querySelector("#selectedAmountInfo").text = "$selectedValue €";
  }

  /* Enviar la peticion */

  void addFunds (Event e) {
    print("i want to add $selectedValue €");
    _paymentService.expressCheckoutWithPaypal(amount: selectedValue);
  }

  PaymentService _paymentService;
}
