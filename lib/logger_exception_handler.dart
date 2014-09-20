import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:logging/logging.dart';


@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {

  call(dynamic error, dynamic stack, [String reason = '']) {
    Logger.root.severe("$error $reason \nORIGINAL STACKTRACE:\n$stack");
  }

  static void setUpLogger() {
    // FINE es suficiente, si lo ponemos en ALL o FINEST llegan cosas de Angular que polucionan demasiado
    Logger.root.level = Level.FINE;

    // Si quisieramos tener mas de un logger, mirar bien este flag
    // hierarchicalLoggingEnabled = true;

    Logger.root.onRecord.listen((r) {
      print("[${r.loggerName}] ${r.time}: ${r.message}");

      // Por convenio, si se quiere mandar un mensaje al servidor, basta usar el logger root con level >= SEVERE.
      if (r.level >=  Level.SEVERE) {
        DailySoccerServer.log(r);
      }
    });
  }
}
