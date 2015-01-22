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

  // Closure para calcular el ancho en pixels que tendría una cadena dentro del elemento.
  int visualStringWidth(String theString) {
    var displayOriginal = elem.style.display;
    Map OriginalStyle = {};
    OriginalStyle.addAll(
        {
          'display': elem.style.display/*,
          'padding': elem.style.padding,
          'border' : elem.style.border,
          'margin' : elem.style.margin*/
        }
    );
    elem.style.setProperty("display", "inline-block");
    /*elem.style.setProperty("padding", "0");
    elem.style.setProperty("border",  "none");
    elem.style.setProperty("margin",  "0");*/

    elem.text = theString;

    int result = elem.offsetWidth;
    elem.style.setProperty("display", OriginalStyle["display"]);
    /*elem.style.setProperty("padding", OriginalStyle["padding"]);
    elem.style.setProperty("border",  OriginalStyle["border"]);
    elem.style.setProperty("margin",  OriginalStyle["margin"]);*/

    return result;
  }

  String tmpString = elem.text;
  String trimmedString = elem.text;

  int fullStringWidth = visualStringWidth(tmpString);

  // Si la cadena cabe en el ancho, devolvemos la cadena
  if (fullStringWidth > maxWidthAllowed) {
    trimmedString += '...';
    //Si no cabe, hacemos busqueda dicotómica para encontrar la longitud de cadena permitida
    int start = 0;
    int end = trimmedString.length -1;
    int middle = 0;
    //int trimmedStringWidth = 0;

    while (start < end) {
      middle = (((start + end) / 2)).ceil();
      trimmedString = tmpString.substring(0, middle).trim() + '...';
      int trimmedStringWidth = visualStringWidth(trimmedString);
      int nextTrimmedStringWidth = visualStringWidth( tmpString.substring(0, middle + 1).trim() + '...');

      if(trimmedStringWidth == maxWidthAllowed || (trimmedStringWidth < maxWidthAllowed && nextTrimmedStringWidth > maxWidthAllowed)) {
        return trimmedString;
      }
      else if (trimmedStringWidth < maxWidthAllowed) {
          start = middle - 1;
      }
      else {
        end = middle + 1;
      }
    }
  }
  return trimmedString;
}
