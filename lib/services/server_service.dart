library server_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';

abstract class ServerService {
  static final String URL = "url";
  static final String TIMES = "times";
  static final String SECONDS_TO_RETRY = "secondsToRetry";

  void        setSessionToken(String sessionToken);
  Future<Map> verifyPasswordResetToken(String token);
  Future<Map> resetPassword(String password, String stormPathTokenId);
  Future<Map> signup(String firstName, String lastName, String email, String nickName, String password);
  Future<Map> login(String email, String password);
  Future<Map> getUserProfile();
  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password);
  Future<Map> askForPasswordReset(String email);

  // Conseguir la lista de Contests Active/Live/History en los que esté inscrito el User
  Future<Map> getMyContests();
  Future<Map> getMyContest(String contestId);
  Future<Map> getMyContestEntry(String contestId);
  Future<Map> getFullContest(String contestId);
  Future<Map> getViewContest(String contestId);

  // Active Contests
  Future<Map> getActiveContests();
  Future<Map> addContestEntry(String contestId, List<String> soccerPlayers);
  Future<Map> editContestEntry(String contestEntryId, List<String> soccerPlayers);
  Future<Map> cancelContestEntry(String contestEntryId);
  Future<Map> getPublicContest(String contestId);

  // Live Contests
  Future<Map> getLiveMatchEventsFromTemplateContest(String templateContestId);

  // Estadísticas SoccerPlayer
  Future<Map> getSoccerPlayerInfo(String templateSoccerPlayerId);

  // Puntuaciones
  Future<Map> getScoringRules();

  // Suscripción a eventos
  void               subscribe(dynamic id, {Function onSuccess, Function onError});

  // Debug
  Future<Map> isSimulatorActivated();
  Future<Map> getCurrentDate();
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

  Future<Map> askForPasswordReset(String email) {
    return _innerServerCall("${HostServer.url}/ask_for_password_reset", postData: {'email': email});
  }

  Future<Map> getUserProfile() {
    return _innerServerCall("${HostServer.url}/get_user_profile");
  }

  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("${HostServer.url}/change_user_profile", postData: {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<Map> getMyContests() {
    return _innerServerCall("${HostServer.url}/get_my_contests");
  }

  Future<Map> getMyContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_contest/$contestId");
  }

  Future<Map> getMyContestEntry(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_contest_entry/$contestId");
  }

  Future<Map> getFullContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_full_contest/$contestId");
  }

  Future<Map> getViewContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_view_contest/$contestId");
  }

  Future<Map> getActiveContests() {
    return _innerServerCall("${HostServer.url}/get_active_contests");
  }

  Future<Map> addContestEntry(String contestId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/add_contest_entry", postData: {'contestId': contestId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<Map> editContestEntry(String contestEntryId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/edit_contest_entry", postData: {'contestEntryId': contestEntryId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<Map> cancelContestEntry(String contestEntryId) {
    return _innerServerCall("${HostServer.url}/cancel_contest_entry", postData: {'contestEntryId': contestEntryId});
  }

  Future<Map> getPublicContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_public_contest/$contestId");
  }

  Future<Map> getLiveMatchEventsFromTemplateContest(String templateContestId) {
    return _innerServerCall("${HostServer.url}/get_live_match_events/template_contest/$templateContestId");
  }

  Future<Map> getSoccerPlayerInfo(String templateSoccerPlayerId) {
    return _innerServerCall("${HostServer.url}/get_soccer_player_info/$templateSoccerPlayerId");
  }

  Future<Map> isSimulatorActivated() {
    return _innerServerCall("${HostServer.url}/admin/is_simulator_activated", retryTimes: 0);
  }

  Future<Map> getCurrentDate() {
    return _innerServerCall("${HostServer.url}/current_date", retryTimes: 0);
  }

  Future<Map> getScoringRules() {
    return _innerServerCall("${HostServer.url}/get_scoring_rules", retryTimes: -1);
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
  Future<Map> _innerServerCall(String url, {Map queryString:null, Map postData:null, int retryTimes: -1}) {

    Completer completer = null;

    // Cuando cambiamos de contexto no queremos reutilizar ningún completer "antiguo"
    if (_context != _pendingCallsContext) {
      _pendingCalls.clear();
      _pendingCallsContext = _context;
    }

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

      _callLoop(_context, url, queryString, postData, theHeaders, completer, retryTimes);
    }

    return completer.future;
  }

  void _callLoop(int callContext, String url, Map queryString, Map postData, var headers, Completer completer, int retryTimes) {
    // Evitamos las reentradas "antiguas" (de otros contextos)
    if (callContext != _context) {
      Logger.root.info("Ignorando callLoop($url): context($callContext) != context($_context)");
      return;
    }

    Future<HttpResponse> http = ((postData != null) ? _http.post(url, postData, headers: headers, params: queryString) : _http.get(url, headers: headers, params: queryString))
        .then((httpResponse) {
          _notify(ON_SUCCESS, {ServerService.URL: url});

          _processSuccess(url, httpResponse, completer);
        })
        .catchError((error) {
          ConnectionError connectionError = new ConnectionError.fromHttpResponse(error);
          if (connectionError.isConnectionError || connectionError.isServerError) {
            _notify(ON_ERROR, {ServerService.URL: url, ServerService.TIMES: retryTimes, ServerService.SECONDS_TO_RETRY: 3});

            Logger.root.severe("_innerServerCall error: $error, url: $url, retry: $retryTimes");
            if ((retryTimes == -1) || (retryTimes > 0)) {
              new Timer(const Duration(seconds: 3), () => _callLoop(callContext, url, queryString, postData, headers, completer, (retryTimes > 0) ? retryTimes-1 : retryTimes));
            }
            else {
              _processError(error, url, completer);
            }
          }
          else {
            _processError(error, url, completer);
          }
        });
  }

  // Por si queremos volver al sistema de mandar todos nuestros posts en form-urlencoded
  String _mapToFormUrlEncoded(Map postData) {
    var parts = [];
    postData.forEach((key, value) { parts.add('${Uri.encodeQueryComponent(key)}=''${Uri.encodeQueryComponent(value)}');});
    return parts.join('&');
  }

  void _processSuccess(String url, HttpResponse httpResponse, Completer completer) {
    _setFinishCompleterForUrl(url);

    // The response can be either a Map or a List. We should avoid this step by rewriting the HttpInterceptor and creating the
    // JsonObject directly from the JsonString.
    if (httpResponse.data is List) {
      completer.complete(new Map<String, List>()..putIfAbsent("content", () => httpResponse.data));
    }
    else {
      completer.complete(httpResponse.data);
    }
  }

  void _processError(var error, String url, Completer completer) {
    _setFinishCompleterForUrl(url);

    ConnectionError connectionError = new ConnectionError.fromHttpResponse(error);
    completer.completeError(connectionError);
  }

  void _notify(String key, Map msg) {
    _subscribers
      .where((subscribe) => subscribe.containsKey(key))
      .forEach((subscribe) => subscribe[key](msg));
  }

  void _setFinishCompleterForUrl(String url) {
    _pendingCalls.remove(url);
  }

  Http _http;
  String _sessionToken;

  int _pendingCallsContext = 0;
  Map<String, Completer> _pendingCalls = new Map<String, Completer>();
  List<Map> _subscribers = new List<Map>();

  static int _context = 0;
}

