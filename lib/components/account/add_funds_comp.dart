library add_funds_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'add-funds',
    templateUrl: 'packages/webclient/components/account/add_funds_comp.html',
    useShadowDom: false
)
class AddFundsComp implements ShadowRootAware, DetachAware {
  int selectedValue = 25;

  String GetLocalizedText(key) {
    return StringUtils.Translate(key, "addfunds");
  }

  String FormatCurrency(String amount) {
    return StringUtils.FormatCurrency(amount);
  }

  AddFundsComp(this._routeProvider, this._paymentService, this._router) {
    contestId = _routeProvider.route.parameters['contestId'];
  }

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

  void detach() {
    window.localStorage.remove("add_funds_success");
  }

  /* Chequeos de los input */

  void checkCustom(Event e) {
    querySelector("#customEuros").click();
  }

  void onCustomEurosAmountChange(Event e) {
    updateSelectedPrize(e);
    if (selectedValue < 10) {
      selectedValue = 10;
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
  }

  /* Enviar la peticion */

  void addFunds (Event e) {
    GameMetrics.logEvent(GameMetrics.ORDER, {"value": selectedValue});
    (querySelector("#addFundsButton") as ButtonElement).disabled = true;

    // TODO: HACK HACK HACK
    //_paymentService.expressCheckoutWithPaypal(amount: selectedValue);
    _router.go('restricted', {});

  }

  PaymentService _paymentService;
  RouteProvider _routeProvider;
  Router _router;

  String contestId;
}
