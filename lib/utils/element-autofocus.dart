library element_autofocus_decorator;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: '[auto-focus]')
class AutoFocusDecorator implements AttachAware{
  InputElement inputElement;

  AutoFocusDecorator(Element this.inputElement);

  @override
  void attach() {
    //inputElement.autofocus = true;
    inputElement.focus();
    print('Focus en: ${inputElement.id}');
  }
}
