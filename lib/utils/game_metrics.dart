library game_metrics;

import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';

class GameMetrics {

  static String SIGNUP_ATTEMPTED = "Sign up attempted";
  static String SIGNUP_SUCCESSFUL = "Sign up successful";
  static String LOGIN_ATTEMPTED = "Login attempted";
  static String LOGIN_SUCCESSFUL = "Login successful";
  static String CHANGE_PASSWORD_ATTEMPTED = "Change Password attempted";
  static String LOBBY = "Lobby";
  static String VIEW_CONTEST = "View contest";
  static String ENTER_CONTEST = "Entered enter contest";
  static String TEAM_CREATED = "Created a team";
  static String LIVE_CONTEST_VISITED = "Visitado Live Contest";

  static void aliasMixpanel(String email) {
    JsUtils.runJavascript(null, "alias", email, false, "mixpanel");
  }
  static void identifyMixpanel(String email) {
    JsUtils.runJavascript(null, "identify", email, false, "mixpanel");
  }

  static void logEvent(String eventName) {
    JsUtils.runJavascript(null, "track", eventName, false, "mixpanel");
  }

  static void initMixpanel() {
    String mixpanelCode = HostServer.isProd? "a1889b53bda6b6348f60a570f658c157":
                                             "f627312247ce937f807ce4b9d786314b";
    JsUtils.runJavascript(null, "init", mixpanelCode, false, "mixpanel");
  }

}