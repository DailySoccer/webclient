library payment_service;

import 'dart:html';
import 'package:angular/angular.dart';
import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import 'package:webclient/utils/host_server.dart';

@Injectable()
class PaymentService {
  final String PAYPAL_URL = "${HostServer.url}/paypal/init";

  PaymentService(this._profileService, this._server);

  void expressCheckoutWithPaypal(int money) {
    window.location.assign(PAYPAL_URL + "/${_profileService.user.userId}" + "/$money");
  }

  ServerService _server;
  ProfileService _profileService;
}