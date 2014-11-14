library payment_response_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/payment_service.dart';

@Component(
    selector: 'payment-response',
    templateUrl: 'packages/webclient/components/account/payment_response_comp.html',
    useShadowDom: false
)
class PaymentResponseComp {

  PaymentResponseComp(this._router, this._paymentService);

  PaymentService _paymentService;
  Router _router;
}