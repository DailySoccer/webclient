library payment_service;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import 'package:webclient/utils/host_server.dart';

@Injectable()
class PaymentService {
  final String PAYPAL_APPROVAL_PAYMENT_URL = "${HostServer.url}/paypal/approval_payment";
  final String PAYPAL_APPROVAL_BUY_URL = "${HostServer.url}/paypal/approval_buy";

  PaymentService(this._profileService, this._server);

  void expressCheckoutWithPaypal({String productId, int amount}) {
    if (amount != null) {
      window.location.assign(PAYPAL_APPROVAL_PAYMENT_URL + "/${_profileService.user.userId}" + "/$amount");
    }
    else {
      window.location.assign(PAYPAL_APPROVAL_BUY_URL + "/${_profileService.user.userId}" + "/$productId");
    }
  }

  Future<Map> withdrawFunds(int amount) {
    return _server.withdrawFunds(amount);
  }

  ServerService _server;
  ProfileService _profileService;
}