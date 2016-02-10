library js_utils;

import 'dart:js' as js;

class JsUtils {
  // Funcion para ejecutar los JavaScripts que necesitamos en esta página
  static dynamic runJavascript(String selector, String method, dynamic params, [dynamic contexto]) {

    dynamic jsContext = js.context;

    if (contexto != null) {
      jsContext = (contexto is List) ? contexto.fold(jsContext, (prev, el) => prev[el]) : jsContext[contexto];
    }

    if (selector != null) {
      jsContext = jsContext.callMethod(r'$', [selector]);
    }

    if (params == null) {
      return jsContext.callMethod(method);
    }

    return jsContext.callMethod(method, (params is List) ? new js.JsObject.jsify(params) : (params is Map) ? [new js.JsObject.jsify(params)] : [params]);
  }

  static dynamic runJavascriptOld(String selector, String method, dynamic params, [bool option, String contexto]) {

      // Si tenemos el contexto lo llamamos directamente
      if (contexto != null) {
        return js.context[contexto].callMethod(method, (params is List)?params:(params is Map)?[new js.JsObject.jsify(params)]:[params]);
      }

      // Si tenemos el tercer parametro
      if (option != null) {
        return js.context.callMethod(r'$', [selector]).callMethod(method, [new js.JsObject.jsify(params), true]);
      }

      // Llamada sin objeto del DOM, es decir, a funcion global? (showSpinner, por ejemplo)
      if (selector == null) {
        if (params == null) {
          return js.context.callMethod(method);
        }
        else {
          return js.context.callMethod(method, params);
        }
      }
      else {
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
  
  static void setJavascriptFunction(String functionName, Function function) {
    js.context[functionName] = function;
  }
  
  static bool existsContext(dynamic contexto) {
    dynamic jsContext = js.context;
    bool exist = true;
    
    if (contexto != null) {
      if (contexto is List) {
        for (int i = 0; i < contexto.length; i++) {
          exist = jsContext.hasProperty(contexto[i]);
          if (!exist) { 
            break;
          } else {
            jsContext = jsContext[contexto[i]];
          }
        }
      } else {
        exist = jsContext.hasProperty(contexto);
      }
    }
    
    return exist;
  }
}




