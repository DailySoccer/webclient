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

  void paymentWithPaypal(int amount) {
    print("paymentWithPaypal");
    _paymentService.expressCheckoutWithPaypal(amount: amount);
  }

  void checkoutPaypal(String productId) {
    print("checkoutPaypal");
    _paymentService.expressCheckoutWithPaypal(productId: productId);
  }

  PaymentService _paymentService;
  Router _router;
}