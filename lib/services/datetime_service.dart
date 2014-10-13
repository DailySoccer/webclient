library date_service;

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';


@Injectable()
class DateTimeService {

  static DateTime get now => _instance._internalNow;
  static DateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) => new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: _UTC);

  // Hora actual que cambia cada segundo, util para imprimir el reloj directamente desde una vista con binding. Si estamos
  // recibiendo la hora desde el servidor, cambia un poco mas lento (cada 3 segundos)
  DateTime get nowEverySecond => _nowEverySecond;

  DateTimeService(this._server) {
    if (_instance != null)
      throw new Exception("WTF 1233");

    _instance = this;

    /*
    _timerVerifySimulatorActivated = new Timer.periodic(const Duration(seconds:3), (Timer t) => _verifySimulatorActivated());
    _verifySimulatorActivated();
    */

    new Timer.periodic(new Duration(seconds:1), (t) => _nowEverySecond = now);
  }

  static bool isToday(DateTime date) {
    var theNow = now;
    return (date.year == theNow.year && date.month == theNow.month && date.day == theNow.day);
  }

  static Duration getTimeLeft(DateTime date) {
    return date.difference(now);
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
      .then((jsonObject) {
        _simulatorActivated = jsonObject.simulator_activated;

        // Cuando se active el simulador...
        if (_simulatorActivated) {
          print("Simulator Activated");

          // Cancelamos el timer de verificacion (asumimos que siempre estará ejecutándose)
          _timerVerifySimulatorActivated.cancel();

          // Timer para solicitar el "currentDate"
          _timerUpdateFromServer = (_simulatorActivated)
              ? new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateDateFromServer())
              : null;
        }
      });
  }

  void _updateDateFromServer () {
    _server.getCurrentDate()
      .then((jsonObject) {
        _fakeDateTime = fromMillisecondsSinceEpoch(jsonObject.currentDate);
      });
  }

  DateTime get _internalNow {
    if (_fakeDateTime != null) {
      return _fakeDateTime;
    }

    return _UTC? new DateTime.now().toUtc() : new DateTime.now();
  }


  Timer _timerVerifySimulatorActivated;
  Timer _timerUpdateFromServer;
  DateTime _fakeDateTime;
  DateTime _nowEverySecond;
  bool _simulatorActivated = false;

  ServerService _server;

  static DateTimeService _instance;
  static final bool _UTC = false;
}