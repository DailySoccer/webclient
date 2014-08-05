library debug_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:json_object/json_object.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/server_service.dart';


@Injectable()
class DebugService {
  bool get activated => _activated;
  void set activated(bool value) {
    _activated = value;

    _timer = (_activated)
        ? new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateState())
        : null;

    if (_activated) print("DebugService Activated");
  }

  DebugService(this._server, this._dateTimeService);

  void _updateState () {
    _server.getCurrentDate()
      .then((jsonObject) {
        _dateTimeService.fakeDateTime = new DateTime.fromMillisecondsSinceEpoch(jsonObject.currentDate, isUtc: true);
        print("now...: ${_dateTimeService.now}");
      });
  }

  bool _activated = false;
  Timer _timer;

  ServerService _server;
  DateTimeService _dateTimeService;
}