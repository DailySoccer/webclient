library payment_response_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
    selector: 'payment-response',
    templateUrl: 'payment_response_comp.html'
)
class PaymentResponseComp implements OnInit {

  String result;
  String titleText;
  String descriptionText;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "paymentresponse");
  }

  PaymentResponseComp(this._routeParams, this._router, this._paymentService) {
    result = _routeParams.get('result');
    titleText = result == 'success' ? getLocalizedText("resultok") : getLocalizedText("resultnook");
    descriptionText = result == 'success'
        ? getLocalizedText("resultokdesc")
        : getLocalizedText("resultnookdesc");
    //if (result == 'success') GameMetrics.logEvent(GameMetrics.GOLD_BOUGHT);
  }

  @override void ngOnInit() {
    querySelector("#paymentResponse .panel-heading button").onClick.listen(closeModal);
  }

  void closeModal(Event e) {
    querySelector("#modalRoot").click();
  }

  final PaymentService _paymentService;
  final RouteParams _routeParams;
  final Router _router;
}