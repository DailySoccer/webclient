library element_autofocus_decorator;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'dart:async';

@Directive(selector: '[auto-focus]')
class AutoFocusDecorator implements OnInit {
  InputElement inputElement;

  AutoFocusDecorator(Element this.inputElement);

  @override void ngOnInit() {
    new Timer(new Duration(seconds: 1), inputElement.focus);
  }
}
