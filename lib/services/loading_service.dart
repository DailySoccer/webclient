library loading_service;

import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';

@Injectable()
class LoadingService {
  static bool get enabled => _enabled;
  static void set enabled(bool value) {
    _enabled = value;

    if (_enabled) {
      JsUtils.runJavascript(null, "showSpinner", null);
    }
    else {
      JsUtils.runJavascript(null, "hideSpinner", null);
    }
  }

  LoadingService();

  static bool _enabled;
}