library element_autofocus_decorator;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:async';

@Decorator(selector: '[auto-focus]')
class AutoFocusDecorator implements AttachAware{
  InputElement inputElement;

  AutoFocusDecorator(Element this.inputElement);

  @override
  void attach() {
    new Timer(new Duration(seconds: 1), inputElement.focus);
  }
}
