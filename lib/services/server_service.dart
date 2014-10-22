library server_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:json_object/json_object.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';

abstract class ServerService {
  static final String URL = "url";
  static final String TIMES = "times";
  static final String SECONDS_TO_RETRY = "secondsToRetry";
  static final String onSuccess = "onSuccess";
  static final String onError   = "onError";

  void               setSessionToken(String sessionToken);
  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password);
  Future<JsonObject> login(String email, String password);
  Future<JsonObject> getUserProfile();
  Future<JsonObject> changeUserProfile(String firstName, String lastName, String email, String nickName, String password);
  Future<JsonObject> askForPasswordReset(String email);

  // Conseguir la lista de Contests Active/Live/History en los que esté inscrito el User
  Future<JsonObject> getMyContests();
  Future<JsonObject> getMyContest(String contestId);
  Future<JsonObject> getFullContest(String contestId);

  // Active Contests
  Future<JsonObject> getActiveContests();
  Future<JsonObject> addContestEntry(String contestId, List<String> soccerPlayers);
  Future<JsonObject> editContestEntry(String contestEntryId, List<String> soccerPlayers);
  Future<JsonObject> cancelContestEntry(String contestEntryId);
  Future<JsonObject> getPublicContest(String contestId);

  // Live Contests
  Future<JsonObject> getLiveMatchEventsFromTemplateContest(String templateContestId);

  // Estadísticas SoccerPlayer
  Future<JsonObject> getSoccerPlayerInfo(String templateSoccerPlayerId);

  // Puntuaciones
  Future<JsonObject> getScoringRules();

  // Suscripción a eventos
  void               subscribe(dynamic id, Map callbacks);

  // Debug
  Future<JsonObject> isSimulatorActivated();
  Future<JsonObject> getCurrentDate();
}

@Injectable()
class DailySoccerServer implements ServerService {
  static void startContext(String path) {
    _context++;
  }

  static void endContext(String path) {
  }

  DailySoccerServer(this._http);

  void setSessionToken(String sessionToken) { _sessionToken = sessionToken; }

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("${HostServer.url}/signup", postData: {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<JsonObject> login(String email, String password) {
    return _innerServerCall("${HostServer.url}/login", postData: {'email': email, 'password': password});
  }

  Future<JsonObject> askForPasswordReset(String email) {
    return _innerServerCall("${HostServer.url}/ask_for_password_reset", postData: {'email': email});
  }

  Future<JsonObject> getUserProfile() {
    return _innerServerCall("${HostServer.url}/get_user_profile");
  }

  Future<JsonObject> changeUserProfile(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("${HostServer.url}/change_user_profile", postData: {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<JsonObject> getMyContests() {
    return _innerServerCall("${HostServer.url}/get_my_contests");
  }

  Future<JsonObject> getMyContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_my_contest/$contestId");
  }

  Future<JsonObject> getFullContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_full_contest/$contestId");
  }

  Future<JsonObject> getActiveContests() {
    return _innerServerCall("${HostServer.url}/get_active_contests");
  }

  Future<JsonObject> addContestEntry(String contestId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/add_contest_entry", postData: {'contestId': contestId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<JsonObject> editContestEntry(String contestEntryId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("${HostServer.url}/edit_contest_entry", postData: {'contestEntryId': contestEntryId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<JsonObject> cancelContestEntry(String contestEntryId) {
    return _innerServerCall("${HostServer.url}/cancel_contest_entry", postData: {'contestEntryId': contestEntryId});
  }

  Future<JsonObject> getPublicContest(String contestId) {
    return _innerServerCall("${HostServer.url}/get_public_contest/$contestId");
  }

  Future<JsonObject> getLiveMatchEventsFromTemplateContest(String templateContestId) {
    return _innerServerCall("${HostServer.url}/get_live_match_events/template_contest/$templateContestId");
  }

  Future<JsonObject> getSoccerPlayerInfo(String templateSoccerPlayerId) {
    return _innerServerCall("${HostServer.url}/get_soccer_player_info/$templateSoccerPlayerId");
  }

  Future<JsonObject> isSimulatorActivated() {
    return _innerServerCall("${HostServer.url}/admin/is_simulator_activated", retryTimes: 0);
  }

  Future<JsonObject> getCurrentDate() {
    return _innerServerCall("${HostServer.url}/current_date", retryTimes: 0);
  }

  Future<JsonObject> getScoringRules() {
    return _innerServerCall("${HostServer.url}/get_scoring_rules", retryTimes: -1);
  }

  void subscribe(dynamic id, Map callbacks) {
    // Incluimos el identificador en el propio Map
    callbacks['_id'] = id;

    _subscribers.add(callbacks);
  }

  /**
   * This is the only place where we call our server (except the LoggerExceptionHandler)
   */
  Future<JsonObject> _innerServerCall(String url, {Map queryString:null, Map postData:null, int retryTimes: -1}) {

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
      completer = new Completer<JsonObject>();
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
          _notify(ServerService.onSuccess, {ServerService.URL: url});

          _processSuccess(url, httpResponse, completer);
        })
        .catchError((error) {
          ConnectionError connectionError = new ConnectionError.fromHttpResponse(error);
          if (connectionError.isConnectionError || connectionError.isServerError) {
            _notify(ServerService.onError, {ServerService.URL: url, ServerService.TIMES: retryTimes, ServerService.SECONDS_TO_RETRY: 3});

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
      completer.complete(new JsonObject.fromMap(new Map<String, List>()..putIfAbsent("content", () => httpResponse.data)));
    }
    else {
      completer.complete(new JsonObject.fromMap(httpResponse.data));
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

  ConnectionError(this.type, this.httpError);

  String type;
  dynamic httpError;

  bool operator == (other) {
    if (other is! ConnectionError) return false;
    return (other as ConnectionError).type == type;
  }

  String toString() {
    return type;
  }

  JsonObject toJson() {
    JsonObject jsonError = new JsonObject();

    if (isResponseError) {
      HttpResponse httpResponse = httpError as HttpResponse;
      jsonError = new JsonObject.fromJsonString(httpResponse.data);
    }
    else if (isServerError) {
      jsonError = new JsonObject.fromJsonString(SERVER_ERROR_JSON);
    }
    else if (isConnectionError) {
      jsonError = new JsonObject.fromJsonString(CONNECTION_ERROR_JSON);
    }

    return jsonError;
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

  static const CONNECTION_ERROR_JSON = "{\"error\": \"Connection error\"}";
  static const SERVER_ERROR_JSON = "{\"error\": \"Server error\"}";
}