library payment_response_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/payment_service.dart';

@Component(
    selector: 'payment-response',
    templateUrl: 'packages/webclient/components/account/payment_response_comp.html',
    useShadowDom: false
)
class PaymentResponseComp implements ShadowRootAware {

  String result;
  String titleText;

  PaymentResponseComp(this._routeProvider, this._router, this._paymentService) {
    result = _routeProvider.route.parameters['result'];
    titleText = result == 'success'? 'correcto' : 'cancelado';
  }

  @override void onShadowRoot(emulatedRoot) {
    querySelector("#paymentResponse .panel-heading button").onClick.listen(closeModal);
  }

  void closeModal(Event e){
    querySelector("#modalRoot").click();
  }
  
  PaymentService _paymentService;
  RouteProvider _routeProvider;
  Router _router;
}