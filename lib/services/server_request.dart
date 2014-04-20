library server_request;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:json_object/json_object.dart';

import 'package:webclient/webclient.dart';

abstract class ServerRequest {
  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password);
  Future<JsonObject> login(String email, String password);
  Future<JsonObject> getAllContests();
}

class DailySoccerServer implements ServerRequest {

  DailySoccerServer(this._http);

  Future<JsonObject> signup(String firstName, String lastName, String email, String nickName, String password) {
    return _innerServerCall("$HostServer/signup", {'firstName': firstName, 'lastName': lastName, 'email': email, 'nickName': nickName, 'password': password});
  }

  Future<JsonObject> login(String email, String password) {
    return _innerServerCall("$HostServer/login", {'email': email, 'password': password});
  }

  Future<JsonObject> getAllContests() {
    return _innerServerCall("$HostServer/getAllContests", null);
  }

  Future<JsonObject> _innerServerCall(String dataUrl, var data) {
    var completer = new Completer<JsonObject>();
    _http.post(dataUrl, null, params: data)
        .then((httpResponse) => completer.complete(new JsonObject.fromMap(httpResponse.data)))
        .catchError((httpResponse) => completer.completeError(new JsonObject.fromJsonString(httpResponse.data)));
    return completer.future;
  }

  Http _http;
}