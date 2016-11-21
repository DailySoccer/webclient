library ng_bind_html_unsafe;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html' as dom;
import 'dart:html';

/*
@Directive(
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
*/
