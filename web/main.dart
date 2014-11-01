import 'package:angular/application_factory.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/utils/game_metrics.dart';

void main() {

  try {
    Stopwatch sw = new Stopwatch()..start();

    LoggerExceptionHandler.setUpLogger();
    GameMetrics.initMixpanel();

    var app = applicationFactory().addModule(new WebClientApp());
    print("Init00 ${sw.elapsedMilliseconds}");

    app.run();
    print("Init01: ${sw.elapsedMilliseconds}");
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}