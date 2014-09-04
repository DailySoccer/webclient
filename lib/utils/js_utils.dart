library js_utils;

import 'dart:js' as js;

class JsUtils {
  // Funcion para ejecutar los JavaScripts que necesitamos en esta página
  static dynamic runJavascript(String selector, String method, dynamic params, [bool option]) {
    // Si tenemos el tercer parametro
    if (option != null) {
      return js.context.callMethod(r'$', [selector]).callMethod(method, [new js.JsObject.jsify(params), true]);

    }

    if (params == null) { //javascript / jquery sin parametros
      return js.context.callMethod(r'$', [selector]).callMethod(method);
    }
    else { //javascript / jquery con parametro de valor iterable
      if (params.toString().contains('[') || params.toString().contains('{')  ) // Si tienen un objeto iterable
        return js.context.callMethod(r'$', [selector]).callMethod(method, [new js.JsObject.jsify(params)]);
    } //javascript / jquery con parametro de valor simple
    return js.context.callMethod(r'$', [selector]).callMethod(method, [params]);
  }
}