library modal_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/components/backdrop_comp.dart';

@Component(
  selector: 'modal',
  templateUrl: 'modal_comp.html'
)
class ModalComp implements OnDestroy, OnInit {

  /********* BINDINGS */
  @Input("window-size")
  void set windowSize(value) {
    if (value == null || value.isEmpty || (value != "lg"  && value != "md" && value != "sm" && value != "90percent") ) {
      return;
    }
    modalSize = value;
  }
  String modalSize = "lg";

  ModalComp(this._router, this._element, this._scrDet, this._view);

  @override void ngOnInit() {

    // EL fade vamos a hacerlo solo donde hay potencia
    if (_scrDet.isDesktop) {
      _element.nativeElement.querySelector("#modalRoot").classes.add("fade");
    }

    // TODO Angular 2
    /*
    _view.domRead(() {
      _element.style.display = "block";

      JsUtils.runJavascript('#modalRoot', 'modal', null);
      JsUtils.runJavascript('#modalRoot', 'on', {'hidden.bs.modal': onHidden});
      BackdropComp.instance.show(propietary: this);
    });
    */
  }

  void onHidden(dynamic sender) {
    // TODO Angular 2
    // _router.navigate([_router.activePath.first.name, {}]);
    BackdropComp.instance.hide(propietary: this);
  }

  @override void ngOnDestroy() {
    bool isModalOpen = document.querySelector('body').classes.contains('modal-open');
    if (isModalOpen) {
      document.querySelector('body').classes.remove('modal-open');
      BackdropComp.instance.hide(propietary: this);
      //document.querySelector('.modal-backdrop').remove();
    }
  }

  static void open(Router route, String path, Map urlParams, [Function callback = null]) {
    _returnCallback = callback;
    route.navigate([path, urlParams]);
  }

  // En params se pasan los parametros con los que llamaremos en el callback
  static void close([params = null]) {
    JsUtils.runJavascript('#modalRoot', 'modal', 'hide');

    if (_returnCallback != null) {
      _returnCallback(params);
      _returnCallback = null;
    }
  }

  static bool hasCallback() {
    return _returnCallback != null;
  }
  static void callCallback([params = null]) {
    _returnCallback(params);
  }
  static void deleteCallback() {
    _returnCallback = null;
  }
  
  ScreenDetectorService _scrDet;
  Router _router;
  ElementRef _element;
  View _view;
  static Function _returnCallback;
}
