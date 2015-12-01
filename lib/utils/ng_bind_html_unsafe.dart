library ng_bind_html_unsafe;

import 'dart:html' as dom;
import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(
    selector: '[ng-bind-html-unsafe]',
    map: const {'ng-bind-html-unsafe': '=>value'}    )
class NgBindHtmlUnsafeDirective{
  final dom.Element element;

  NgBindHtmlUnsafeDirective(this.element);

  final NodeTreeSanitizer NULL_TREE_SANITIZER = new _NullTreeSanitizer();
  
  set value(value) => element.setInnerHtml(value == null ? '' : value.toString(),
                                            treeSanitizer: NULL_TREE_SANITIZER);
}

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
