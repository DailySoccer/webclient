library form_autofill_decorator;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:async';

/*
 *  Actualizar los campos asociados ("ng-model") a los inputs de los formularios
 *    que no funcionan correctamente cuando se produce el "autofill" en algunos browsers.
 *
 * Problema:
 *  - Los inputs se autorellenan (automáticamente por parte de los browsers)
 *  - Los campos asociados ("ng-model") no se han enterado del cambio automático (producido por el autofill)
 *  - El botón submit no se entera de que se tiene que activar, porque las variables bindeadas por el atributo ng-model no actualizan su valor.
 *
 * Solucion:
 *  -al instanciarse el componente, decimos a los inputs que "han cambiado" para que reaccionen los ng-model
 *
 * Fuentes:
 *  - http://victorblog.com/2014/01/12/fixing-autocomplete-autofill-on-angularjs-form-submit/
 *  - https://github.com/angular/angular.js/issues/1460#issuecomment-42970168
 *  - https://gist.github.com/stefanotorresi/1de83e989fd780873af6
  */

@Decorator(selector: '[formAutofillFix]')
class FormAutofillDecorator {
  Element formElement;

  FormAutofillDecorator(Element this.formElement){
   new Timer(const Duration(seconds:0), () => forceInputActivity());
  }

  void forceInputActivity() {
    // Buscar todos los controles 'inputs'
    List<InputElement> inputs = formElement.querySelectorAll('input');
    for (var input in inputs) {
      // Indicar al input que ha cambiado (por si acaso = "autocomplete form")
      //print("event Change: ${input.id}");
      input.dispatchEvent(new Event('input'));
      input.dispatchEvent(new Event('change'));
      input.dispatchEvent(new Event('keydown'));
    }

  }
}