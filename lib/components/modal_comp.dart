library modal_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';

@Component(
  selector: 'modal',
  templateUrl: 'packages/webclient/components/modal_comp.html',
  useShadowDom: false
)
class ModalComp implements DetachAware, ShadowRootAware {

  ModalComp(this._router, this._element, ScreenDetectorService scrDet) {
    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);
  }

  @override void onShadowRoot(emulatedRoot) {
    // _view.domRead(() {
    new Timer(new Duration(seconds: 0), () {
      _element.style.display = "block";

      JsUtils.runJavascript('#modal', 'modal', null);
      JsUtils.runJavascript('#modal', 'on', {'hidden.bs.modal': onHidden});
    });
  }

  void onScreenWidthChange(String msg) {
    // La ventana modal siempre se auto oculta cuando pasamos de una resolucion a otra, salvo que la
    // resolucion destino sea dekstop
    if (msg != "desktop") {
      JsUtils.runJavascript('#modal', 'modal', 'hide');
    }
  }

  void onHidden(dynamic sender) {
    _router.go(_router.activePath.first.name, {});
  }

  void detach() {
    _streamListener.cancel();
    _closeModal();
  }

  void _closeModal() {
    bool isModalOpen = document.querySelector('body').classes.contains('modal-open');
    if (isModalOpen) {
      document.querySelector('body').classes.remove('modal-open');
      document.querySelector('.modal-backdrop').remove();
    }
  }

  Router _router;

  Element _element;
  var _streamListener;
}
