import 'package:angular/application_factory.dart';

import 'dart:html';
import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';


void main() {

  try {
    LoggerExceptionHandler.setUpLogger();
    GameMetrics.initMixpanel();

    clearQueryStrings();

    applicationFactory().addModule(new WebClientApp()).run();
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}

void clearQueryStrings() {
  Uri uri = Uri.parse(window.location.toString());
  // Limpiamos la uri si viene con Query Strings (utm_campaign...)
  if (uri.hasQuery && uri.queryParameters.keys.any((param) => param.startsWith("utm"))) {

    GameMetrics.logEvent("social");

    Map<String, String> newQueryParams = new Map.fromIterable(
        uri.queryParameters.keys.where((param) => !param.startsWith("utm")),
        key: (item) => item,
        value: (item) => uri.queryParameters[item]);

    window.history.replaceState(null, //Pasamos null porque el getter de state no funciona en Dart:
                                      // https://groups.google.com/a/dartlang.org/forum/#!msg/bugs/zvNSxQMQ5FY/6D4mo0IAbxcJ
        window.document.documentElement.title, new Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: (newQueryParams.length > 0)? newQueryParams : null,
        fragment: (uri.fragment.length > 0)? uri.fragment : null ).toString());
  }
}