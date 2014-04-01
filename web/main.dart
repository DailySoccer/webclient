library webclient_main;

import 'package:logging/logging.dart';
import 'package:webclient/webclient.dart';

// Temporary, please follow https://github.com/angular/angular.dart/issues/476
@MirrorsUsed(targets: const ['user'],  override: '*')
import 'dart:mirrors';

void main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  
  startWebClientApp();
}
