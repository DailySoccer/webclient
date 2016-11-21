library max_text_width;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html' as dom;
import 'dart:html';
import 'package:webclient/utils/html_utils.dart';
import 'dart:async';
import 'dart:math';

@Directive(selector: '[max-text-width]')
class MaxTextWidthDirective{
  final ElementRef element;
  int maxWidth = 100;
  int lastWidth = 100;
  bool stable = false;
  String originalText = "";

  MaxTextWidthDirective(this.element) {
    TimerTick();
    lastWidth = element.nativeElement.offsetWidth - 5;
  }

  @Input('max-text-width')
  set value(Map val) {
    if (val != null && (val['width'] != maxWidth || val['text'] != originalText))  {
      maxWidth = val['width'];
      originalText = val['text'];
    }
  }
  
  void TimerTick() {
    new Timer(new Duration(milliseconds: stable? 200: 0), () {
          int newWidth = max(element.nativeElement.offsetWidth - 15, maxWidth);
          if (newWidth != lastWidth || element.nativeElement.text == "") {
            updateWidth(newWidth);
            lastWidth = newWidth;
            stable = false;
          } else {
            stable = true;
          }
          TimerTick();
        });
  }
  
  void updateWidth(int newWidth) {
    element.nativeElement.text = originalText;
    element.nativeElement.text = trimStringToPx(element.nativeElement, newWidth);
  }
}
