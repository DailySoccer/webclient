library payment_response_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'payment-response',
    templateUrl: 'packages/webclient/components/account/payment_response_comp.html',
    useShadowDom: false
)
class PaymentResponseComp implements ShadowRootAware {

  String result;
  String titleText;
  String descriptionText;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "paymentresponse");
  }


  PaymentResponseComp(this._routeProvider, this._router, this._paymentService) {
    result = _routeProvider.route.parameters['result'];
    titleText = result == 'success' ? getLocalizedText("resultok") : getLocalizedText("resultnook");
    descriptionText = result == 'success'
        ? getLocalizedText("resultokdesc")
        : getLocalizedText("resultnookdesc");
  }

  @override void onShadowRoot(emulatedRoot) {
    querySelector("#paymentResponse .panel-heading button").onClick.listen(closeModal);
  }

  void closeModal(Event e) {
    querySelector("#modalRoot").click();
  }

  PaymentService _paymentService;
  RouteProvider _routeProvider;
  Router _router;
}