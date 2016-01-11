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
  static String VIEW_HISTORY = "View history";
  static String VIEW_CONTEST = "View contest";
  static String HELP = "Entered Help";
  static String TUTORIAL_LIST = "Entered Tutorial list";
  static String HOW_IT_WORKS = "Entered How it works";
  static String RULES = "Entered Rules";
  static String ENTER_CONTEST = "Entered enter contest";
  static String LEADERBOARD = "Entered Leaderboard";
  static String ACHIEVEMENTS = "Entered Achievements";
  static String SCOUTING = "Entered Scouting";
  static String TRAINERS_SCHOOL = "Entered School";
  /*static String MY_CONTEST_LIVE = "Entered My contest live";
  static String MY_CONTEST_HISTORY = "Entered My contest history";
  static String MY_CONTEST_UPCOMING = "Entered My contest upcoming";*/
  static String TEAM_CREATED = "Created a team";
  static String LIVE_CONTEST_VISITED = "Visitado Live Contest";
  static String PAGE_READY = "Page ready";
  static String USER_PROFILE = "Entered User Profile";
  static String NOTIFICATIONS = "Entered Notifications";
  static String CREATE_CONTEST = "Entered Create Contest";
  static String CREATE_CONTEST_CREATED = "Create Contest Created";
  static String SHARE_REQUEST_FB = "Share request facebook";
  static String SHARE_REQUEST_TWITTER = "Share request twitter";
  static String FRIEND_BAR_CHALLENGE = "Friend bar Challenge request";
  // Acciones con dinero:
  static String ENTRY_FEE = "Entry Fee for Contest";
  static String ORDER = "Add Funds";
  static String CANCEL_CONTEST_ENTRY = "Cancel Contest Entry";
  static String REFUND = "Refund Asked";
  static String PROMO = "Promo";
  static String PLAYER_BOUGHT = "Player bought with Gold";
  static String SHOP_ENTERED = "Shop entered";
  static String ENERGY_BOUGHT = "Energy Bought";
  static String GOLD_BOUGHT = "Gold Bought";
  static String REQUEST_BUY_ENERGY = "Request Energy buy";
  static String REQUEST_BUY_GOLD = "Request Gold buy";
  // Tutorial
  static String TUTORIAL_FROM_HELP = "Tutorial From help";
  static String TUTORIAL_STARTED = "Tutorial Started";
  static String TUTORIAL_STEP_TEAM_SELECTION = "Tutorial Step Team Selection";
  static String TUTORIAL_STEP_LOBBY_TRAINING = "Tutorial Step Lobby Training Contest";
  static String TUTORIAL_COMPLETED = "Tutorial Step Completed";
  static String TUTORIAL_CANCELED = "Tutorial Step Canceled";


  static void aliasMixpanel(String email) {
    if (!email.endsWith("test.com")) {
      JsUtils.runJavascript(null, "alias", email, "mixpanel");
    }
  }

  static void identifyMixpanel(String email) {
    if (!email.endsWith("test.com")) {
      JsUtils.runJavascript(null, "identify", email, "mixpanel");
    }
  }

  static void logEvent(String eventName, [Map params]) {
    if (params!=null && !params.isEmpty) {
      JsUtils.runJavascript(null, "track", [eventName, params], "mixpanel");
    }
    else {
      JsUtils.runJavascript(null, "track", eventName, "mixpanel");
    }
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