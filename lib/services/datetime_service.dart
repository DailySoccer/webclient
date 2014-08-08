library date_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:json_object/json_object.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/server_service.dart';


@Injectable()
class DateTimeService {

  DateTime get now {
    return (_fakeDateTime == null) ? new DateTime.now() : _fakeDateTime;
  }

  DateTimeService(this._server) {
    _timerVerifySimulatorActivated = new Timer.periodic(const Duration(seconds:3), (Timer t) => _verifySimulatorActivated());
    _verifySimulatorActivated();
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
      //print("now...: $now");
      });
  }

  Timer _timerVerifySimulatorActivated;
  Timer _timerUpdateFromServer;
  DateTime _fakeDateTime;
  bool _simulatorActivated = false;

  ServerService _server;
}