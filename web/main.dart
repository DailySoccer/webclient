import 'package:angular/application_factory.dart';
//import 'package:angular/routing/static_keys.dart';
import 'package:angular/core_dom/static_keys.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/generated.dart';
import 'package:angular/angular.dart';
//import 'package:webclient/utils/host_server.dart';

void main() {

  try {
    LoggerExceptionHandler.setUpLogger();

    var injector = applicationFactory().addModule(new WebClientApp()).run();

    setUpCache(injector);
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}

void setUpCache(injector) {
  TemplateCache cache = injector.getByKey(TEMPLATE_CACHE_KEY);
  primeTemplateCache(cache);
}

