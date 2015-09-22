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

  String GetLocalizedText(key) {
    return StringUtils.Translate(key, "paymentresponse");
  }


  PaymentResponseComp(this._routeProvider, this._router, this._paymentService) {
    result = _routeProvider.route.parameters['result'];
    titleText = result == 'success' ? GetLocalizedText("resultok") : GetLocalizedText("resultnook");
    descriptionText = result == 'success'
        ? GetLocalizedText("resultokdesc")
        : GetLocalizedText("resultnookdesc");
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