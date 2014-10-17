import 'dart:html';
import 'package:logging/logging.dart';

class HostServer {

  // Global que apunta al servidor Host. Obligatorio usarla cuando vas a hacer una llamada al servidor
  static String get url {

    if (_url == null) {
      if (_isLocalHost()) {
        _url = "http://localhost:9000";
      }
      else if (window.location.origin.contains("epiceleven.com")) {
        _url = "http://backend.epiceleven.com";
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

  static bool isDev() {
    return _isLocalHost();
  }

  static bool isProd() {
    return !isDev();
  }

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
  * Funcionan todos los browsers en CORS. En general, problemas con CORS potenciales.
  * Tener incrementa la complejidad, en general.

- Opcion 2

  Tener 1 dominio y dentro de dart que toda asset lleve un @ResolveAssetUrl (o como sea) y por supuesto
  como esta ahora que cuando se quiere acceder a la api del servidor tb se llama a host_server para obtener la URL.

 PRO:
 * No nos liamos con el CORS.
 * Nos podemos dejar cosas sin meter el CDN. Hay que acordarse!!!
 * Si queremos saltar el CDN, podemos saltarlo... puede ser util quiza?

 CON:
 * Hay que cambiar todos los assets en el codigo.
 * Que pasa los assets que estan en el CSS??
*/


