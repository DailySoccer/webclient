import 'package:webclient/utils/js_utils.dart';

class GameMetrics {

  static String LIVE_CONTEST_VISITED = "Visitado Live Contest";
  static String LOGIN_ATTEMPTED = "Login attempted";

  static void logEvent(String eventName) {
    JsUtils.runJavascript(null, "track", eventName, false, "mixpanel");
  }
}