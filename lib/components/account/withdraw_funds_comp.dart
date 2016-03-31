library withdraw_funds_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'withdraw-funds',
    templateUrl: 'packages/webclient/components/account/withdraw_funds_comp.html',
    useShadowDom: false
)
class WithdrawFundsComp implements ShadowRootAware {
  int selectedValue = 0;

  dynamic get userData => _profileManager.user;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "withdrawfunds");
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  WithdrawFundsComp(this._router, this._profileManager, this._paymentService);

  @override void onShadowRoot(emulatedRoot) {
    if (userData.balance.amount < 20) {
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
    //GameMetrics.logEvent(GameMetrics.REFUND, {"value": selectedValue});
    (querySelector("#withdrawFundsButton") as ButtonElement).disabled = true;
    _paymentService.withdrawFunds(selectedValue)
      .then((_) {
        _router.go("user_profile", {});
      });
  }

  ProfileService _profileManager;
  PaymentService _paymentService;
  Router _router;
}
