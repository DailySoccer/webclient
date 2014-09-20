import 'dart:html';
import 'package:logging/logging.dart';

class HostServer {

  // Global que apunta al servidor Host. Obligatorio usarla cuando vas a hacer una llamada al servidor
  static String get url {

    if (_url == null) {
      if (_isLocalHost()) {
        _url = "http://localhost:9000";
      }
      else {
        _url = window.location.origin;
      }

      Logger.root.info("Nuestro Host es: $_url");
    }

    return _url;
  }

  static bool _isLocalHost() {
    return (window.location.hostname.contains("127.") || window.location.hostname.contains("localhost"));
  }

  static String _url;
}

