import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'dart:html';
import 'package:webclient/utils/host_server.dart';

@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {

  call(dynamic exc, dynamic stackTrace, [String reason = '']) {
    logException(exc, stackTrace, reason);
  }

  static void setUpLogger() {
    // FINE es suficiente, si lo ponemos en ALL o FINEST llegan cosas de Angular que polucionan demasiado
    Logger.root.level = Level.FINE;

    // Si quisieramos tener mas de un logger, mirar bien este flag
    // hierarchicalLoggingEnabled = true;

    Logger.root.onRecord.listen((LogRecord r) {
      print("${r.time}: ${r.message}");

      // Por convenio, si se quiere mandar un mensaje al servidor, basta usar el logger root con level >= SEVERE.
      if (r.level >=  Level.SEVERE) {
        HttpRequest.postFormData("${HostServer.url}/log", {"errorMessage": "${r.message}", "level": "${r.level}", "time": "${r.time}"})
                   .catchError((error) => print(error));
      }
    });
  }

  static void logException(dynamic exc, dynamic stackTrace, [String reason = '']) {
    Logger.root.severe("$exc $reason \nORIGINAL STACKTRACE:\n$stackTrace");
  }
}
