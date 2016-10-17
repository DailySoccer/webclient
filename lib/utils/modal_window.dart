library modal_window;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/app_state_service.dart';

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
  
  @NgTwoWay("show-window")
  void set show(bool b) {
    if (!b) this._rootElement.classes.add("hidden-window");
    else this._rootElement.classes.remove("hidden-window");
  }
  bool get show => !this._rootElement.classes.contains("hidden-window");
  
  void close() {
    show = false;
  }
  
  ModalWindow(this._rootElement);
  
  Element _rootElement;
  
}