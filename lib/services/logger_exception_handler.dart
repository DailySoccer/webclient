import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:logging/logging.dart';

/**
 * Implementation of [ExceptionHandler] that sends exceptions to server.
 */


Logger serverLogger = new Logger('DailySoccer');

@Injectable()
class LoggerExceptionHandler extends ExceptionHandler {
  LoggerExceptionHandler() {
    serverLogger.onRecord.listen( (r) {
         print("[${r.loggerName}] ${r.time}: ${r.message}");
             DailySoccerServer.logPost(r);
              });
  }

  call(error, stack, [reason]){
    serverLogger.severe("$error $reason \nORIGINAL STACKTRACE:\n $stack");
  }
}
