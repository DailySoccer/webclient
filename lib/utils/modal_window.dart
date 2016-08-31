library modal_window;

import 'package:angular/angular.dart';
import 'dart:html';

@Component(
    selector: 'modal-window',
    templateUrl: 'packages/webclient/utils/modal_window.html',
    useShadowDom: false
)
class ModalWindow {

  @NgOneWay("show-header")
  bool showHeader = true;

  @NgOneWay("title")
  String title;
  
  @NgOneWay("show-window")
  void set show(bool b) {
    if (!b) this._rootElement.classes.add("hidden-window");
    else this._rootElement.classes.remove("hidden-window");
  }
  
  void close() {
    show = false;
  }
  
  ModalWindow(this._rootElement);
  
  Element _rootElement;
  
}