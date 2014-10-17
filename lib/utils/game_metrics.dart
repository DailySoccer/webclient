import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';

class GameMetrics {

  static String LIVE_CONTEST_VISITED = "Visitado Live Contest";
  static String LOGIN_ATTEMPTED = "Login attempted";

  static void logEvent(String eventName) {
    if (HostServer.isProd()) {
      JsUtils.runJavascript(null, "track", eventName, false, "mixpanel");
    }
  }
}