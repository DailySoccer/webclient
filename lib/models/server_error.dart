library connection_error;

import 'dart:convert' show JSON;
import 'package:angular/angular.dart';

class ServerError {
  static final String ERROR_RETRY_OP = "ERROR_RETRY_OP";

  bool get isResponseError => (type == RESPONSE_ERROR);
  bool get isServerNotFoundError => (type == SERVER_NOT_FOUND_ERROR);
  bool get isServerExceptionError => (type == SERVER_EXCEPTION_ERROR);
  bool get isConnectionError => (type == CONNECTION_ERROR);
  bool get isUnauthorizedError => (type == UNAUTHORIZED_ERROR);

  String get responseError => httpError.toString();

  bool get isRetryOpError => responseError.contains(ERROR_RETRY_OP);

  ServerError(this.type, this.httpError);

  String type;
  dynamic httpError;

  String toString() => type;

  int get hashCode => type.hashCode;

  bool operator == (other) {
    if (other is! ServerError) return false;
    return (other as ServerError).type == type;
  }

  Map toJson() {
    String errorString = UNKNOWN_ERROR_JSON;

    if (isResponseError) {
      HttpResponse httpResponse = httpError as HttpResponse;
      errorString = httpResponse.data;
    }
    else if (isServerNotFoundError) {
      errorString = SERVER_NOT_FOUND_ERROR_JSON;
    }
    else if (isServerExceptionError) {
      errorString = SERVER_EXCEPTION_ERROR_JSON;
    }
    else if (isUnauthorizedError) {
      errorString = UNAUTHORIZED_ERROR_JSON;
    }
    else if (isConnectionError) {
      errorString = CONNECTION_ERROR_JSON;
    }

    return JSON.decode(errorString);
  }

  factory ServerError.fromHttpResponse(var error) {
    String type = UNKNOWN_ERROR;

    if (error is HttpResponse) {
      HttpResponse httpResponse = error as HttpResponse;

      if (httpResponse.status == 400) {
        if (httpResponse.data != null && httpResponse.data != "") {
          type = RESPONSE_ERROR;
        }
      }
      else if (httpResponse.status == 404) {
        type = SERVER_NOT_FOUND_ERROR;
      }
      else if (httpResponse.status == 500) {
        type = SERVER_EXCEPTION_ERROR;
      }
      else if (httpResponse.status == 401) {
        type = UNAUTHORIZED_ERROR;
      }
      else {
        type = CONNECTION_ERROR;
      }
    }
    else {
      type = SERVER_EXCEPTION_ERROR;
    }

    return new ServerError(type, error);
  }

  static const String UNKNOWN_ERROR = "UNKNOWN_ERROR";
  static const String RESPONSE_ERROR = "RESPONSE_ERROR";
  static const String SERVER_NOT_FOUND_ERROR = "SERVER_NOT_FOUND_ERROR";
  static const String SERVER_EXCEPTION_ERROR = "SERVER_EXCEPTION_ERROR";
  static const String CONNECTION_ERROR = "CONNECTION_ERROR";
  static const String UNAUTHORIZED_ERROR = "UNAUTHORIZED_ERROR";

  static const UNKNOWN_ERROR_JSON = "{\"error\": \"Unknown error\"}";
  static const SERVER_NOT_FOUND_ERROR_JSON = "{\"error\": \"Server not found error\"}";
  static const SERVER_EXCEPTION_ERROR_JSON = "{\"error\": \"Server exception error\"}";
  static const CONNECTION_ERROR_JSON = "{\"error\": \"Connection error\"}";
  static const UNAUTHORIZED_ERROR_JSON = "{\"error\": \"Unauthorized error\"}";
}