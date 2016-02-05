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
  String originalText = "";

  MaxTextWidthDirective(this.element) {
    new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
      int newWidth = max(element.offsetWidth - 15, maxWidth);
      if (newWidth != lastWidth) {
        updateWidth(newWidth);
        lastWidth = newWidth;
      }
    });
    lastWidth = element.offsetWidth - 5;
  }

  @NgOneWay('max-text-width')
  set value(Map val) {
    if (val != null)  {
      maxWidth = val['width'];
      originalText = val['text'];
      updateWidth(max(element.offsetWidth - 15, maxWidth));
    }
  }
  
  void updateWidth(int newWidth) {
    element.text = originalText;
    element.text = trimStringToPx(element, newWidth);
  }
}
