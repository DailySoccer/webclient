import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:logging/logging.dart';

// Logger global para cuando queramos mandar un mensaje al servidor
Logger serverLogger = new Logger('DailySoccer');

/**
 * Implementation of [ExceptionHandler] that sends exceptions to server.
 */
@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {
  LoggerExceptionHandler() {
    serverLogger.onRecord.listen((r) {
      print("[${r.loggerName}] ${r.time}: ${r.message}");
      DailySoccerServer.log(r);
    });
  }

  call(error, stack, [reason]) {
    serverLogger.severe("$error $reason \nORIGINAL STACKTRACE:\n $stack");
  }
}
