library refresh_timers_service;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';

@Injectable()
class RefreshTimersService {

  static Map<String, int> timersDef = {
    'SECONDS_TO_REFRESH_CONTEST_LIST'         : 10
    ,'SECONDS_TO_REFRESH_LIVE'                : 10
    ,'SECONDS_TO_REFRESH_MY_CONTESTS'         : 10
    ,'SECONDS_TO_UPDATE_SIMULATOR_STATE'      : 3
    ,'SECONDS_TO_UPDATE_PROMOS'               : 600
    ,'SECONDS_TO_REFRESH_PROMOS'              : 30
  };

  static const String SECONDS_TO_REFRESH_CONTEST_LIST         = "SECONDS_TO_REFRESH_CONTEST_LIST";
  static const String SECONDS_TO_REFRESH_LIVE                 = "SECONDS_TO_REFRESH_LIVE";
  static const String SECONDS_TO_REFRESH_MY_CONTESTS          = "SECONDS_TO_REFRESH_MY_CONTESTS";
  static const String SECONDS_TO_UPDATE_SIMULATOR_STATE       = "SECONDS_TO_UPDATE_SIMULATOR_STATE";
  static const String SECONDS_TO_UPDATE_PROMOS                = "SECONDS_TO_UPDATE_PROMOS";
  static const String SECONDS_TO_REFRESH_PROMOS               = "SECONDS_TO_REFRESH_PROMOS";

  RefreshTimersService();

 Timer addRefreshTimer(String name, Function updateFunction, [String timerName] ) {

    Timer timer = new Timer.periodic(new Duration(seconds: (timerName == null) ? timersDef[name] : timersDef[timerName]), (Timer t) => updateFunction());

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
    if (_timers.containsKey(name)) {
      _timers[name].cancel();
    }
  }

  Map<String, Timer> _timers = {};
}