import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/core_dom/static_keys.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/template_cache.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/game_metrics.dart';

void main() {

  try {
    LoggerExceptionHandler.setUpLogger();

    GameMetrics.initMixpanel();

    var app = applicationFactory().addModule(new WebClientApp());
    var injector = app.run();

    // El cache de templates solo lo primeamos en produccion, pq es donde tenemos garantizado que se habra
    // hecho una build y por lo tanto el fichero lib/template_cache.dart tendra todos los contenidos frescos
    if (HostServer.isProd) {
      setUpCache(injector);
    }
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}

void setUpCache(injector) {
  TemplateCache cache = injector.getByKey(TEMPLATE_CACHE_KEY);
  primeTemplateCache(cache);
}

