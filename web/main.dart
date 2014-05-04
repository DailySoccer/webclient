import 'package:logging/logging.dart';
import 'package:angular/application_factory.dart';

import 'package:webclient/webclient.dart';

void main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });

  setUpHostServerUrl();
  applicationFactory().addModule(new WebClientApp()).run();
}
