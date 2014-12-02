library element_autofocus_decorator;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: '[auto-focus]')
class AutoFocusDecorator implements AttachAware{
  InputElement inputElement;

  AutoFocusDecorator(Element this.inputElement);

  @override
  void attach() {
    // TODO: (A modo de test) Poner un timer que retarde en 500ms la acción de autofocus.
    inputElement.focus();
  }
}
