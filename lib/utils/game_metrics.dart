library game_metrics;

import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:logging/logging.dart';

class GameMetrics {

  static String ENTER_FROM_FUTBOL_CUATRO = "Traffic Source FutbolCuatro";
  static String COMING_FROM_SOCIAL_UTM = "Traffic Source UTM";
  static String LANDING_PAGE = "Landing Page";
  static String PAGE_READY = "Load Web App Completed";
  
  
  static String SIGNUP_ATTEMPTED = "SignUp Started";
  static String SIGNUP_SUCCESSFUL = "SignUp Completed";
  static String LOGIN_ATTEMPTED = "Login Email Started";
  static String LOGIN_SUCCESSFUL = "Login Email Completed";
  static String LOGIN_FB_SUCCESSFUL = "Login FB Completed";
  static String LOGIN_FB_PERMISSIONS_DENIED = "Login FB Permissions Denied";
  static String LOGIN_FB_REREQUEST_ACCEPTED = "Login FB Rerequest Accepted";
  static String LOGIN_FB_REREQUEST_REJECTED = "Login FB Rerequest Rejected";
  static String CHANGE_PASSWORD_ATTEMPTED = "Password Change Started";
  
  
  static String LOBBY = "Access Lobby Page";
  static String HOME = "Access Home Page";
  static String VIEW_HISTORY = "Access Tournament History";
  static String UPCOMING_CONTEST = "Access Tournament Upcoming";
  static String LIVE_CONTEST_VISITED = "Access Tournament Live";
  static String HELP = "Access Help Section";
  //static String TUTORIAL_LIST = "Entered Tutorial list";
  //static String HOW_IT_WORKS = "Entered How it works";
  //static String RULES = "Entered Rules";
  static String LEADERBOARD = "Access Leaderboard Section";
  static String ACHIEVEMENTS = "Access Achievements Section";
  static String SCOUTING = "Access Scouting Section";
  static String ENTERED_FORUMS = "Access Forum Section";
  static String USER_PROFILE = "Access User Profile Section";
  static String NOTIFICATIONS = "Access Notifications Section";
  /*static String MY_CONTEST_LIVE = "Entered My contest live";
  static String MY_CONTEST_HISTORY = "Entered My contest history";
  static String MY_CONTEST_UPCOMING = "Entered My contest upcoming";*/
  static String ENTER_CONTEST = "Tournament SignUp Started";
  static String ENTER_CONTEST_EDITING = "Tournament Modification Started";
  static String TEAM_CREATED = "Team Creation Completed";
  static String TEAM_MODIFIED = "Team Modification Completed";
  static String CREATE_CONTEST = "Tournament Creation Started";
  static String CREATE_CONTEST_CREATED = "Tournament Creation Completed";
  static String ENTRY_FEE = "Tournament SignUp Completed";
  
  
  static String SHARE_REQUEST_FB = "Share FB Request";
  static String SHARE_REQUEST_TWITTER = "Share Twitter Request";
  static String FRIEND_BAR_CHALLENGE = "Challenge FriendBar Request";
  
  
  // Acciones con dinero:
  //static String ORDER = "Add Funds";
  //static String CANCEL_CONTEST_ENTRY = "Cancel Contest Entry";
  //static String REFUND = "Refund Asked";
  static String PROMO = "Promo"; // TODO: Revisarlo
  static String PLAYER_BOUGHT = "Buy GoldPlayer Completed";
  static String ENERGY_BOUGHT = "Buy Energy Completed";
  static String GOLD_BOUGHT = "Buy Gold Completed";
  static String REQUEST_BUY_GOLD = "Buy Gold Started";
  static String SHOP_ENTERED = "Access Shop Section";
  
  // Tutorial
  static String TUTORIAL_FROM_HELP = "Tutorial From Help";
  static String TUTORIAL_STARTED = "Started";
  static String TUTORIAL_STEP_TEAM_SELECTION = "Step Team Selection";
  static String TUTORIAL_STEP_LOBBY_TRAINING = "Step Lobby Training Contest";
  static String TUTORIAL_COMPLETED = "Step Completed";
  static String TUTORIAL_CANCELED = "Step Canceled";


  static void aliasMixpanel(String email) {
    if (TutorialService.isActivated)
      return;
    
    if (!email.endsWith("test.com") && JsUtils.existsContext(["mixpanel", "alias"])) {
      JsUtils.runJavascript(null, "alias", email, "mixpanel");
    }
    else {
      Logger.root.info("mixPanel: aliasMixpanel not found");
    }
  }

  static void identifyMixpanel(String email) {
    if (TutorialService.isActivated)
      return;
    
    if (!email.endsWith("test.com") && JsUtils.existsContext(["mixpanel", "identify"])) {
      JsUtils.runJavascript(null, "identify", email, "mixpanel");
    }
    else {
      Logger.root.info("mixPanel: identifyMixpanel not found");
    }
  }

  static void logEvent(String eventName, [Map params]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
      
    if (JsUtils.existsContext(["mixpanel", "track"])) {
      if (params != null && !params.isEmpty) {
        JsUtils.runJavascript(null, "track", [eventName, params], "mixpanel");
      }
      else {
        JsUtils.runJavascript(null, "track", eventName, "mixpanel");
      }
    }
    else {
      Logger.root.info("mixPanel: logEvent not found");
    }
  }

  static void peopleSet(Map params) {
    if (TutorialService.isActivated)
      return;
    
    if (JsUtils.existsContext(["mixpanel", "people", "set"])) {
      JsUtils.runJavascript(null, "set", params, ["mixpanel","people"]);
    }
    else {
      Logger.root.info("mixPanel: peopleSet not found");
    }
  }

  static void peopleCharge(double charge) {
    if (TutorialService.isActivated)
      return;
    
    if (JsUtils.existsContext(["mixpanel","people", "track_charge"])) {
      JsUtils.runJavascript(null, "track_charge", charge, ["mixpanel","people"]);
    }
    else {
      Logger.root.info("mixPanel: peopleCharge not found");
    }
 }

  // Google Track, NOT Mixpanel.
  static void trackConversion(bool remarketing_only) {
    if (HostServer.isEpicEleven) {
      JsUtils.runJavascript(null, "conversion", [remarketing_only]);
    }
  }
}