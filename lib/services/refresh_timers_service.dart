library refresh_timers_service;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';

@Injectable()
class RefreshTimersService {

  static Map<String, int> timersDef = {
    'SECONDS_TO_REFRESH_CONTEST_LIST'         : 10
    ,'SECONDS_TO_REFRESH_LIVE'                : 3
    ,'SECONDS_TO_REFRESH_DATE_FROM_SERVER'    : 3
    ,'SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED'  : 3
  };

  static const String SECONDS_TO_REFRESH_CONTEST_LIST         = "SECONDS_TO_REFRESH_CONTEST_LIST";
  static const String SECONDS_TO_REFRESH_LIVE                 = "SECONDS_TO_REFRESH_LIVE";
  static const String SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED   = "SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED";
  static const String SECONDS_TO_REFRESH_DATE_FROM_SERVER     = "SECONDS_TO_REFRESH_DATE_FROM_SERVER";

  RefreshTimersService();

  Timer addRefreshTimer(String name, Function updateFunction, [int seconds] ) {

    Timer timer = new Timer.periodic(new Duration(seconds: (seconds == null) ? timersDef[name] : seconds), (Timer t) => updateFunction());

    if (_timers.containsKey(name) && _timers[name].isActive) {
        Logger.root.warning("Timer: $name cancelled");
        _timers[name].cancel();
    }

    _timers[name] = timer;

    // Realizamos la primera llamada a la función solicitada
    updateFunction();

    return timer;
  }

  void cancelTimer(String name) {
    _timers[name].cancel();
  }

  Map<String, Timer> _timers = {};
}