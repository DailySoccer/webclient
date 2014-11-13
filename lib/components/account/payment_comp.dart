library payment_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/payment_service.dart';

@Component(
    selector: 'payment',
    templateUrl: 'packages/webclient/components/account/payment_comp.html',
    useShadowDom: false
)
class PaymentComp {

  PaymentComp(this._router, this._paymentService);

  void checkoutPaypal() {
    print("checkOutPaypal");
    _paymentService.expressCheckoutWithPaypal(10);
  }

  PaymentService _paymentService;
  Router _router;
}