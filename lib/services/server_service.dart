library server_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/host_server.dart';
import 'dart:html';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/competition.dart';
import 'package:webclient/components/navigation/deprecated_version_screen_comp.dart';
import 'package:webclient/utils/js_utils.dart';


abstract class ServerService {
  static final String URL = "url";
  static final String TIMES = "times";
  static final String SECONDS_TO_RETRY = "secondsToRetry";

  void        cancelAllAndReload();
  void        setSessionToken(String sessionToken);
  Future<Map> verifyPasswordResetToken(String token);
  Future<Map> resetPassword(String password, String stormPathTokenId);
  Future<Map> signup(String firstName, String lastName, String email, String nickName, String password);
  Future<Map> login(String email, String password);
  Future<Map> facebookLogin(String accessToken, String facebookID, String facebookName, String facebookEmail);
  Future<Map> deviceLogin(String uuid);
  Future<Map> askForUserProfile({String email, String password, String accessToken, String facebookID});
  Future<Map> bindFromAccount({String firstName, String lastName, String email, String nickName, String password});
  Future<Map> bindToAccount({String email, String password});
  Future<Map> bindFromFacebookAccount({String accessToken, String facebookID, String facebookName, String facebookEmail});
  Future<Map> bindToFacebookAccount({String accessToken, String facebookID});
  Future<Map> getUserProfile();
  Future<Map> getFacebookProfiles(List<String> facebookIds);
  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password);
  Future<Map> askForPasswordReset(String email);
  Future<Map> removeNotification(String notificationId);
  Future<Map> favorites(List<String> soccerPlayers);

  // Conseguir la lista de Contests Active/Live/History en los que esté inscrito el User
  Future<Map> getMyContests();
  Future<Map> getMyActiveContests();
  Future<Map> getMyLiveContests();
  Future<Map> getMyHistoryContests();
  Future<Map> getMyActiveContest(String contestId);
  Future<Map> getMyLiveContest(String contestId);
  Future<Map> getMyHistoryContest(String contestId);
  Future<Map> getMyContestEntry(String contestId);
  Future<Map> countMyLiveContests();
  Future<Map> countMyContests();

  // Template Contests
  Future<Map> getActiveTemplateContests();
  Future<Map> createContest(Contest contest, List<String> soccerPlayers);

  // Active Contests
  Future<Map> getActiveContests();
  Future<Map> getActiveContest(String contestId);
  Future<Map> addContestEntry(String contestId, String formation, List<String> soccerPlayers);
  Future<Map> editContestEntry(String contestEntryId, String formation, List<String> soccerPlayers);
  Future<Map> cancelContestEntry(String contestEntryId);
  Future<Map> changeSoccerPlayer(String contestEntryId, String soccerPlayerId, String soccerPlayerIdNew);
  Future<Map> getContestInfo(String contestId);
  Future<Map> generateLineup(String contestId, String formation);

  // Live Contests
  Future<Map> getLiveMatchEventsFromTemplateContest(String templateContestId);
  Future<Map> getLiveMatchEventsFromContest(String contestId);
  Future<Map> getSoccerPlayersAvailablesToChange(String contestId);
  Future<Map> getLiveContestEntries(String contestId);

  // Estadísticas SoccerPlayer
  Future<Map> getInstancePlayerInfo(String contestId, String instanceSoccerPlayerId);
  Future<Map> getSoccerPlayerInfo(String templateSoccerPlayerId);
  Future<Map> getSoccerPlayersByCompetition(String competitionId);
  Future<Map> getTemplateSoccerPlayers();
  Future<Map> getTemplateSoccerTeams();

  // Promos
  Future<Map> getPromos();
  Future<Map> getPromo(String promoCodeName);

  // Puntuaciones
  Future<Map> getScoringRules();

  // Leaderboards
  Future<Map> getLeaderboard();

  // Transaction History
  Future<Map> getTransactionHistory();

  // WithDraw Funds
  Future<Map> withdrawFunds(int amount);

  // Premios
  Future<Map> getPrizes();

  // Catalog
  Future<Map> buyProduct(String productId);
  Future<Map> buySoccerPlayer(String contestId, String soccerPlayerId);
  Future<Map> getCatalog();
  Future<Map> getiTunesCatalog();
  Future<Map> getPlayStoreCatalog();
  
  Future<Map> checkout(String productId, String paymentType, String paymentId);

  // Guild
  Future<Map> getGuilds();
  Future<Map> createGuild(String name);
  Future<Map> requestToEnter(String guildId);
  Future<Map> rejectRequestToEnter(String userId);
  Future<Map> addMemberToGuild(String userId);
  Future<Map> removeMember(String userId);
  Future<Map> removeFromGuild();
  Future<Map> getGuildLeaderboard();
  
  // Suscripción a eventos
  void        subscribe(dynamic id, {Function onSuccess, Function onError});

  // Debug
  Future<Map> getSimulatorState();
}

