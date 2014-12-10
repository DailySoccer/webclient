import 'package:angular/application_factory.dart';

import 'dart:html';
import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/uri_utils.dart';


void main() {

  try {
    LoggerExceptionHandler.setUpLogger();

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

    UriUtils.removeQueryParameters(uri, ["utm"]);
  }
}