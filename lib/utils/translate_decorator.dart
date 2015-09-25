library translate_decorator;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/utils/translate_config.dart';

@Decorator(selector: '[translate]', map: const {'translate': '<=>translate'})
class TranslateDecorator {
  String translate;
  Element element;
  TranslateDecorator(this.element) {
    element.text = config.translate(element.attributes["translate"]);
    window.on['languageChangedEvent'].listen((e) {
      element.text = config.translate(element.attributes["translate"]);
    });
  }
}