import 'package:angular/application_factory.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'dart:html';

void main() {

  try {
    Stopwatch sw = new Stopwatch()..start();

    LoggerExceptionHandler.setUpLogger();
    GameMetrics.initMixpanel();

    clearQueryStrings();

    var app = applicationFactory().addModule(new WebClientApp());
    print("Init00 ${sw.elapsedMilliseconds}");

    app.run();
    print("Init01: ${sw.elapsedMilliseconds}");
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

    window.location.replace(new Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: (newQueryParams.length > 0)? newQueryParams : null,
        fragment: uri.fragment).toString());
  }
}