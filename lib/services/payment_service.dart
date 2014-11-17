library payment_service;

import 'dart:html';
import 'package:angular/angular.dart';
import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import 'package:webclient/utils/host_server.dart';

@Injectable()
class PaymentService {
  final String PAYPAL_APPROVAL_URL = "${HostServer.url}/paypal/approval_payment";

  PaymentService(this._profileService, this._server);

  void expressCheckoutWithPaypal(String productId) {
    window.location.assign(PAYPAL_APPROVAL_URL + "/${_profileService.user.userId}" + "/$productId");
  }

  ServerService _server;
  ProfileService _profileService;
}