@Injectable()
class DailySoccerServer implements ServerService {
  static final String ON_SUCCESS = "onSuccess";
  static final String ON_ERROR   = "onError";

  static void startContext(String path) {
    _context++;
  }

  static void endContext(String path) {
  }

  DailySoccerServer(this._http);

  void setSessionToken(String sessionToken) { _sessionToken = sessionToken; }

  Future<Map> verifyPasswordResetToken(String token) {
    return _innerServerCall("${HostServer.url}/verify_password_reset_token", postData: {'token':token});
  }

  Future<Map> resetPassword(String password, String stormPathTokenId) {
    return _innerServerCall("${HostServer.url}/reset_password", postData: {'password':password, 'token':stormPathTokenId});
  }

  Future<Map> signup(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("${HostServer.url}/signup", postData: {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<Map> login(String email, String password) {
    return _innerServerCall("${HostServer.url}/login", postData: {'email': email, 'password': password});
  }

  Future<Map> facebookLogin(String accessToken, String facebookID, String facebookName, String facebookEmail) {
    return _innerServerCall("${HostServer.url}/facebooklogin", postData: {
      'accessToken': accessToken,
      'facebookID': facebookID,
      'facebookName': facebookName,
      'facebookEmail': facebookEmail
      });
  }
  
  Future<Map> deviceLogin(String uuid) {
    return _innerServerCall("${HostServer.url}/devicelogin", postData: {'uuid': uuid}, cancelIfChangeContext: false);
  }

  Future<Map> askForUserProfile({String email, String password, String accessToken, String facebookID}) {
    return _innerServerCall("${HostServer.url}/ask_for_user_profile", postData: (email != null)
      ? {
        'email': email,
        'password': password
      }
      : {
        'accessToken': accessToken,
        'facebookID': facebookID
      });
  }
  
  Future<Map> bindFromAccount({String firstName, String lastName, String email, String nickName, String password}) {
    return _innerServerCall("${HostServer.url}/bind_from_account", postData: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'nickName': nickName,
        'password': password
      });
  }
  
  Future<Map> bindToAccount({String email, String password}) {
    return _innerServerCall("${HostServer.url}/bind_to_account", postData:{
        'email': email,
        'password': password
      });
  }

  Future<Map> bindFromFacebookAccount({String accessToken, String facebookID, String facebookName, String facebookEmail}) {
    return _innerServerCall("${HostServer.url}/bind_from_facebook_account", postData: {
        'accessToken': accessToken,
        'facebookID': facebookID,
        'facebookName': facebookName,
        'facebookEmail': facebookEmail
      });
  }
  
  Future<Map> bindToFacebookAccount({String accessToken, String facebookID}) {
    return _innerServerCall("${HostServer.url}/bind_to_facebook_account", postData: {
        'accessToken': accessToken,
        'facebookID': facebookID
      });
  }
  
  Future<Map> askForPasswordReset(String email) {
    return _innerServerCall("${HostServer.url}/ask_for_password_reset", postData: {'email': email});
  }

  Future<Map> removeNotification(String notificationId) {
    return _innerServerCall("${HostServer.url}/remove_notification/$notificationId");
  }

  Future<Map> getUserProfile() {
    return _innerServerCall("${HostServer.url}/get_user_profile", cancelIfChangeContext: false);
  }

  Future<Map> getFacebookProfiles(List<String> facebookIds) {
    String jsonFacebookIds = JSON.encode(facebookIds);

    Map postData = {
      'facebookIds': jsonFacebookIds
    };

    return _innerServerCall("${HostServer.url}/get_facebook_profiles", postData: postData);
  }

  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("${HostServer.url}/change_user_profile", postData: {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<Map> favorites(List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);

    Map postData = {
      'soccerPlayers': jsonSoccerPlayers
    };

    return _innerServerCall("${HostServer.url}/favorites", postData: postData);
  }

  Future<Map> getMyContests() {
    return _innerServerCall("${HostServer.url}/get_my_contests");
  }

  Future<Map> getMyActiveContests() {
    return _innerServerCall("${HostServer.url}/get_my_active_contests");
  }

  Future<Map> getMyLiveContests() {
    return _innerServerCall("${HostServer.url}/get_my_live_contests");
  }

  Future<Map> getMyHistoryContests() {
    return _innerServerCall("${HostServer.url}/get_my_history_contests");
  }

  Future<Map> getMyActiveContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_active_contest/$contestId");
  }

  Future<Map> getMyLiveContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_live_contest/$contestId");
  }

  Future<Map> getMyHistoryContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_history_contest/$contestId");
  }

