import 'package:angular/application_factory_static.dart';

import 'dart:html';
import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/uri_utils.dart';
import 'package:webclient/utils/translate_config.dart';
import 'main_generated_type_factory_maps.dart' show setStaticReflectorAsDefault;
import 'main_static_expressions.dart' as generated_static_expressions;
import 'main_static_metadata.dart' as generated_static_metadata;
import 'main_static_type_to_uri_mapper.dart' as generated_static_type_to_uri_mapper;



void main() {
  setStaticReflectorAsDefault();

  try {
    LoggerExceptionHandler.setUpLogger();
    TranslateConfig.initialize().then((value) {
        config = value;
        clearQueryStrings();

        staticApplicationFactory(generated_static_metadata.typeAnnotations, generated_static_expressions.getters, generated_static_expressions.setters, generated_static_expressions.symbols, generated_static_type_to_uri_mapper.typeToUriMapper).addModule(new WebClientApp()).run();
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

    GameMetrics.logEvent("social");

    UriUtils.removeQueryParameters(uri, ["utm"]);
  }
  if (uri.hasQuery && uri.queryParameters.keys.any((param) => param.startsWith("mixp_landing"))) {

    GameMetrics.logEvent(GameMetrics.ENTER_FROM_FUTBOL_CUATRO, {"button_id": uri.queryParameters['mixp_landing']});

    UriUtils.removeQueryParameters(uri, ["mixp_landing"]);
  }
}