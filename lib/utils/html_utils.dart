library html_utils;

import 'dart:html';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}

final NodeTreeSanitizer NULL_TREE_SANITIZER = new _NullTreeSanitizer();

Future<bool> modalShow(String title, String content,{Function onYes: null, Function onNo: null, Function onOk: null, Function onCancel: null, closeButton: false}) {
  Completer completer = new Completer();
  Element parent = querySelector('ng-view');

  void onClose(dynamic sender) {
    parent.children.remove(parent.querySelector('#modalRoot'));
  }

  void closeMe() {
    JsUtils.runJavascript('#modalRoot', 'modal', "hide");
  }

  // Si no se han especificado callBacks, declaramos como minimo el botón Aceptar.
  if(onYes == null && onNo == null && onOk == null && onCancel == null) {
    onOk = closeMe;
  }

  void onButtonClick(dynamic sender) {
    String eventCallback = sender.currentTarget.attributes["eventCallback"];
    closeMe();
    switch(eventCallback){
      case "onYes":
      case "onOk":
        completer.complete(true);
      break;
      case "onNo":
      case "onCancel":
        completer.complete(false);
      break;
    }
  }

  String botonYes     = (onYes != null) ?    '''<button class="enter-button-half"   eventCallback="onYes">    Si</button>'''        : '';
  String botonNo      = (onNo != null) ?     '''<button class="cancel-button-half"  eventCallback="onNo">     No</button>'''        : '';
  String botonOk      = (onOk != null) ?     '''<button class="enter-button-half"   eventCallback="onOk">     Aceptar</button>'''   : '';
  String botonCancel  = (onCancel != null) ? '''<button class="cancel-button-half"  eventCallback="onCancel"> Cancelar</button>'''  : '';
  String modalBody =  ''' 
                        <div id="modalRoot" class="modal container fade" tabindex="-1" role="dialog" style="display: block;">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                              <content>      
                                <div id="loginBox" class="main-box">
                                  <div class="panel">            
                                    <!-- Header -->
                                    <div class="panel-heading">
                                      <div class="panel-title">${title}</div>
                                      ${closeButton ? '''
                                        <button type="button" class="close" eventCallback="closeMe">
                                          <span class="glyphicon glyphicon-remove"></span>
                                        </button> ''' : ''
                                      }
                                    </div>            
                                    <!-- Content Message and Buttons-->
                                    <div class="panel-body" >            
                                      <!-- Alert Text -->
                                      <div class="form-description">${content}</div>            
                                      <!-- Alert Buttons -->
                                      <div class="input-group user-form-field">
                                        <div class="new-row">
                                          <div class="buttons-wrapper">
                                            ${(onYes    != null) ? botonYes     : ""}
                                            ${(onNo     != null) ? botonNo      : ""}
                                            ${(onOk     != null) ? botonOk      : ""}
                                            ${(onCancel != null) ? botonCancel  : ""}
                                          </div>
                                        </div>
                                      </div>            
                                    </div>
                                  </div>
                                </div>        
                              </content>
                            </div>
                          </div>
                        </div>
                      ''';


  parent.appendHtml(modalBody);
  // Aqui hago el setup de los botones. (que tiene que hacer cada botón al ser clickado... ver: main_menu_slide_comp).
  parent.querySelectorAll("[eventCallback]").onClick.listen(onButtonClick);


  JsUtils.runJavascript('#modalRoot', 'modal', null);
  JsUtils.runJavascript('#modalRoot', 'on', {'hidden.bs.modal': onClose});
  return completer.future;
}
