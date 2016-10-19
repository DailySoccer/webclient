library game_metrics;

import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/deltaDNA_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/models/contest.dart';

class GameMetrics {

  static const String SCREEN_DEPRECATED_VERSION = "screen_version_obsoleta";
  static const String ACTION_DEEPLINKING = "action_deeplinking";
  
  
  static const String SCREEN_LINEUP = "screen_alineacion";
  static const String SCREEN_LINEUP_EDIT = "screen_alineacion_editar";
  static const String SCREEN_CONTEST_INFO = "screen_torneo_info";
  static const String SCREEN_LIVE_CONTEST_LIST = "screen_en_vivo_lista";
  static const String SCREEN_LIVE_CONTEST = "screen_en_vivo_torneo";
  static const String SCREEN_RIVAL_LIST = "screen_lista_rivales";
  static const String SCREEN_RIVAL_LINEUP = "screen_alineacion_rival";
  static const String SCREEN_SOCCER_PLAYER_CONTEST_SCORE = "screen_football_player_puntuacion_torneo";
  static const String SCREEN_HISTORY = "screen_historico";
  static const String SCREEN_START = "screen_inicio";
  static const String SCREEN_ACHIEVEMENTS = "screen_logros";
  static const String SCREEN_NOTIFICATIONS = "screen_notificaciones";
  static const String SCREEN_SCOUTING = "screen_ojeador";
  static const String SCREEN_SOCCER_PLAYER_GLOBAL_STATISTICS = "screen_football_player_estadisticas_globales";
  static const String SCREEN_PROFILE = "screen_perfil";
  static const String SCREEN_PROFILE_EDIT = "screen_editar_perfil";
  static const String SCREEN_UPCOMING_CONTEST_LIST = "screen_proximos_torneos_list";
  static const String SCREEN_UPCOMING_CONTEST = "screen_proximos_torneos_torneo";
  //static const String SCREEN_UPCOMING_CONTEST_CHECK_LINEUP = "screen_alineacion_consultar";
  static const String SCREEN_RANKING = "screen_ranking";
  static const String SCREEN_RANKING_COMPLETE = "screen_ranking_completo";
  static const String SCREEN_SHOP = "screen_tienda";
  static const String SCREEN_CONTEST_LIST = "screen_torneos";
  static const String SCREEN_CREATE_CONTEST = "screen_crear_torneo";
  

  static const String ACTION_DEPRECATED_VERSION_GO_SHOP = "action_version_obsoleta_ir_tienda";
  
  static const String ACTION_PROFILE_SAVE = "action_guardar_edicion_perfil";
  
  static const String ACTION_START_PLAY_BUTTON = "action_inicio_boton_jugar";
  
  static const String ACTION_LINEUP_AUTOGENERATE = "action_alineacion_automatica";
  static const String ACTION_LINEUP_CLEAR = "action_alineacion_limpiar";
  static const String ACTION_LINEUP_CHANGE_FORMATION = "action_alineacion_seleccion_formacion";
  static const String ACTION_LINEUP_FAVORITES_FILTER = "action_alineacion_filtro_favoritos";
  static const String ACTION_LINEUP_SOCCERPLAYER_SELECTED = "action_seleccion_football_player";
  static const String ACTION_LINEUP_SOCCERPLAYER_DELETED = "action_eliminar_football_player";
  static const String ACTION_LINEUP_CONFIRM = "action_confirmar_alineacion_torneo";
  static const String ACTION_LINEUP_CONFIRM_ERROR = "action_confirmar_alineacion_torneo_error";
  static const String ACTION_BACK_CONTEST_LIST = "action_volver_a_torneos";
  static const String ACTION_INVITE_FRIENDS = "action_invitar_amigos";
  static const String ACTION_CHECK_LINEUP = "action_ver_alineacion";
  
  static const String ACTION_LINEUP_MODIFY_INIT = "action_modificar_alineacion_inicio";
  static const String ACTION_LINEUP_MODIFY_COMPLETE = "action_modificar_alineacion_completado";
  static const String ACTION_LIVE_SUBSTITUTION_INIT = "action_sustitucion_iniciar";
  static const String ACTION_LIVE_SUBSTITUTION_CANCEL = "action_sustitucion_cancelar";
  static const String ACTION_LIVE_SUBSTITUTION_COMPLETE = "action_sustitucion_completar";
  
