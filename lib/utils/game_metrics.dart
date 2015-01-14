library game_metrics;

import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';

class GameMetrics {

  static String LANDING_PAGE = "Landing Page";
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
  static String VERIFIED_ACCOUNT = "Cuenta Verificada";

  static void aliasMixpanel(String email) {
    JsUtils.runJavascript(null, "alias", email, "mixpanel");
  }

  static void identifyMixpanel(String email) {
    JsUtils.runJavascript(null, "identify", email, "mixpanel");
  }

  static void logEvent(String eventName) {
    JsUtils.runJavascript(null, "track", eventName, "mixpanel");
  }

  static void peopleSet(Map params) {
    JsUtils.runJavascript(null, "set", params, ["mixpanel","people"]);
  }

  static void peopleCharge(double charge) {
      JsUtils.runJavascript(null, "track_charge", charge, ["mixpanel","people"]);
    }


  static void trackConversion(bool remarketing_only) {
    if (HostServer.isEpicEleven) {
      JsUtils.runJavascript(null, "conversion", [remarketing_only]);
    }
  }
}