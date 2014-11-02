library host_server;

import 'dart:html';
import 'package:logging/logging.dart';

class HostServer {

  // Global que apunta al servidor Host. Obligatorio usarla cuando vas a hacer una llamada al servidor
  static String get url {

    if (_url == null) {
      if (window.location.protocol.contains("file") || window.location.protocol.contains("chrome-extension")) {
        _url = "http://backend.epiceleven.com";
      }
      else if(window.location.href.contains("live=true") ||
              window.location.origin.contains("epiceleven.com")) {
        _url = "http://backend.epiceleven.com";
      }
      else if (_isLocalHost) {
        _url = "http://localhost:9000";
      }
      else {
        _url = window.location.origin;
      }

      Logger.root.info("Nuestro Host es: $_url");
    }

    return _url;
  }

  static bool get _isLocalHost => (window.location.hostname.contains("127.") || window.location.hostname.contains("localhost"));
  static bool get _isForcedProd => window.location.href.contains("prod=true");
  static bool get isDev => _isLocalHost && !_isForcedProd;
  static bool get isProd => !isDev;

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