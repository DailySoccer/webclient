library global_connection_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';

@Component(
  selector: 'global-connection',
  templateUrl: 'packages/webclient/components/global_connection_comp.html',
  useShadowDom: false
)
class GlobalConnectionComp {
  String msg = "";

  GlobalConnectionComp(ServerService serverService) {
    serverService.subscribe("GlobalConnection", onSuccess: onServerSuccess, onError: onServerError);
  }

  void onServerSuccess(Map aMsg) {
    msg = "";
  }

  void onServerError(Map aMsg) {
    // _secondsToRetry = aMsg['secondsToRetry'];

    msg = "Error en la conexión...";

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
}