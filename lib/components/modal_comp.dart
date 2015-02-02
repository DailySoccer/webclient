library modal_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/html_utils.dart';

@Component(
  selector: 'modal',
  templateUrl: 'packages/webclient/components/modal_comp.html',
  useShadowDom: false
)
class ModalComp implements DetachAware, ShadowRootAware {

  ModalComp(this._router, this._element, this._scrDet, this._view);

  @override void onShadowRoot(emulatedRoot) {

    // EL fade vamos a hacerlo solo donde hay potencia
    if (_scrDet.isDesktop) {
      _element.querySelector("#modalRoot").classes.add("fade");
    }

    _view.domRead(() {
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

  static void open(Router route, String path, Map urlParams, [Function callback = null]) {
    _returnCallback = callback;
    route.go(path, urlParams);
  }

  // en params se pasan los aprametros que incluiran en el callback
  static void close([params = null]) {
    JsUtils.runJavascript('#modalRoot', 'modal', 'hide');

    if(_returnCallback != null) {
      _returnCallback(params);
    }
  }

  ScreenDetectorService _scrDet;
  Router _router;
  Element _element;
  View _view;
  static Function _returnCallback;
}
