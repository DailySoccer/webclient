library game_metrics;

import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';

class GameMetrics {

  static String LIVE_CONTEST_VISITED = "Visitado Live Contest";
  static String LOGIN_ATTEMPTED = "Login attempted";
  static String CHANGE_PASSWORD_ATTEMPTED = "Change Password attempted";

  static void logEvent(String eventName) {
    JsUtils.runJavascript(null, "track", eventName, false, "mixpanel");
  }

  static void initMixpanel() {
    String mixpanelCode = HostServer.isProd? "a1889b53bda6b6348f60a570f658c157":
                                             "f627312247ce937f807ce4b9d786314b";
    JsUtils.runJavascript(null, "init", mixpanelCode, false, "mixpanel");
  }

}