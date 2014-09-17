library server_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:json_object/json_object.dart';
import 'package:webclient/webclient.dart';
import 'package:logging/logging.dart';


abstract class ServerService {
  void               setSessionToken(String sessionToken);
  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password);
  Future<JsonObject> login(String email, String password);
  Future<JsonObject> getUserProfile();

  // Conseguir la lista de Contests Active/Live/History en los que esté inscrito el User
  Future<JsonObject> getMyContests();
  Future<JsonObject> getContest(String contestId);

  // Active Contests
  Future<JsonObject> getActiveContests();
  Future<JsonObject> addContestEntry(String contestId, List<String> soccerPlayers);
  Future<JsonObject> editContestEntry(String contestEntryId, List<String> soccerPlayers);
  Future<JsonObject> cancelContestEntry(String contestEntryId);
  Future<JsonObject> getContestInfo(String contestId);

  // Live Contests
  Future<JsonObject> getLiveMatchEventsFromTemplateContest(String templateContestId);

  // Estadísticas SoccerPlayer
  Future<JsonObject> getSoccerPlayerInfo(String templateSoccerPlayerId);

  // Debug
  Future<JsonObject> isSimulatorActivated();
  Future<JsonObject> getCurrentDate();
}

@Injectable()
class DailySoccerServer implements ServerService {

  DailySoccerServer(this._http) {
    if (_instance != null) {
      throw new Exception("WTF 492");
    }
    _instance = this;
  }

  void setSessionToken(String sessionToken) { _sessionToken = sessionToken; }

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("$HostServerUrl/signup", {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<JsonObject> login(String email, String password) {
    return _innerServerCall("$HostServerUrl/login", {'email': email, 'password': password});
  }

  Future<JsonObject> getUserProfile() {
    return _innerServerCall("$HostServerUrl/get_user_profile", null);
  }

  Future<JsonObject> getMyContests() {
    return _innerServerCall("$HostServerUrl/get_my_contests", null);
  }

  Future<JsonObject> getContest(String contestId) {
    return _innerServerCall("$HostServerUrl/get_contest/$contestId", null);
  }

  Future<JsonObject> getActiveContests() {
    return _innerServerCall("$HostServerUrl/get_active_contests", null);
  }

  Future<JsonObject> addContestEntry(String contestId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("$HostServerUrl/add_contest_entry", {'contestId': contestId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<JsonObject> editContestEntry(String contestEntryId, List<String> soccerPlayers) {
    String jsonSoccerPlayers = JSON.encode(soccerPlayers);
    return _innerServerCall("$HostServerUrl/edit_contest_entry", {'contestEntryId': contestEntryId, 'soccerTeam': jsonSoccerPlayers});
  }

  Future<JsonObject> cancelContestEntry(String contestEntryId) {
    return _innerServerCall("$HostServerUrl/cancel_contest_entry", {'contestEntryId': contestEntryId});
  }

  Future<JsonObject> getContestInfo(String contestId) {
    return _innerServerCall("$HostServerUrl/get_contest_info/$contestId", null);
  }

  Future<JsonObject> getLiveMatchEventsFromTemplateContest(String templateContestId) {
    return _innerServerCall("$HostServerUrl/get_live_match_events/template_contest/$templateContestId", null);
  }

  Future<JsonObject> getSoccerPlayerInfo(String templateSoccerPlayerId) {
    return _innerServerCall("$HostServerUrl/get_soccer_player_info/$templateSoccerPlayerId", null);
  }

  Future<JsonObject> isSimulatorActivated() {
    return _innerServerCall("$HostServerUrl/admin/is_simulator_activated", null);
  }

  Future<JsonObject> getCurrentDate() {
    return _innerServerCall("$HostServerUrl/current_date", null);
  }

  static void logPost(LogRecord r) {
    if (_instance != null) {
      _instance._http.post("$HostServerUrl/log", null, params: {"errorMessage": r.message, "level": r.level, "time": r.time});
    };
  }

  /**
   * This is the only place where we call our server
   */
  Future<JsonObject> _innerServerCall(String url, Map postData) {
    var completer = new Completer<JsonObject>();

    if (_sessionToken != null) {
      url += "?sessionToken=$_sessionToken";
    }

    if (postData != null) {
      _http.post(url, null, params: postData)
          .then((httpResponse) => _processSuccess(httpResponse, completer))
          .catchError((error) => _processError(error, url, completer));
    } else {
      _http.get(url)
           .then((httpResponse) => _processSuccess(httpResponse, completer))
           .catchError((error) => _processError(error, url, completer));
    }

    return completer.future;
  }

  void _processSuccess(HttpResponse httpResponse, Completer completer) {
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

    print("_innerServerCall url: $url\n_innerServerCall error: $error");

    if (error is HttpResponse) {
      HttpResponse httpResponse = error as HttpResponse;

      if (httpResponse.status == 400) {
        if (httpResponse.data != null && httpResponse.data != "") {
          completer.completeError(new JsonObject.fromJsonString(httpResponse.data));
        }
        else {
          completer.completeError(new JsonObject());
        }
      }
      else if (httpResponse.status == 500 || httpResponse.status == 404) {
        completer.completeError(new JsonObject.fromJsonString(SERVER_ERROR_JSON));
      }
      else {
        completer.completeError(new JsonObject.fromJsonString(CONNECTION_ERROR_JSON));
      }
    }
    else {
      completer.completeError(new JsonObject.fromJsonString(SERVER_ERROR_JSON));
    }
  }

  static const CONNECTION_ERROR_JSON = "{\"error\": \"Connection error\"}";
  static const SERVER_ERROR_JSON = "{\"error\": \"Server error\"}";

  Http _http;
  String _sessionToken;
  static DailySoccerServer _instance = null;
}