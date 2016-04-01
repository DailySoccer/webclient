import 'package:angular/application_factory.dart';

import 'dart:html';
import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/uri_utils.dart';
import 'package:webclient/utils/translate_config.dart';



void main() {

  try {
    LoggerExceptionHandler.setUpLogger();
    TranslateConfig.initialize().then((value) {
        config = value;
        clearQueryStrings();

        applicationFactory().addModule(new WebClientApp()).run();
      });

  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}

void clearQueryStrings() {
  Uri uri = Uri.parse(window.location.toString());

  // Limpiamos la uri si viene con Query Strings (utm_campaign...)
  if (uri.hasQuery && uri.queryParameters.keys.any((param) => param.startsWith("utm"))) {
    
    List<String> utmKeys = uri.queryParameters.keys.where((k) => k.startsWith("utm"));
    Map<String, String> utmParams = new Map.fromIterable(utmKeys, key: (k) => k, value: (k) => uri.queryParameters[k]);
    GameMetrics.logEvent(GameMetrics.COMING_FROM_SOCIAL_UTM, utmParams);

    UriUtils.removeQueryParameters(uri, ["utm"]);
  }
  if (uri.hasQuery && uri.queryParameters.keys.any((param) => param.startsWith("mixp_landing"))) {

    GameMetrics.logEvent(GameMetrics.ENTER_FROM_FUTBOL_CUATRO, {"button_id": uri.queryParameters['mixp_landing']});

    UriUtils.removeQueryParameters(uri, ["mixp_landing"]);
  }
}