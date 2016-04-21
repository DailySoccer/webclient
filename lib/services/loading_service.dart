library loading_service;

import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';
import 'package:webclient/utils/host_server.dart';

@Injectable()
class LoadingService {

  bool get isLoading => _enabled;
  void set isLoading(bool value) {
    _enabled = value;
    _refresh();
  }

  static void disable() {
    if (_instance != null) {
      _instance.isLoading = false;
    }
    else {
      print("TODO: Llega un disable demasiado pronto");
    }
  }

  LoadingService() {
    _instance = this;
    
    new Timer(new Duration(milliseconds: 1000), () {
      if (HostServer.isAndroidPlatform || HostServer.isiOSPlatform) {
        JsUtils.runJavascript(null, "hide", null, ["navigator", "splashscreen"]);
        JsUtils.runJavascript(null, "hide", null, ["StatusBar"]);
      }
    });
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