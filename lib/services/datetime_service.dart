library date_service;

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/utils/host_server.dart';

@Injectable()
class DateTimeService {

  static DateTime get now => _instance._internalNow;
  static DateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) => new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: _UTC);

  DateTimeService(this._server, this._refreshTimersService) {
    if (_instance != null)
      throw new Exception("WTF 1233");

    _instance = this;

    if (HostServer.isDev) {
      _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED, _verifySimulatorActivated);
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
    return new DateFormat("yy", "es_ES").format(date);
  }

  static String formatDateWithDayOfTheMonth(DateTime date) {
    return new DateFormat("EEE, d MMM", "es_ES").format(date);
  }

  static String formatDateShort(DateTime date) {
    return new DateFormat("dd/MM").format(date);
  }

  static String formatTimeShort(DateTime date) {
    return "${new DateFormat("HH:mm").format(date)}h";
  }

  static String formatDateTimeShort(DateTime date) {
    return "${new DateFormat("E, HH:mm", "es_ES").format(date)}h";
  }

  static String formatDateTimeLong(DateTime date) {
    return "${new DateFormat("E, dd/MM/yy HH:mm", "es_ES").format(date)}h";
  }

  static String formatTimeLeft(Duration timeLeft) {
    NumberFormat nfDay = new NumberFormat("0");
    NumberFormat nfTime = new NumberFormat("00");

    var days = timeLeft.inDays;
    var hours = nfTime.format(timeLeft.inHours % 24);
    var minutes = nfTime.format(timeLeft.inMinutes % 60);
    var seconds = nfTime.format(timeLeft.inSeconds % 60);

    return (days > 0)? nfDay.format(days) + (days > 1 ? " DIAS ": " DIA ") + hours + ":" + minutes + ":" + seconds
                     : hours + ":" + minutes + ":" + seconds;
  }

  void _verifySimulatorActivated() {
    _server.isSimulatorActivated()
      .then((jsonMap) {
        _simulatorActivated = jsonMap["simulator_activated"];

        // Cuando se active el simulador...
        if (_simulatorActivated) {
          print("Simulator Activated");

          // Cancelamos el timer de verificacion (asumimos que siempre estará ejecutándose)
          _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_VERIFY_SIMULATOR_ACTIVATED);

          // Timer para solicitar el "currentDate"
          _timerUpdateFromServer = (_simulatorActivated)
              ? _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_DATE_FROM_SERVER, _updateDateFromServer)
              : null;
          }
      });
  }

  void _updateDateFromServer () {
    _server.getCurrentDate()
      .then((jsonMap) {
        _fakeDateTime = fromMillisecondsSinceEpoch(jsonMap["currentDate"]);
      });
  }

  DateTime get _internalNow {
    if (_fakeDateTime != null) {
      return _fakeDateTime;
    }

    return _UTC? new DateTime.now().toUtc() : new DateTime.now();
  }

  Timer _timerUpdateFromServer;
  DateTime _fakeDateTime;
  bool _simulatorActivated = false;

  ServerService _server;
  RefreshTimersService _refreshTimersService;

  static DateTimeService _instance;
  static final bool _UTC = false;
}