class ConnectionError {
  bool get isResponseError => (type == RESPONSE_ERROR);
  bool get isServerError => (type == SERVER_ERROR);
  bool get isConnectionError => (type == CONNECTION_ERROR);
  bool get isUnauthorizedError => (type == UNAUTHORIZED_ERROR);

  ConnectionError(this.type, this.httpError);

  String type;
  dynamic httpError;

  String toString() => type;

  int get hashCode => type.hashCode;

  bool operator == (other) {
    if (other is! ConnectionError) return false;
    return (other as ConnectionError).type == type;
  }

  Map toJson() {

    String errorString = UNKNOWN_ERROR_JSON;

    if (isResponseError) {
      HttpResponse httpResponse = httpError as HttpResponse;
      errorString = httpResponse.data;
    }
    else if (isServerError) {
      errorString = SERVER_ERROR_JSON;
    }
    else if (isUnauthorizedError) {
      errorString = UNAUTHORIZED_ERROR_JSON;
    }
    else if (isConnectionError) {
      errorString = CONNECTION_ERROR_JSON;
    }

    return JSON.decode(errorString);
  }

  factory ConnectionError.fromHttpResponse(var error) {
    String type = UNKNOWN_ERROR;

    if (error is HttpResponse) {
      HttpResponse httpResponse = error as HttpResponse;

      if (httpResponse.status == 400) {
        if (httpResponse.data != null && httpResponse.data != "") {
          type = RESPONSE_ERROR;
        }
      }
      else if (httpResponse.status == 500 || httpResponse.status == 404) {
        type = SERVER_ERROR;
      }
      else if (httpResponse.status == 401) {
        type = UNAUTHORIZED_ERROR;
      }
      else {
        type = CONNECTION_ERROR;
      }
    }
    else {
      type = SERVER_ERROR;
    }

    return new ConnectionError(type, error);
  }

  static const String UNKNOWN_ERROR = "UNKNOWN_ERROR";
  static const String RESPONSE_ERROR = "RESPONSE_ERROR";
  static const String SERVER_ERROR = "SERVER_ERROR";
  static const String CONNECTION_ERROR = "CONNECTION_ERROR";
  static const String UNAUTHORIZED_ERROR = "UNAUTHORIZED_ERROR";

  static const UNKNOWN_ERROR_JSON = "{\"error\": \"Unknown error\"}";
  static const CONNECTION_ERROR_JSON = "{\"error\": \"Connection error\"}";
  static const SERVER_ERROR_JSON = "{\"error\": \"Server error\"}";
  static const UNAUTHORIZED_ERROR_JSON = "{\"error\": \"Unauthorized error\"}";
}