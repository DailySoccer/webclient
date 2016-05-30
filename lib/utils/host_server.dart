library host_server;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:webclient/utils/js_utils.dart';

class HostServer {

  static String CURRENT_VERSION = "";

  static String DOMAIN = "http://52ae5bf3.ngrok.io"; // "http://dailysoccer-staging.herokuapp.com";
  
  // Global que apunta al servidor Host. Obligatorio usarla cuando vas a hacer una llamada al servidor
  static String get url {
    String REMOTE_SERVER = DOMAIN;
    
    if (_url == null) {
      if (window.location.protocol.contains("file") || window.location.protocol.contains("chrome-extension")) {
        _url = REMOTE_SERVER;
      }
      else if(window.location.href.contains("live=true") || isEpicEleven) {
        _url = REMOTE_SERVER;
      }
      else if (_isLocalHost) {
          _url = (window.location.href.contains("https=true"))? "https://backend.epiceleven.localhost:9000" :
                                                                "http://localhost:9000";
      }
      else {
        _url = window.location.origin;
      }

      Logger.root.info("Nuestro Host es: $_url | Production: $isProd | Protocol: ${window.location.protocol}");
    }

    return _url;
  }
  
  static String get domain {
    String REMOTE_SERVER = "http://futbolcuatro.epiceleven.com"; // "http://dailysoccer-staging.herokuapp.com";
        
    if (_domain == null) {
      if (window.location.protocol.contains("file") || window.location.protocol.contains("chrome-extension")) {
        _domain = REMOTE_SERVER;
      }
      else if(window.location.href.contains("live=true") || isEpicEleven) {
        _domain = REMOTE_SERVER;
      }
      else if (_isLocalHost) {
        _domain = (window.location.href.contains("https=true"))? "https://futbolcuatro.epiceleven.localhost:9000" :
                                                                "http://localhost:9000";
      }
      else {
        _domain = window.location.origin;
      }

      Logger.root.info("Nuestro Dominio es: $_domain");
    }

     return _domain;
  }

  static bool get _isLocalHost => (window.location.hostname.contains("127.") || window.location.hostname.contains("localhost"));
  static bool get _isForcedProd => window.location.href.contains("prod=true");
  static bool get _isNgrok => window.location.hostname.contains("ngrok");
  static bool get _isStaging => (window.location.hostname.contains("staging") || DOMAIN.contains("staging"));
  static bool get isDev => (_isNgrok || _isLocalHost || _isStaging) && !_isForcedProd;
  static bool get isProd => !isDev;
  static bool get isEpicEleven => window.location.hostname.contains("epiceleven.com") && !window.location.hostname.contains("staging");
  static bool get isAndroidPlatform => platform == "android";
  static bool get isiOSPlatform => platform == "ios";

  static String get platform {
    if (_platform == null || _platform.isEmpty) {
      JsUtils.runJavascript(null, "getPlatform", [(String platform) => _platform = platform.toLowerCase()]);
    }
    return _platform;
  }
  
  static String _platform;
  static String _domain;
  static String _url;
}

/*
- Opcion 1

  Tener dos dominios, www.epiceleven.com & backend.epiceleven.com
  PRO:
  * El CDN apunta a www.epiceleven.com, con lo cual TODO se carga desde ahi.
  * NO hay que cambiar nada en el codigo.
  *
  CONTRA:
  * En general, problemas con CORS: Preflights.

- Opcion 2

  Tener 1 dominio y dentro de dart que toda asset lleve un @ResolveAssetUrl (o como sea) y por supuesto
  como esta ahora que cuando se quiere acceder a la api del servidor tb se llama a host_server para obtener la URL.

 PRO:
 * No nos liamos con el CORS.
 * Si queremos saltar el CDN, podemos saltarlo... puede ser util quiza?

 CON:
 * Nos podemos dejar cosas sin meter el CDN. Hay que acordarse!!!
 * Hay que cambiar todos los assets en el codigo.
 * Que pasa los assets que estan en el CSS??
*/