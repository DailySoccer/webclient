library modal_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/js_utils.dart';

@Component(
  selector: 'modal',
  templateUrl: 'packages/webclient/components/modal_comp.html',
  useShadowDom: false
)
class ModalComp implements DetachAware, ShadowRootAware {

  ModalComp(this._router, this._scrDet, this._element) {
    _streamListener = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  // Handler que recibe cual es la nueva mediaquery aplicada según el ancho de la pantalla.
  void onScreenWidthChange(String msg) {
    if (msg != "desktop") {
      // Ocultamos la ventana modal
      JsUtils.runJavascript('#modal', 'modal', 'hide');
    }
  }

  void onShadowRoot(emulatedRoot) {
    _element.style.display = "block";
    new Timer(new Duration(seconds:0), () {
      JsUtils.runJavascript('#modal', 'modal', null);
      JsUtils.runJavascript('#modal', 'on', {'hidden.bs.modal': onHidden});
      });
  }

  void onHidden(dynamic sender) {
    _router.go(_router.activePath.first.name, {});
  }

  void detach() {
    _streamListener.cancel();
    _closeModal();
  }

  void _closeModal() {
    bool isModalOpen = (document.querySelector('body').classes.contains('modal-open'));
    if (isModalOpen) {
      document.querySelector('body').classes.remove('modal-open');
      document.querySelector('.modal-backdrop').remove();
    }
  }

  Router _router;

  Element _element;
  var _streamListener;
  ScreenDetectorService _scrDet;
}
