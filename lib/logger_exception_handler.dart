import 'dart:html';

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/server_error.dart';

//
// Nuestro handler sera inyectado en Angular. Angular nos llamara entonces cada vez que se produzca una excepcion
// dentro de su zona.
//
@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {

  call(dynamic exc, dynamic stackTrace, [String reason = '']) {
    // Los FutureCancelled nos llegaran hasta aqui porque podemos no manejarlos en los catchErrors. Aqui
    // podemos simplemente descartarlos porque es un comportamiento esperado: Tener que cancelar llamadas
    // al servidor es normal.
    if (exc is! FutureCancelled) {
      logExceptionToServer(exc, stackTrace, reason);
    }
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

        String userEmail = "unknown@email.com";
        String userAgent = "Unknown user agent";

        try {
          if (ProfileService.instance != null && ProfileService.instance.user != null && ProfileService.instance.user.email != null) {
            userEmail = ProfileService.instance.user.email;
          }

          userAgent = window.navigator.userAgent;
        }
        catch(exc) {}

        HttpRequest.postFormData("${HostServer.url}/log", {"message": "${r.message}", "level": "${r.level}", "email": "${userEmail}", "userAgent": "${userAgent}" })
                   .catchError((error) => print(error));
      }
    });
  }

  static void logExceptionToServer(dynamic exc, dynamic stackTrace, [String reason = '']) {
    // Las excepciones siempre las mandamos con SHOUT para que el servidor pueda distinguirlas de todos los Levels menores
    Logger.root.shout("$exc $reason \nORIGINAL STACKTRACE:\n$stackTrace");
  }
}
