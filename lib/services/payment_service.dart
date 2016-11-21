library payment_service;

import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import "package:webclient/services/server_service.dart";
import "package:webclient/services/profile_service.dart";
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/game_info.dart';

@Injectable()
class PaymentService {
  final String PAYPAL_APPROVAL_PAYMENT_URL = "${HostServer.url}/paypal/approval_payment";
  final String PAYPAL_APPROVAL_BUY_URL = "${HostServer.url}/paypal/approval_buy";

  PaymentService(this._profileService, this._server) {
    _instance = this;
  }

  static PaymentService get Instance => _instance;
  
  bool isReady = false;
  
  Future waitingForReady() {
    var completer = new Completer();
    
    new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
          if (isReady) {
            Logger.root.info("PaymentService.isReady");
            t.cancel();
            completer.complete( true );
          }
          else {
            // Logger.root.info("waiting PaymentService.isReady...");
          }
        });
        
    return completer.future;
  }
  
  void expressCheckoutWithPaypal({String productId, int amount}) {
    if (amount != null) {
      window.location.assign(PAYPAL_APPROVAL_PAYMENT_URL + "/${_profileService.user.userId}" + "/$amount");
    }
    else {
      window.location.assign(PAYPAL_APPROVAL_BUY_URL + "/${_profileService.user.userId}" + "/$productId");
    }
  }

  Future checkout(Object order, String productId, String paymentType, String paymentId) {
    Completer completer = new Completer();
    
    if (productId.isNotEmpty && paymentType.isNotEmpty && paymentId.isNotEmpty) {
      _server.checkout(productId, paymentType, paymentId)
            .then((jsonMap) {
              JsUtils.runJavascript(null, "finishOrder", [order, true], 'epicStore');
              
              if (GameInfo.contains("add_gold_success")) {
                window.location.assign(GameInfo.get("add_gold_success"));
              }
              
              if (jsonMap.containsKey("profile")) {
                _profileService.updateProfileFromJson(jsonMap["profile"]);
              }
              
              completer.complete(true);
            });
    }
    else {
      JsUtils.runJavascript(null, "finishOrder", [order, false], 'epicStore');
      
      if (GameInfo.contains("add_gold_success")) {
        window.location.assign(GameInfo.get("add_gold_success"));
      }
      
      completer.complete(false);
    }
    
    return completer.future;
  }

  Future<Map> withdrawFunds(int amount) {
    return _server.withdrawFunds(amount);
  }

  ServerService _server;
  ProfileService _profileService;
  static PaymentService _instance;
}