library date_service;

import 'package:intl/intl.dart';
import 'package:angular2/core.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:async';
import 'dart:html';
import 'package:logging/logging.dart';

@Injectable()
class DateTimeService {

  static DateTime get now => _instance._internalNow;
  static DateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) => new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: _UTC);
  static String get today => formatDateWithDayOfTheMonth(now);

  // Se considera que está OK si estamos en Producción o se ha recibido una respuesta del servidor (sobre si está activo el simulador)
  static bool get isReady => HostServer.isProd || (_instance != null && _instance._simulatorStateReceived);

  static Future waitingReady() {
    var completer = new Completer<bool>();

    if (isReady) {
      // Logger.root.info("DateTimeService.isReady!!");
      completer.complete( true );
    }
    else {
      new Timer.periodic(new Duration(milliseconds: 30), (Timer t) {
            if (isReady) {
              // Logger.root.info("DateTimeService.isReady");
              t.cancel();
              completer.complete( true );
            }
            else {
              // Logger.root.info("waiting DateTimeService.isReady...");
            }
          });
    }

    return completer.future;
  }

  DateTimeService(this._server, this._refreshTimersService) {
    if (_instance != null)
      throw new Exception("WTF 1233");

    _instance = this;

    if (HostServer.isDev) {
      _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_UPDATE_SIMULATOR_STATE, _updateSimulatorState);
    }
  }

  static bool isToday(DateTime date) {
    var theNow = now;
    return (date.year == theNow.year && date.month == theNow.month && date.day == theNow.day);
  }

  static Duration getTimeLeft(DateTime date) {
    return date.difference(now);
  }

  static String formatDateYear(DateTime date) {
    return new DateFormat("yyyy", StringUtils.getLocale()).format(date);
  }

  static String formatDateWeekdayNameShort(DateTime date) {
    return new DateFormat("EEE", StringUtils.getLocale()).format(date);
  }

  static String formatDateWithDayOfTheMonth(DateTime date) {
    return new DateFormat(StringUtils.getDatePattern("datewithdayofthemonth"), StringUtils.getLocale()).format(date);
  }

  static String formatDateShort(DateTime date) {
    return new DateFormat(StringUtils.getDatePattern("dateshort")).format(date);
  }

  static String formatTimeShort(DateTime date) {
    return "${new DateFormat(StringUtils.getDatePattern("timeshort")).format(date)}h";
  }

  static String formatDateTimeShort(DateTime date) {
    return "${new DateFormat(StringUtils.getDatePattern("datetimeshort"), StringUtils.getLocale()).format(date)}h";
  }

  static String formatDateTimeLong(DateTime date) {
    return "${new DateFormat(StringUtils.getDatePattern("datetimelong"), StringUtils.getLocale()).format(date)}h";
  }

  static String formatDateTimeDayHour(DateTime date) {
    return "${new DateFormat(StringUtils.getDatePattern("datetimedayhour"), StringUtils.getLocale()).format(date)}h";
  }

  static String formatTimestamp(DateTime date) {
    return "${new DateFormat(StringUtils.getDatePattern("timestamp"), StringUtils.getLocale()).format(date)}";
  }

  static String formatTimeLeft(Duration timeLeft) {
    NumberFormat nfDay = new NumberFormat("0");
    NumberFormat nfTime = new NumberFormat("00");

    var days = timeLeft.inDays;
    var hours = nfTime.format(timeLeft.inHours % 24);
    var minutes = nfTime.format(timeLeft.inMinutes % 60);
    var seconds = nfTime.format(timeLeft.inSeconds % 60);

    return (days > 0)? nfDay.format(days) + (days > 1 ? StringUtils.translate("days", "common") : StringUtils.translate("day", "common") ) + hours + "h " + minutes + "m" /*+ ":" + seconds*/
                     : hours + ":" + minutes + ":" + seconds;
  }

  static void setFakeDateTime(DateTime fakeDateTime) {
    _instance._simulatorActivated = true;
    _instance._simulatorStateReceived = true;
    _instance._fakeDateTime = fakeDateTime;
  }

  void _updateSimulatorState() {
    _server.getSimulatorState()
      .then((jsonMap) {
        bool activated = jsonMap["init"];

        if (activated != _simulatorActivated) {
          _simulatorActivated = activated;

          if (_simulatorActivated) {
            Logger.root.info("Simulator Activated");
          }
          else {
            Logger.root.info("Simulator Deactivated");
            _fakeDateTime = null;
          }
        }

        if (_simulatorActivated) {
          _fakeDateTime = fromMillisecondsSinceEpoch(jsonMap["currentDate"]);
        }

        _simulatorStateReceived = true;
      });
  }

  DateTime get _internalNow {
    if (_fakeDateTime != null) {
      return _fakeDateTime;
    }

    return _UTC? new DateTime.now().toUtc() : new DateTime.now();
  }

  DateTime _fakeDateTime;
  bool _simulatorActivated = false;
  bool _simulatorStateReceived = false;

  ServerService _server;
  RefreshTimersService _refreshTimersService;

  static DateTimeService _instance;
  static final bool _UTC = false;
}