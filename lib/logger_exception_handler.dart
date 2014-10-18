import 'dart:html';

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';

//
// Nuestro handler sera inyectado en Angular. Angular nos llamara entonces cada vez que se produzca una excepcion
// dentro de su zona.
//
@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {

  call(dynamic exc, dynamic stackTrace, [String reason = '']) {
    logExceptionToServer(exc, stackTrace, reason);
  }

  static void setUpLogger() {

    // Todos los mensajes pasan por onRecord, decidimos dentro de suya que hacer
    Logger.root.level = Level.ALL;

    // Si quisieramos tener mas de un logger, mirar bien este flag
    // hierarchicalLoggingEnabled = true;

    Logger.root.onRecord.listen((LogRecord r) {

      // FINE es suficiente. Si logeamos ALL o FINEST llegan cosas de Angular que polucionan demasiado
      if (r.level >= Level.FINE) {
        print("[${r.level}] ${r.time}: ${r.message}");
      }

      // Por convenio, si se quiere mandar un mensaje al servidor, basta usar el Logger.root con Level == SEVERE.
      if (r.level >= Level.SEVERE) {
        HttpRequest.postFormData("${HostServer.url}/log", {"message": "${r.message}", "level": "${r.level}", "time": "${r.time}"})
              .catchError((error) => print(error));
      }
    });
  }

  static void logExceptionToServer(dynamic exc, dynamic stackTrace, [String reason = '']) {
    // Las excepciones siempre las mandamos con SHOUT para que el servidor pueda distinguirlas de todos los Levels menores
    Logger.root.shout("$exc $reason \nORIGINAL STACKTRACE:\n$stackTrace");

    /*
    if (HostServer.isDev()) {
      window.alert(stackTrace.toString());
    }
    */
  }
}
