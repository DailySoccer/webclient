library max_text_width;

import 'dart:html' as dom;
import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/utils/html_utils.dart';
import 'dart:async';
import 'dart:math';

@Decorator(selector: '[max-text-width]')
class MaxTextWidthDirective{
  final dom.Element element;
  int maxWidth = 100;
  int lastWidth = 100;
  bool stable = false;
  String originalText = "";

  MaxTextWidthDirective(this.element) {
    TimerTick();
    lastWidth = element.offsetWidth - 5;
  }

  @NgOneWay('max-text-width')
  set value(Map val) {
    if (val != null && (val['width'] != maxWidth || val['text'] != originalText))  {
      maxWidth = val['width'];
      originalText = val['text'];
    }
  }
  
  void TimerTick() {
    new Timer(new Duration(milliseconds: stable? 200: 0), () {
          int newWidth = max(element.offsetWidth - 15, maxWidth);
          if (newWidth != lastWidth || element.text == "") {
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
    element.text = originalText;
    element.text = trimStringToPx(element, newWidth);
  }
}
