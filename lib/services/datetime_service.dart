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
  DateTime fakeDateTime;
  DateTime get now {
    return (fakeDateTime == null) ? new DateTime.now() : fakeDateTime;
  }

  DateTimeService();
}