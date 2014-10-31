import 'package:angular/application_factory.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';

void main() {

  try {
    LoggerExceptionHandler.setUpLogger();
    GameMetrics.initMixpanel();

    applicationFactory().addModule(new WebClientApp()).run();
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}