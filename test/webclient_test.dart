library webclient_test;

import 'package:unittest/unittest.dart';

import "package:json_object/json_object.dart";


import 'package:webclient/models/match_event.dart';

import 'package:webclient/services/user_manager.dart';
import 'package:webclient/services/match_manager.dart';

part 'unit/match_day_test.dart';
part 'unit/match_manager_test.dart';
part 'unit/user_manager_test.dart';

main() {
  testMatchDay();
  testMatchManager();
  // testUserManager();

  // filterTests("valid");
}
