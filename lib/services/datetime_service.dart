library date_service;

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';


@Injectable()
class DateTimeService {

  DateTime get now => (_fakeDateTime == null) ? new DateTime.now() : _fakeDateTime;

  // Hora actual que cambia cada segundo, util para imprimir el reloj directamente desde una vista con binding. Si estamos
  // recibiendo la hora desde el servidor, cambia un poco mas lento (cada 3 segundos)
  DateTime get nowEverySecond => _nowEverySecond;

  DateTimeService(this._server) {
    _timerVerifySimulatorActivated = new Timer.periodic(const Duration(seconds:3), (Timer t) => _verifySimulatorActivated());
    _verifySimulatorActivated();

    new Timer.periodic(new Duration(seconds:1), (t) => _nowEverySecond = now);
  }

  Duration timeLeft(DateTime date) {
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
        _fakeDateTime = new DateTime.fromMillisecondsSinceEpoch(jsonObject.currentDate, isUtc: true);
      });
  }

  Timer _timerVerifySimulatorActivated;
  Timer _timerUpdateFromServer;
  DateTime _fakeDateTime;
  DateTime _nowEverySecond;
  bool _simulatorActivated = false;

  ServerService _server;
}