  static const String ACTION_FAVORITE_SOCCER_PLAYER_CHANGE = "action_football_player_favorito";
  
  
  /*
  // Load Page Time
  static String ENTER_FROM_FUTBOL_CUATRO = "Traffic Source FutbolCuatro";
  static String COMING_FROM_SOCIAL_UTM = "Traffic Source UTM";
  static String LANDING_PAGE = "Landing Page";
  static String PAGE_READY = "Load WebApp Completed";
  
  // Delta DNA Patch
  static String PEOPLE_SET = "Player Info Set";
  
  // Mobile only
  static String DEPRECATED_VERSION = "Update Notification Displayed";
  static String REQUEST_VERSION_UPDATE = "Update Notification Accepted";
  
  // Login/SignUp
  static String SIGNUP_ATTEMPTED = "SignUp Started";
  static String SIGNUP_SUCCESSFUL = "SignUp Completed";
  static String LOGIN_ATTEMPTED = "Login Started";
  static String LOGIN_SUCCESSFUL = "Login Completed";
  static String BINDING_WITH_APP = "Binding Completed";
  static String BINDING_EXISTS = "Binding Existent";
  // static String LOGIN_FB_SUCCESSFUL = "Login FB Completed";
  // static String SIGNUP_FB_SUCCESSFUL = "SignUp FB Completed";
  static String LOGIN_FB_PERMISSIONS_DENIED = "Login FB Permissions Denied";
  static String LOGIN_FB_REREQUEST_ACCEPTED = "Login FB Rerequest Accepted";
  static String LOGIN_FB_REREQUEST_REJECTED = "Login FB Rerequest Rejected";
  static String CHANGE_PASSWORD_ATTEMPTED = "Password Change Started";
  
  // Navigation related
  static String LOBBY = "Access Lobby Page";
  static String HOME = "Access Home Page";
  static String VIEW_HISTORY = "Access Tournament History";
  static String UPCOMING_CONTEST = "Access Tournament Upcoming";
  static String LIVE_CONTEST_VISITED = "Access Tournament Live";
  static String HELP = "Access Help Section";
  static String LEADERBOARD = "Access Leaderboard Section";
  static String ACHIEVEMENTS = "Access Achievements Section";
  static String SCOUTING = "Access Scouting Section";
  static String ENTERED_FORUMS = "Access Forum Section";
  static String USER_PROFILE = "Access User Profile Section";
  static String NOTIFICATIONS = "Access Notifications Section";
  
  // Contest related
  static String ENTER_CONTEST = "Tournament SignUp Started";
  static String ENTER_CONTEST_EDITING = "Tournament Modification Started";
  static String TEAM_CREATED = "Team Creation Completed";
  static String TEAM_MODIFIED = "Team Modification Completed";
  static String CREATE_CONTEST = "Tournament Creation Started";
  static String CREATE_CONTEST_CREATED = "Tournament Creation Completed";
  static String ENTRY_FEE = "Tournament SignUp Completed";
  
  // Social
  static String SHARE_REQUEST_FB = "Share FB Request";
  static String SHARE_REQUEST_TWITTER = "Share Twitter Request";
  static String FRIEND_BAR_CHALLENGE = "Challenge FriendBar Request";
  
  // Money Actions
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
  */
  
  /*
  static void aliasMixpanel(String email) {
    if (TutorialService.isActivated) return;
    
    if (!email.endsWith("test.com")) DeltaDNAService.instance.sendEvent('newPlayer', {'email': email});
    /* 
    if (!email.endsWith("test.com") && JsUtils.existsContext(["mixpanel", "alias"])) {
      JsUtils.runJavascript(null, "alias", email, "mixpanel");
    }
    else {
      Logger.root.info("mixPanel: aliasMixpanel not found");
    }
    
    */
  }

  static void identify(String email) {
    if (TutorialService.isActivated)
      return;

    if (!email.endsWith("test.com")) DeltaDNAService.instance.sendEvent('newPlayer', {'email': email});
    /*
    if (!email.endsWith("test.com") && JsUtils.existsContext(["mixpanel", "identify"])) {
      JsUtils.runJavascript(null, "identify", email, "mixpanel");
    }
    else {
      Logger.root.info("mixPanel: identifyMixpanel not found");
    }
    
    */
  }
  */
  
  static void setupFromDeepLinking() {
    DeltaDNAService.instance.actionEvent(ACTION_DEEPLINKING, "");
    DeltaDNAService.instance.setupFromDeepLinking();
  }

  static void screenVisitEvent(String eventName, [Map params]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
    
    DeltaDNAService.instance.screenEvent(eventName, params);
  }

  static void contestScreenVisitEvent(String eventName, Contest contest, [Map params = null]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
    
    DeltaDNAService.instance.contestScreenEvent(eventName, contest, params);
  }

  static void actionEvent(String eventName, String screen, [Map params = null]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
    
    DeltaDNAService.instance.actionEvent(eventName, screen, params);
  }

  static void contestActionEvent(String eventName, String screen, Contest contest, [Map params = null]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
    
    DeltaDNAService.instance.contestActionEvent(eventName, screen, contest, params);
  }

  static void logEvent(String eventName, [Map params]) {
    if (TutorialService.isActivated) {
      eventName = "Tutorial $eventName";
    }
    
    DeltaDNAService.instance.sendEvent(eventName, params);
  }

  /*
  static void peopleSet(Map params) {
    if (TutorialService.isActivated)
      return;

    DeltaDNAService.instance.sendEvent(PEOPLE_SET, params);
    /*
    if (JsUtils.existsContext(["mixpanel", "people", "set"])) {
      JsUtils.runJavascript(null, "set", params, ["mixpanel","people"]);
    }
    else {
      Logger.root.info("mixPanel: peopleSet not found");
    }
    
    */
  }

  // Not used
  static void peopleCharge(double charge) {
    if (TutorialService.isActivated)
      return;
    /*
    if (JsUtils.existsContext(["mixpanel","people", "track_charge"])) {
      JsUtils.runJavascript(null, "track_charge", charge, ["mixpanel","people"]);
    }
    else {
      Logger.root.info("mixPanel: peopleCharge not found");
    }
     
    */
  }
  */
  
  // Google Track, NOT Mixpanel.
  static void trackConversion(bool remarketing_only) {
    /*
    if (HostServer.isEpicEleven) {
      JsUtils.runJavascript(null, "conversion", [remarketing_only]);
    }
    
    */
  }
  
  static String eventsDateString() {
    return DateTimeService.now.toString().substring(0, 23);
  }
}