library flash_message_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/server_service.dart';

@Component(selector: 'flash-messages',
           templateUrl: 'packages/webclient/components/flash_messages_comp.html',
           useShadowDom: false)
class FlashMessageComp {

  String globalMessage = "";
  List<FlashMessage> get messages => _flashMessageService.messages;

  FlashMessageComp(this._flashMessageService, ServerService serverService) {
    serverService.subscribe("GlobalConnection", onSuccess: onServerSuccess, onError: onServerError);
  }

  void onServerSuccess(Map aMsg) {
    globalMessage = "";
  }

  void onServerError(Map aMsg) {
     // _secondsToRetry = aMsg['secondsToRetry'];

    globalMessage = "Error en la conexión...";

    /*
    if (secondsTimer != null && secondsTimer.isActive) {
      secondsTimer.cancel();
    }

    secondsTimer = new Timer.periodic(const Duration(seconds: 1), (_) {
      _secondsToRetry--;
      msg = "Error en la conexión... $_secondsToRetry seg.";
    });
    */
  }

  //Timer secondsTimer;
  //int _secondsToRetry;

  FlashMessagesService _flashMessageService;
}