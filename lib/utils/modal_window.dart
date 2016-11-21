library modal_window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';
import 'package:webclient/services/app_state_service.dart';

@Component(
    selector: 'modal-window',
    templateUrl: 'modal_window.html'
)
class ModalWindow {

  @Input("show-header")
  bool showHeader = true;

  @Input("title")
  String title;

  @Output("show-window")
  void set show(bool b) {
    if (!b) _rootElement.nativeElement.classes.add("hidden-window");
    else _rootElement.nativeElement.classes.remove("hidden-window");
  }
  @Input("show-window")
  bool get show => !_rootElement.nativeElement.classes.contains("hidden-window");

  void close() {
    show = false;
  }
  
  ModalWindow(this._rootElement);
  
  ElementRef _rootElement;
}