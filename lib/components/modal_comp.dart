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

  ModalComp(this._router, this._element);

  @override void onShadowRoot(emulatedRoot) {
    // _view.domRead(() {
    new Timer(new Duration(seconds: 0), () {
      _element.style.display = "block";

      JsUtils.runJavascript('#modal', 'modal', null);
      JsUtils.runJavascript('#modal', 'on', {'hidden.bs.modal': onHidden});
    });
  }

  void onHidden(dynamic sender) {
    _router.go(_router.activePath.first.name, {});
  }

  void detach() {
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
}
