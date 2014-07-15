library webclient_test;

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:unittest/html_enhanced_config.dart';

import "package:json_object/json_object.dart";

import 'package:webclient/mock/mock_server.dart';

import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';

import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';

part 'unit/profile_service_test.dart';
part 'unit/contest_service_test.dart';


main() {

  // Cazamos la excepcion que salta cuando estamos corriendo bajo karma al intentar reconfigurar (puesto
  // que karma configura primero)
  try {
    //useHtmlConfiguration();
    useHtmlEnhancedConfiguration();
  } catch (exc) {}

  testContestService();
  testProfileService();

  // filterTests("valid");
}
