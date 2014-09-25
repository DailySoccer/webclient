library form_autofill_decorator;

import 'package:angular/angular.dart';
import 'dart:html';

/*
 *  Actualizar los campos asociados ("ng-model") a los inputs de los formularios
 *    que no funcionan correctamente cuando se produce el "autofill" en algunos browsers.
 *
 * Problema:
 *  - Los inputs se autorellenan (automáticamente por parte de los browsers)
 *  - Se pulsa "submit"
 *  - Los campos asociados ("ng-model") no se han enterado del cambio automático (producido por el autofill)
 *  - El formulario es considerado valido (sin datos válidos)
 *
 * Solucion:
 *  - El evento "click" se produce antes del "submit"
 *  - Detectar cuando se produce el evento "click" sobre el boton de "submit"
 *  - Informar a los "inputs" del formulario que "han cambiado" (para que actualicen correctamente las variables "ng-model" asociadas)
 *
 * Fuentes:
 *  - http://victorblog.com/2014/01/12/fixing-autocomplete-autofill-on-angularjs-form-submit/
 *  - https://github.com/angular/angular.js/issues/1460#issuecomment-42970168
 *  - https://gist.github.com/stefanotorresi/1de83e989fd780873af6
  */

@Decorator(selector: '[formAutofillFix]')
class FormAutofillDecorator implements AttachAware{
  Element formElement;

  FormAutofillDecorator(Element this.formElement);

  @override
  void attach() {
    // Buscamos el button principal del form
    ButtonElement button = formElement.querySelector('[type=submit]');
    if (button != null) {
      // Si alguien lo pulsa (para 'submit')
      button.onClick.listen( (e) {
        //print("onClick ${button.className}");
        // Buscar todos los controles 'inputs'
        List<InputElement> inputs = formElement.querySelectorAll('input');
        for (var input in inputs) {
          // Indicar al input que ha cambiado (por si acaso = "autocomplete form")
          //print("event Change: ${input.id}");
          input.dispatchEvent(new Event('input'));
          input.dispatchEvent(new Event('change'));
          input.dispatchEvent(new Event('keydown'));
        }
      });
    }
    else {
      print("Autofill: .btn-primary not found");
    }

    /*
    // El evento 'submit' llega tarde para avisar a los 'inputs
    formElement.onSubmit.listen( (e) {
      print("onSubmit ${formElement.className}");
      List<InputElement> inputs = formElement.querySelectorAll('input');
      for (var input in inputs) {
        input.dispatchEvent(new Event('input'));
        input.dispatchEvent(new Event('change'));
        input.dispatchEvent(new Event('keydown'));
        print("event Change: ${input.id}");
      }
    });
    */

    /*
    // Verificar que los distintos 'inputs' reciben la solicitu de 'change'
    List<InputElement> inputs = formElement.querySelectorAll('input');
    for (var input in inputs) {
      input.onChange.listen( (e) {
        print("changed: ${input.id}");
      });
    }
    */
  }
}