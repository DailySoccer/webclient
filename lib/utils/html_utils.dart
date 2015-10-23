library html_utils;

import 'dart:html';
import 'package:webclient/utils/js_utils.dart';
import 'dart:async';

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}

final NodeTreeSanitizer NULL_TREE_SANITIZER = new _NullTreeSanitizer();

Future<bool> modalShow(String title, String content,
    {String modalSize: "lg", String onOk: null, String onCancel: null, bool closeButton: false}) {
  Completer completer = new Completer();
  Element modalWindow = querySelector("#modalWindow");

  void onClose(dynamic sender) {
    modalWindow.children.remove(modalWindow.querySelector('#alertRoot'));
  }

  void closeMe() {
    JsUtils.runJavascript('#alertRoot', 'modal', "hide");
  }

  // Si no se han especificado callBacks, declaramos como minimo el botón Aceptar.
  if (onOk == null && onCancel == null) {
    onOk = "OK";
  }

  void onButtonClick(dynamic sender) {
    String eventCallback = sender.currentTarget.attributes["eventCallback"];
    closeMe();
    //Luego el true o false para cerrar la ventana.
    switch (eventCallback) {
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

  String composeHeader() {
    String ret = "";

    if (title != "") {
      ret = '''
        <!-- Header -->
        <div class="panel-heading">
          <div class="panel-title">${title}</div>
          ${closeButton ? '''
              <button type="button" class="close" eventCallback="closeMe">
                <span class="glyphicon glyphicon-remove"></span>
              </button> ''' : ''
          }
        </div>
      ''';
      closeButton = false;
    }

    return ret;
  }

  String botonOk = (onOk != null)
      ? '''<div class="button-box"><button class="ok-button" eventCallback="onOk">${onOk}</button><div>'''
      : '';
  String botonCancel = (onCancel != null)
      ? '''<div class="button-box"><button class="cancel-button" eventCallback="onCancel"> ${onCancel}</button></div>'''
      : '';
  String modalBody = ''' 
                        <div id="alertRoot" class="modal container fade" tabindex="-1" role="dialog" style="display: block;">
                          <div class="modal-dialog modal-${modalSize}">
                            <div class="modal-content"> 

                              <div class="alert-content">      
                                <div id="alertBox" class="main-box">
                                  <div class="panel">
                                    ${composeHeader()} 
                                    <!-- Content Message and Buttons-->
                                    <div class="panel-body" >
                                      <!-- close button -->
                                      ${closeButton ? '''
                                        <button type="button" class="close" eventCallback="closeMe">
                                          <!--<span class="glyphicon glyphicon-remove"></span>-->
                                          <img src="images/alertCloseButton.png">
                                        </button> ''' : ''
                                      }           
                                      <!-- Alert Text -->
                                      <div class="form-description">${content}</div>            
                                      <!-- Alert Buttons -->
                                      <div class="input-group user-form-field">
                                        <div class="new-row">                  
                                          <div class="autocentered-buttons-wrapper">
                                            ${(onCancel != null) ? botonCancel  : ""} 
                                            ${(onOk     != null) ? botonOk      : ""}
                                          </div>
                                        </div>
                                      </div>            
                                    </div>
                                  </div>
                                </div>        
                              </div>

                            </div>
                          </div>
                        </div>
                      ''';

  modalWindow.setInnerHtml(modalBody, treeSanitizer: NULL_TREE_SANITIZER);

  // Aqui hago el setup de los botones. (que tiene que hacer cada botón al ser clickado... ver: main_menu_slide_comp).
  modalWindow.querySelectorAll("[eventCallback]").onClick.listen(onButtonClick);

  JsUtils.runJavascript('#alertRoot', 'modal', null);
  JsUtils.runJavascript('#alertRoot', 'on', {'hidden.bs.modal': onClose});
  return completer.future;
}

String trimStringToPx(Element elem, int maxWidthAllowed) {

  // Closure para calcular el ancho en pixels que tendría una cadena dentro del elemento.
  int visualStringWidth(String theString) {
    var displayOriginal = elem.style.display;
    Map OriginalStyle = {};
    String OriginalDisplay = elem.style.display;
    // Si el elemento es display:block, no lo puedo usar para cambiarle el ancho. Por siacaso guardo su display original
    elem.style.setProperty("display", "inline-block");

    elem.text = theString;

    //guardo el ancho del elemento con el texto
    int result = elem.offsetWidth;

    //restauro el display del elemento
    elem.style.setProperty("display", OriginalStyle["display"]);

    return result;
  }

  String tmpString = elem.text;
  String trimmedString = elem.text;

  int fullStringWidth = visualStringWidth(tmpString);

  // Si la cadena cabe en el ancho, devolvemos la cadena
  if (fullStringWidth > maxWidthAllowed) {
    trimmedString += '...';

    int start = 0;
    int end = trimmedString.length - 1;
    int middle = 0;

    //Si no cabe, hacemos busqueda dicotómica para encontrar la longitud de cadena máxima permitida
    while (start < end) {
      middle = (((start + end) / 2)).ceil();
      trimmedString = tmpString.substring(0, middle).trim() + '...';
      int trimmedStringWidth = visualStringWidth(trimmedString);
      int nextTrimmedStringWidth =
          visualStringWidth(tmpString.substring(0, middle + 1).trim() + '...');

      // Si el texto ocupa lo mismo Ó si la diferencia de poner un carcater de más nos hace pasarnos
      if (trimmedStringWidth == maxWidthAllowed ||
          (trimmedStringWidth < maxWidthAllowed &&
              nextTrimmedStringWidth > maxWidthAllowed)) {
        return trimmedString;
      } else if (trimmedStringWidth < maxWidthAllowed) {
        start = middle - 1;
      } else {
        end = middle + 1;
      }
    }
  }

  return trimmedString;
}
