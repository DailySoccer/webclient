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

  // Live Contests
  Future<Map> getLiveMatchEventsFromTemplateContest(String templateContestId);
  Future<Map> getLiveMatchEventsFromContest(String contestId);
  Future<Map> getSoccerPlayersAvailablesToChange(String contestId);
  Future<Map> getLiveContestEntries(String contestId);

  // Estadísticas SoccerPlayer
  Future<Map> getInstancePlayerInfo(String contestId, String instanceSoccerPlayerId);
  Future<Map> getSoccerPlayerInfo(String templateSoccerPlayerId);
  Future<Map> getSoccerPlayersByCompetition(String competitionId);

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
    return _innerServerCall("${HostServer.url}/get_catalog", retryTimes: -1);
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

    var serverVersion = httpResponse.headers("release-version");

    if (serverVersion != null) {
      if (_currentVersion != null && _currentVersion != serverVersion) {
        if (serverVersion!="devel") {
          window.location.reload();
        }
      }
      else {
        _currentVersion = serverVersion;

        HostServer.CURRENT_VERSION = _currentVersion;
      }
    }
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
