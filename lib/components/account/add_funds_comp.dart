library add_funds_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_info.dart';


@Component(
    selector: 'add-funds',
    templateUrl: 'add_funds_comp.html'
)
class AddFundsComp implements OnInit, OnDestroy {
  int selectedValue = 25;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "addfunds");
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  AddFundsComp(RouteParams params, this._paymentService, this._router) {
    contestId = params.get('contestId');
  }

  @override void ngOnInit() {
    querySelector("#firstOffer").onChange.listen(updateSelectedPrize);
    querySelector("#secondOffer").onChange.listen(updateSelectedPrize);
    querySelector("#thirdOffer").onChange.listen(updateSelectedPrize);
    querySelector("#customEuros").onChange.listen(updateSelectedPrize);
    querySelector("#customEurosAmount").onChange.listen(onCustomEurosAmountChange);
    querySelector("#customEurosAmount").onKeyUp.listen(updateSelectedPrize);
    querySelector("#customEurosAmount").onFocus.listen(checkCustom);

    querySelector("#addFundsButton").onClick.listen(addFunds);
  }

  @override void ngOnDestroy() {
    GameInfo.remove("add_funds_success");
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
    //GameMetrics.logEvent(GameMetrics.ORDER, {"value": selectedValue});
    (querySelector("#addFundsButton") as ButtonElement).disabled = true;

    // TODO: HACK HACK HACK
    //_paymentService.expressCheckoutWithPaypal(amount: selectedValue);
    _router.navigate(['restricted', {}]);

  }

  final PaymentService _paymentService;
  final Router _router;

  String contestId;
}