  Future<Map> getMyContestEntry(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_contest_entry/$contestId");
  }

  Future<Map> countMyLiveContests() {
    return _innerServerCall("${HostServer.url}/count_my_live_contests");
  }
  
  Future<Map> countMyContests() {
    return _innerServerCall("${HostServer.url}/count_my_contests");
  }

  Future<Map> getActiveTemplateContests() {
    return _innerServerCall("${HostServer.url}/get_active_templatecontests");
  }

  Future<Map> createContest(Contest contest, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);

    Map postData = {
      'templateContestId': contest.templateContestId,
      'name': contest.name,
      'millisecondsSinceEpoch': contest.startDate.millisecondsSinceEpoch,
      'simulation': contest.isSimulation,
      'maxEntries': contest.maxEntries,
      'soccerTeam': jsonSoccerPlayers
    };

    return _innerServerCall("${HostServer.url}/create_contest", postData: postData);
  }

  Future<Map> getActiveContests() {
    return _innerServerCall("${HostServer.url}/get_active_contests");
  }

  Future<Map> getActiveContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_active_contest/$contestId");
  }

  Future<Map> addContestEntry(String contestId, String formation, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/add_contest_entry", postData: {'contestId': contestId, 'formation': formation, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<Map> editContestEntry(String contestEntryId, String formation, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/edit_contest_entry", postData: {'contestEntryId': contestEntryId, 'formation': formation, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<Map> cancelContestEntry(String contestEntryId) {
    return _innerServerCall("${HostServer.url}/cancel_contest_entry", postData: {'contestEntryId': contestEntryId});
  }

  Future<Map> changeSoccerPlayer(String contestEntryId, String soccerPlayerId, String soccerPlayerIdNew) {
    return _innerServerCall("${HostServer.url}/change_soccer_player", postData: {'contestEntryId': contestEntryId, 'soccerPlayerId': soccerPlayerId, 'soccerPlayerIdNew': soccerPlayerIdNew});
  }

  Future<Map> getContestInfo(String contestId) {
    return _innerServerCall("${HostServer.url}/get_contest_info/$contestId");
  }

  Future<Map> generateLineup(String contestId, String formation) {
    return _innerServerCall("${HostServer.url}/generate_lineup/$contestId/$formation");
  }
  
  Future<Map> getLiveMatchEventsFromTemplateContest(String templateContestId) {
    return _innerServerCall("${HostServer.url}/get_live_match_events/template_contest/$templateContestId");
  }

  Future<Map> getLiveMatchEventsFromContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_live_match_events/contest/$contestId");
  }

  Future<Map> getSoccerPlayersAvailablesToChange(String contestId) {
    return _innerServerCall("${HostServer.url}/get_soccer_players_availables_to_change/$contestId");
  }
  
  Future<Map> getLiveContestEntries(String contestId) {
    return _innerServerCall("${HostServer.url}/get_live_contest_entries/$contestId");
  }

  Future<Map> getInstancePlayerInfo(String contestId, String instanceSoccerPlayerId) {
    return _innerServerCall("${HostServer.url}/get_instance_soccer_player_info/$contestId/$instanceSoccerPlayerId");
  }

  Future<Map> getSoccerPlayerInfo(String templateSoccerPlayerId) {
    return _innerServerCall("${HostServer.url}/get_soccer_player_info/$templateSoccerPlayerId");
  }

  Future<Map> getSoccerPlayersByCompetition(String competitionId) {
    if (competitionId == Competition.LEAGUE_ES_ID) {
      return _innerServerCall("${HostServer.url}/get_soccer_players_by_competition_${Competition.LEAGUE_ES_ID}");
    }
    else if (competitionId == Competition.LEAGUE_UK_ID) {
      return _innerServerCall("${HostServer.url}/get_soccer_players_by_competition_${Competition.LEAGUE_UK_ID}");
    }
    return _innerServerCall("${HostServer.url}/get_soccer_players_by_competition/$competitionId");
  }

  Future<Map> getTemplateSoccerPlayers() {
    return _innerServerCall("${HostServer.url}/v2/get_template_soccer_players", retryTimes: -1, cancelIfChangeContext: false);
  }
  
  Future<Map> getTemplateSoccerTeams() {
    return _innerServerCall("${HostServer.url}/get_template_soccer_teams", retryTimes: -1, cancelIfChangeContext: false);
  }

  Future<Map> getSimulatorState() {
    return _innerServerCall("${HostServer.url}/admin/get_simulator_state", retryTimes: 0, cancelIfChangeContext: false);
  }

  Future<Map> getPromos() {
    return _innerServerCall("${HostServer.url}/promos", retryTimes: -1);
  }

  Future<Map> getPromo(String promoCodeName) {
    return _innerServerCall("${HostServer.url}/promos/$promoCodeName", retryTimes: -1);
  }

  Future<Map> getScoringRules() {
    return _innerServerCall("${HostServer.url}/get_scoring_rules", retryTimes: -1);
  }

  Future<Map> getLeaderboard() {
    return _innerServerCall("${HostServer.url}/get_leaderboard", retryTimes: -1);
  }

  Future<Map> getTransactionHistory() {
    return _innerServerCall("${HostServer.url}/get_transaction_history", retryTimes: -1);
  }

  Future<Map> withdrawFunds(int amount) {
    return _innerServerCall("${HostServer.url}/paypal/withdraw_funds/$amount", retryTimes: -1);
  }

  Future<Map> getPrizes() {
    return _innerServerCall("${HostServer.url}/get_prizes", retryTimes: -1);
  }

  Future<Map> buyProduct(String productId) {
    return _innerServerCall("${HostServer.url}/buy_product/$productId", retryTimes: -1);
  }

  Future<Map> buySoccerPlayer(String contestId, String soccerPlayerId) {
    return _innerServerCall("${HostServer.url}/buy_soccer_player/$contestId/$soccerPlayerId", retryTimes: -1);
  }

  Future<Map> getCatalog() {
    return _innerServerCall("${HostServer.url}/get_catalog", retryTimes: -1, cancelIfChangeContext: false);
  }

  Future<Map> getiTunesCatalog() {
    return _innerServerCall("${HostServer.url}/get_itunes_catalog", retryTimes: -1, cancelIfChangeContext: false);
  }

  Future<Map> getPlayStoreCatalog() {
    return _innerServerCall("${HostServer.url}/get_playstore_catalog", retryTimes: -1, cancelIfChangeContext: false);
  }
  
  Future<Map> checkout(String productId, String paymentType, String paymentId) {
    // Incluimos el paymentId en la url, para que no se produzca la reutilización de "completers" de distintas compras    
    return _innerServerCall("${HostServer.url}/store/buy/$paymentId", postData: {
        'productId': productId,
        'paymentType': paymentType,
        'paymentId': paymentId
      }
    );
  }
  
  Future<Map> getGuilds() {
    return _innerServerCall("${HostServer.url}/get_guilds");
  }
  
  Future<Map> createGuild(String name) {
    return _innerServerCall("${HostServer.url}/create_guild", postData: {
      'name': name
    });
  }
  
  Future<Map> requestToEnter(String guildId) {
    return _innerServerCall("${HostServer.url}/request_to_enter/$guildId", retryTimes: -1);
  }

  Future<Map> rejectRequestToEnter(String userId) {
    return _innerServerCall("${HostServer.url}/reject_request_to_enter/$userId", retryTimes: -1);
  }

  Future<Map> addMemberToGuild(String userId) {
    return _innerServerCall("${HostServer.url}/add_member_to_guild/$userId", retryTimes: -1);
  }
  
  Future<Map> removeMember(String userId) {
    return _innerServerCall("${HostServer.url}/remove_member/$userId", retryTimes: -1);
  }
  
  Future<Map> removeFromGuild() {
    return _innerServerCall("${HostServer.url}/remove_from_guild", retryTimes: -1);
  }
  
  Future<Map> getGuildLeaderboard() {
    return _innerServerCall("${HostServer.url}/get_guild_leaderboard", retryTimes: -1);
  }
  
  void cancelAllAndReload() {
    _allFuturesCancelled = true;
    window.location.reload();
  }

  void subscribe(dynamic id, {Function onSuccess, Function onError}) {
    Map callbacks = new Map();

    callbacks['_id'] = id;

    if (onSuccess != null) {
      callbacks[ON_SUCCESS] = onSuccess;
    }

    if (onError != null) {
      callbacks[ON_ERROR] = onError;
    }

    _subscribers.add(callbacks);
  }

  /**
   * This is the only place where we call our server (except the LoggerExceptionHandler)
   */
  Future<Map> _innerServerCall(String url, {Map queryString:null, Map postData:null, int retryTimes: -1, bool cancelIfChangeContext: true}) {

    if (TutorialService.isActivated && TutorialService.Instance.isServerCallLocked(url, postData: postData)) {
      if (!url.contains("get_simulator_state")) {
        print("Tutorial: $url");
      }
      return TutorialService.Instance.serverCall(url, postData: postData);
    }

    // Cuando cambiamos de contexto no queremos reutilizar ningún completer "antiguo"
    if (_context != _pendingCallsContext) {
      _pendingCalls.clear();
      _pendingCallsContext = _context;
    }

    Completer completer = null;

    if (_pendingCalls.containsKey(url) && !_pendingCalls[url].isCompleted) {
      completer = _pendingCalls[url];
      Logger.root.info("Reutilizando completer($url)");
    }
    else {
      completer = new Completer<Map>();
      _pendingCalls[url]= completer;

      var theHeaders = {};

      // Nuestro sistema no funciona con cookies. Mandamos el sessionToken en una custom header.
      if (_sessionToken != null) {
        theHeaders["X-Session-Token"] = _sessionToken;
      }

      _callLoop(_context, url, queryString, postData, theHeaders, completer, retryTimes, cancelIfChangeContext);
    }

    return completer.future;
  }

  void _callLoop(int callContext, String url, Map queryString, Map postData, var headers, Completer completer, int retryTimes, bool cancelIfChangeContext) {
    // Evitamos las reentradas "antiguas" (de otros contextos)
    if (callContext != _context) {
      Logger.root.info("Ignorando callLoop($url): context($callContext) != context($_context)");
      return;
    }

    if (postData == null) {
      queryString = _randomizeQueryString(queryString);
    }

    ((postData != null) ? _http.post(url, postData, headers: headers, params: queryString) :
                          _http.get(url, headers: headers, params: queryString))
        .then((httpResponse) {

          if (!_allFuturesCancelled && (callContext == _context || !cancelIfChangeContext)) {
            _checkServerVersion(httpResponse);
            _notify(ON_SUCCESS, {ServerService.URL: url});
            _processSuccess(url, httpResponse, completer);
          }
          else {
            _processFutureCancellation(url, completer);
          }
        })
        .catchError((error) {

          _checkServerVersion(error);

          ServerError serverError = new ServerError.fromHttpResponse(error);

          if (serverError.isConnectionError || serverError.isServerNotFoundError) {
            _notify(ON_ERROR, {ServerService.URL: url, ServerService.TIMES: retryTimes, ServerService.SECONDS_TO_RETRY: 3});

            Logger.root.severe("_innerServerCall error: $error, url: $url, retry: $retryTimes");

            if ((retryTimes == -1) || (retryTimes > 0)) {
              new Timer(const Duration(seconds: 5), () => _callLoop(callContext, url, queryString, postData, headers, completer, (retryTimes > 0) ? retryTimes-1 : retryTimes, cancelIfChangeContext));
            }
            else {
              _processError(serverError, url, completer);
            }
          }
          else if (serverError.isServerExceptionError) {
                        // Si se ha producido una excepcion en el servidor, navegaremos a la landing/lobby para forzar "limpieza" en el cliente
            window.location.assign(Uri.parse(window.location.toString()).path);
          }
          else {
            _processError(serverError, url, completer);
          }
        });
  }

  Map _randomizeQueryString(Map queryString) {
    if (queryString == null) {
      queryString = new Map();
    }

    queryString["rnd"] = new DateTime.now().millisecondsSinceEpoch;

    return queryString;
  }

  void _processSuccess(String url, HttpResponse httpResponse, Completer completer) {
    if (completer.isCompleted) {
      throw new Exception("WTF 1020 El checkeo del completer se deberia hacer antes");
    }

    _pendingCalls.remove(url);

    // The response can be either a Map or a List. We should avoid this step by rewriting the HttpInterceptor and creating the
    // JsonObject directly from the JsonString.
    if (httpResponse.data is List) {
      completer.complete(new Map<String, List>()..putIfAbsent("content", () => httpResponse.data));
    }
    else {
      completer.complete(httpResponse.data);
    }
  }

  void _processError(ServerError serverError, String url, Completer completer) {
    if (completer.isCompleted) {
      throw new Exception("WTF 1021 El checkeo del completer se deberia hacer antes");
    }

    _pendingCalls.remove(url);
    completer.completeError(serverError);
  }

  void _processFutureCancellation(String url, Completer completer) {
    if (completer.isCompleted) {
      throw new Exception("WTF 1022 El checkeo del completer se deberia hacer antes");
    }

    Logger.root.info("Future cancelled: $url");

    // Tal y como esta ahora es redundante, pero anyway...
    _pendingCalls.remove(url);

    // El receptor tendra que verificar si lo que le llega es un ServerError o un FutureCancelled
    completer.completeError(new FutureCancelled());
  }

  // Cuando se produce una actualizacion del servidor, forzamos una recarga de la pagina en el cliente para asegurarnos
  // de que siempre tenemos la ultima version
  void _checkServerVersion(var httpResponse) {
    
    String serverVersion = HostServer.isAndroidPlatform ? httpResponse.headers("release-version-android") : httpResponse.headers("release-version-ios");
    if (serverVersion != null && (serverVersion!="devel")) {
      if (_currentVersion == null || _currentVersion.isEmpty) {
        Logger.root.info("ServerService: CurrentVersion updated");
        JsUtils.runJavascript(null, "getAppVersion", [(version) => _currentVersion = version]);
      }
      
      if (_currentVersion != null && changedVersion(_currentVersion, serverVersion)) {
        Logger.root.info("INCOHERENT VERSION ==> VERSIONES ::::::  CURRENT: $_currentVersion |||| SERVER: $serverVersion");
        
        String marketAppId = HostServer.isAndroidPlatform ? httpResponse.headers("market-app-id-android") : httpResponse.headers("market-app-id-ios");
        if (marketAppId != null && marketAppId.isNotEmpty) {
          Logger.root.info("RELOAD LOCATION ==> VERSIONES ::::::  CURRENT: $_currentVersion |||| SERVER: $serverVersion");
          DeprecatedVersionScreenComp.Instance.show = true;
          DeprecatedVersionScreenComp.Instance.marketAppId = marketAppId;
        }
      }
      
      HostServer.CURRENT_VERSION = serverVersion;
    }
  }

  bool changedVersion(String oriVersion, String dstVersion) {
    if (oriVersion == dstVersion) return false;
    
    List ori = oriVersion.split(".");
    List dst = dstVersion.split(".");
    return !( (ori.length >= 2) && (dst.length >= 2) && (ori[0] == dst[0]) && (ori[1] == dst[1]) );
  }
  
  // Por si queremos volver al sistema de mandar todos nuestros posts en form-urlencoded
  String _mapToFormUrlEncoded(Map postData) {
    var parts = [];
    postData.forEach((key, value) { parts.add('${Uri.encodeQueryComponent(key)}=''${Uri.encodeQueryComponent(value)}');});
    return parts.join('&');
  }

  void _notify(String key, Map msg) {
    _subscribers
      .where((subscribe) => subscribe.containsKey(key))
      .forEach((subscribe) => subscribe[key](msg));
  }


  Http _http;
  String _sessionToken;
  String _currentVersion;
  bool _allFuturesCancelled = false;

  int _pendingCallsContext = 0;
  Map<String, Completer> _pendingCalls = new Map<String, Completer>();
  List<Map> _subscribers = new List<Map>();

  static int _context = 0;
}
