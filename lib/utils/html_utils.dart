library html_utils;

import 'dart:html';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}

final NodeTreeSanitizer NULL_TREE_SANITIZER = new _NullTreeSanitizer();

Future<bool> modalShow(String title, String content,{String onOk: null, String onCancel: null, closeButton: false}) {
  Completer completer = new Completer();
  Element parent = querySelector('ng-view');

  void onClose(dynamic sender) {
    parent.children.remove(parent.querySelector('#modalRoot'));
  }

  void closeMe() {
    JsUtils.runJavascript('#modalRoot', 'modal', "hide");
  }

  // Si no se han especificado callBacks, declaramos como minimo el botón Aceptar.
  if(onOk == null && onCancel == null) {
    onOk = "OK";
  }

  void onButtonClick(dynamic sender) {
    String eventCallback = sender.currentTarget.attributes["eventCallback"];
    closeMe();
    //Luego el true o false para cerrar la ventana.
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

  String botonOk      = (onOk != null) ?     '''<button class="enter-button-half"   eventCallback="onOk">     ${onOk}</button>'''   : '';
  String botonCancel  = (onCancel != null) ? '''<button class="cancel-button-half"  eventCallback="onCancel"> ${onCancel}</button>'''  : '';
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




String trimStringToPx(Element elem, int maxWidthAllowed) {
/*
  // Función que compone un elemento que utilizamos para medir el ancho que ocupa.
  Element composeRuler(Element elem) {
   // String rulerCode = ''' <${elem.tagName} class="${elem.classes.join(' ')}" style="visibility: hidden; white-space: nowrap; position: absolute; top: -100; left: 0px;"></${elem.tagName}>''';

    Element rulerElement = new Element.span();

    rulerElement.style.setProperty('fontFamily', elem.style.fontFamily);
    rulerElement.style.setProperty('fontSize', elem.style.fontSize);

    rulerElement.style.fontStyle = elem.style.fontStyle;
    rulerElement.style.fontStyle = elem.style.fontStyle;

    return rulerElement;
  }
*/
  int visualStringWidth(String theString) {

    Element ruler = elem;
    ruler.text = theString;

    return ruler.client.width;
  }

  String tmpString = elem.text;
  String trimmedString = elem.text;

  int fullStringWidth = visualStringWidth(tmpString);
  if (fullStringWidth > maxWidthAllowed) {
    trimmedString += '...';
    while(visualStringWidth(trimmedString) > maxWidthAllowed) {
      tmpString = tmpString.substring(0, tmpString.length -1);
      trimmedString = tmpString + '...';
    }
  }
  return trimmedString;
}