library modal_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
  selector: 'modal',
  templateUrl: 'packages/webclient/components/modal_comp.html',
  useShadowDom: false
)
class ModalComp implements DetachAware, ShadowRootAware {

  ModalComp(this._router, this._element, this._scrDet);

  @override void onShadowRoot(emulatedRoot) {

    // EL fade vamos a hacerlo solo donde hay potencia
    if (_scrDet.isDesktop) {
      _element.querySelector("#modalRoot").classes.add("fade");
    }

    new Timer(new Duration(seconds: 0), () {     // _view.domRead(() {
      _element.style.display = "block";

      JsUtils.runJavascript('#modalRoot', 'modal', null);
      JsUtils.runJavascript('#modalRoot', 'on', {'hidden.bs.modal': onHidden});
    });
  }

  void onHidden(dynamic sender) {
    _router.go(_router.activePath.first.name, {});
  }

  void detach() {
    bool isModalOpen = document.querySelector('body').classes.contains('modal-open');
    if (isModalOpen) {
      document.querySelector('body').classes.remove('modal-open');
      document.querySelector('.modal-backdrop').remove();
    }
  }

  static void close() {
    JsUtils.runJavascript('#modalRoot', 'modal', 'hide');
  }

  ScreenDetectorService _scrDet;
  Router _router;
  Element _element;
}
