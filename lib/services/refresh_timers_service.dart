library refresh_timers_service;

import 'dart:async';
import 'package:angular/angular.dart';

@Injectable()
class RefreshTimersService{

  static Map<String, int> timersDef = {
    'EVERY_SECOND'                              : 1
    ,'SECONDS_TO_REFRESH_CONTEST_LIST'          : 10
    ,'SECONDS_TO_REFRESH_NEXT_TOURNAMENT_INFO'  : 1
    ,'SECONDS_TO_REFRESH_LIVE'                  : 3
    ,'SECONDS_TO_UPDATE_FROM_SERVER'            : 3
    ,'SECONDS_TO_UPDATE_COUNTDOWN_DATE'         : 1
    ,'SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED'    : 3
  };

  static const String SECONDS_TO_REFRESH_CONTEST_LIST         = "SECONDS_TO_REFRESH_CONTEST_LIST";
  static const String SECONDS_TO_REFRESH_LIVE                 = "SECONDS_TO_REFRESH_LIVE";
  static const String SECONDS_TO_REFRESH_NEXT_TOURNAMENT_INFO = "SECONDS_TO_REFRESH_NEXT_TOURNAMENT_INFO";
  static const String SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED   = "SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED";
  static const String SECONDS_TO_UPDATE_COUNTDOWN_DATE        = "SECONDS_TO_UPDATE_COUNTDOWN_DATE";
  static const String SECONDS_TO_UPDATE_FROM_SERVER           = "SECONDS_TO_UPDATE_FROM_SERVER";
  static const String EVERY_SECOND                            = "EVERY_SECOND";

  RefreshTimersService() {
    if (_instance != null) {
      throw new Exception("WTF 0246");
    }

    _instance = this;
  }

  // Puede que alguna vez necesite crear un timer especificando segundos que no estén definidos aqui,
  // asique lo pasamos como parametro opcional.
  static Timer addRefreshTimer(String name, Function updateFunction, [int seconds] ) {

    Timer tmpTimer = new Timer.periodic(new Duration(seconds: (seconds == null) ? timersDef[name] : seconds), (Timer t) => updateFunction());

    if (_instance._timers.containsKey(name)) {
      _instance._timers[name].cancel();
      _instance._timers[name] = tmpTimer;
    }
    else {
      _instance._timers.addAll({name : tmpTimer});
    }
    return tmpTimer;
  }

  static void cancelTimer(String name) {
    _instance._timers[name].cancel();
  }

  Map<String, Timer> _timers = {};
  static RefreshTimersService _instance;
}