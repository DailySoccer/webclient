library bleach_decorator;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: '[bleach]')
class BleachDecorator implements DetachAware{
  Element _theElement;
  Element _rootElement;

  BleachDecorator(this._theElement, this._rootElement) {
    _element = document.querySelector('#mainWrapper');
    if(_element != null) {
      _element.classes.add('bleach');
    }
  }

  @override void detach() {
    if(_element != null) {
      _element.classes.remove('bleach');
    }
  }

  Element _element;
}
