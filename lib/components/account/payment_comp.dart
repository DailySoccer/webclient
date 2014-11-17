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

  void checkoutPaypal(String productId) {
    print("checkOutPaypal");
    _paymentService.expressCheckoutWithPaypal(productId);
  }

  PaymentService _paymentService;
  Router _router;
}