library refresh_timers_service;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'dart:html';
import 'package:webclient/utils/js_utils.dart';

@Injectable()
class RefreshTimersService {

  static Map<String, int> timersDef = {
    'SECONDS_TO_REFRESH_CONTEST_LIST'         : 10
    ,'SECONDS_TO_REFRESH_LIVE'                : 10
    ,'SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES': 60
    ,'SECONDS_TO_REFRESH_MY_CONTESTS'         : 10
    ,'SECONDS_TO_UPDATE_SIMULATOR_STATE'      : 3
    ,'SECONDS_TO_UPDATE_PROMOS'               : 600
    ,'SECONDS_TO_REFRESH_PROMOS'              : 30
    ,'SECONDS_TO_REFRESH_TOPBAR'              : 5
    ,'SECONDS_TO_REFRESH_RANKING_POSITION'    : 10
  };

  static const String SECONDS_TO_REFRESH_CONTEST_LIST         = "SECONDS_TO_REFRESH_CONTEST_LIST";
  static const String SECONDS_TO_REFRESH_LIVE                 = "SECONDS_TO_REFRESH_LIVE";
  static const String SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES = "SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES";
  static const String SECONDS_TO_REFRESH_MY_CONTESTS          = "SECONDS_TO_REFRESH_MY_CONTESTS";
  static const String SECONDS_TO_UPDATE_SIMULATOR_STATE       = "SECONDS_TO_UPDATE_SIMULATOR_STATE";
  static const String SECONDS_TO_UPDATE_PROMOS                = "SECONDS_TO_UPDATE_PROMOS";
  static const String SECONDS_TO_REFRESH_PROMOS               = "SECONDS_TO_REFRESH_PROMOS";
  static const String SECONDS_TO_REFRESH_TOPBAR               = "SECONDS_TO_REFRESH_TOPBAR";
  static const String SECONDS_TO_REFRESH_RANKING_POSITION      = "SECONDS_TO_REFRESH_RANKING_POSITION";
  
  static const int SECONDS_TO_CHECK_FOCUS = 1;

  RefreshTimersService() {
    window.onBlur.listen( (_) => _focus = false );
    window.onFocus.listen( (_) => _focus = true );
    
    JsUtils.setJavascriptFunction('dartOnApplicationPause', () => _focus = false);
    JsUtils.setJavascriptFunction('dartOnApplicationResume', () => _focus = true);
  }

  Timer addRefreshTimer(String name, Function updateFunction, {String timerName, bool notFirstCall} ) {
    if (_timers.containsKey(name) && _timers[name].isActive) {
        Logger.root.warning("Timer: $name cancelled");
        _timers[name].cancel();
    }
    
    /*Timer timer = new Timer.periodic(new Duration(seconds: (timerName == null) ? timersDef[name] : timersDef[timerName]), (Timer t) {
      if (!isRefreshLocked(name)) {
        updateFunction();
      }
    });*/
    
    Timer timer = updateTimer(name, updateFunction, timerName);
    
    //_timers[name] = timer;

    // Realizamos la primera llamada a la función solicitada
    if (notFirstCall == null || !notFirstCall) {
      updateFunction();
    }

    if (TutorialService.isActivated) {
      TutorialService.Instance.registerContentUpdater(name, updateFunction);
    }

    return timer;
  }

  bool isRefreshLocked(String name) => (TutorialService.isActivated && TutorialService.Instance.isRefreshTimerLocked(name)) || !_focus;

  void cancelTimer(String name) {
    if (TutorialService.isActivated) {
      TutorialService.Instance.cancelContentUpdater(name);
    }

    if (_timers.containsKey(name)) {
      _timers[name].cancel();
    }
  }

  Timer updateTimer(String name, Function updateFunction, [String timerName]) {
    _timers[name] = new Timer(new Duration(seconds: !_focus? SECONDS_TO_CHECK_FOCUS : (timerName == null) ? timersDef[name] : timersDef[timerName]), () {
      if (!isRefreshLocked(name)) {
        updateFunction();
      }
      updateTimer(name, updateFunction, timerName);
    });
    
    return _timers[name];
  }
  
  Map<String, Timer> _timers = {};
  bool _focus = true;
}