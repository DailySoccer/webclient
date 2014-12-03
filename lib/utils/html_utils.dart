library html_utils;

import 'dart:html';
import 'package:webclient/utils/js_utils.dart';
import 'dart:js';

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}

final NodeTreeSanitizer NULL_TREE_SANITIZER = new _NullTreeSanitizer();

void modalShow(String title, String content,{Function onYes: null, Function onNo: null, Function onOk: null, Function onCancel: null}) {

  String botonYes     = (onYes != null) ?       '''<button class="btn-primary"  ng-click="onYes('Yes')">Yes</button>'''       : '';
  String botonNo      = (onNo != null) ?     '''<button class="btn-cancel"   ng-click="onNo('No')">No</button>'''         : '';
  String botonOk      = (onOk != null) ?     '''<button class="btn-primary"  ng-click="{onOk('Ok')}">Ok</button>'''         : '';
  String botonCancel  = (onCancel != null) ? '''<button class="btn-cancel"   ng-click="onCancel('Cancel')">Cancel</button>''' : '';

  void onClose() {
    print("Cerrandome...");
  }

  String modalBody =  ''' 
                        <div id="modalRoot" class="modal container fade" tabindex="-1" role="dialog" style="display: block;">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-header">${title}</div>
                            <div class="modal-content">
                              <content>
                                ${content}
                                <div class="button-wrapper">
                                  ${(onYes    != null) ? botonYes     : ""}
                                  ${(onNo     != null) ? botonNo      : ""}
                                  ${(onOk     != null) ? botonOk      : ""}
                                  ${(onCancel != null) ? botonCancel  : ""}
                                <div>
                              </content>
                            </div>
                          </div>
                        </div>
                      ''';

  Element parent = querySelector('ng-view');
  parent.appendHtml(modalBody);

  JsUtils.runJavascript('#modalRoot', 'modal', null);
  JsUtils.runJavascript('#modalRoot', 'on', {'hidden.bs.modal': onClose()});
}
