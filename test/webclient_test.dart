library webclient_test;

import 'dart:math';
import 'dart:async';
import 'package:unittest/unittest.dart';
import 'package:angular/mock/module.dart';

import "package:json_object/json_object.dart";

import 'package:webclient/mock/mock_server.dart';

import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/match_service.dart';
import 'package:webclient/services/match_group_service.dart';
import 'package:webclient/services/contest_service.dart';

import 'package:webclient/models/user.dart';
import 'package:webclient/models/match_event.dart';
import 'dart:html';

part 'unit/profile_service_test.dart';
part 'unit/match_service_test.dart';
part 'unit/match_group_service_test.dart';
part 'unit/contest_service_test.dart';
part 'unit/match_event_test.dart';

main() {
  testMatchDay();
  testMatchService();
  testMatchGroupService();
  testContestService();
  testProfileService();

  // filterTests("valid");
}
