library payment_response_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/payment_service.dart';

@Component(
    selector: 'payment-response',
    templateUrl: 'packages/webclient/components/account/payment_response_comp.html',
    useShadowDom: false
)
class PaymentResponseComp {

  String result;

  PaymentResponseComp(this._routeProvider, this._router, this._paymentService) {
    result = _routeProvider.route.parameters['result'];
  }

  PaymentService _paymentService;
  RouteProvider _routeProvider;
  Router _router;
}