library loading_service;

import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';

@Injectable()
class LoadingService {

  bool get isLoading => _enabled;
  void set isLoading(bool value) {
    _enabled = value;
    _refresh();
  }

  static void disable() {
    _instance.isLoading = false;
  }

  LoadingService() {
    _instance = this;
  }

  void _refresh() {
    if (_enabled) {
      JsUtils.runJavascript(null, "showSpinner", null);
    }
    else {
      JsUtils.runJavascript(null, "hideSpinner", null);
    }
  }

  static LoadingService _instance;
  bool _enabled = true; // Desde JS nos dejan con el spinner activado
}