library webclient_test;

import 'package:unittest/unittest.dart';
import 'dart:async';
import 'package:angular/mock/module.dart';

import "package:json_object/json_object.dart";

import 'package:webclient/mock/mock_server.dart';

import 'package:webclient/models/user.dart';
import 'package:webclient/models/match_day.dart';

import 'package:webclient/services/server_request.dart';
import 'package:webclient/services/user_manager.dart';
import 'package:webclient/services/match_manager.dart';
import 'package:webclient/services/group_manager.dart';
import 'package:webclient/services/contest_manager.dart';

part 'unit/user_manager_test.dart';
part 'unit/match_day_test.dart';
part 'unit/match_manager_test.dart';
part 'unit/group_manager_test.dart';
part 'unit/contest_manager_test.dart';

main() {
  testMatchDay();
  testMatchManager();
  testGroupManager();
  testContestManager();
  testUserManager();
  
  // filterTests("valid");
}
