library translate_decorator;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/utils/translate_config.dart';

// TODO Angular 2
@Directive(selector: '[translate]', host: const {'translate': '<=>translate'})
class TranslateDecorator {
  String translate;
  ElementRef element;
  TranslateDecorator(this.element) {
    element.nativeElement.text = config.translate(element.nativeElement.attributes["translate"]);
    window.on['languageChangedEvent'].listen((e) {
      element.nativeElement.text = config.translate(element.nativeElement.attributes["translate"]);
    });
  }
}