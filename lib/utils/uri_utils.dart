library uri_utils;
import 'dart:html';

class UriUtils {

  static void removeQueryParameters(Uri uri, List parameters) {
    Map<String, String> newQueryParams = new Map.fromIterable(
        uri.queryParameters.keys.where((param) => !_paramInList(param, parameters)),
        key: (item) => item,
        value: (item) => uri.queryParameters[item]);

    window.history.replaceState(null, // Pasamos null porque el getter de state no funciona en Dart:
                                      // https://groups.google.com/a/dartlang.org/forum/#!msg/bugs/zvNSxQMQ5FY/6D4mo0IAbxcJ
        window.document.documentElement.title, new Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: (newQueryParams.length > 0)? newQueryParams : null,
        fragment: (uri.fragment.length > 0)? uri.fragment : null ).toString());
  }

  static bool _paramInList(String param, List parameters) {
    return parameters.any((x) => param.startsWith(x));
  }

}