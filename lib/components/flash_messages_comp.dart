library flash_message_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:async';


@Component(selector: 'flash-messages',
           useShadowDom: false,
           exportExpressions: const ["flashMessageService.flashMessages", "flashMessageService.globalMessages"]
)
class FlashMessageComp implements ShadowRootAware, ScopeAware {

  FlashMessagesService flashMessageService;


  FlashMessageComp(this.flashMessageService, ServerService serverService, this._rootElement) {
    serverService.subscribe("GlobalConnection", onSuccess: onServerSuccess, onError: onServerError);
  }

  @override void set scope(Scope theScope) {
    _scope = theScope;
  }

  @override void onShadowRoot(emulatedRoot) {
    _scope.watch("flashMessageService.flashMessages", _onFlashMessagesChange, canChangeModel: false, collection: true);
    _scope.watch("flashMessageService.globalMessages", _onGlobalMessagesChange, canChangeModel: false, collection: true);
  }

    void _onFlashMessagesChange(blah, blahblah) {
      if (_flashMsgs != null) {
        _flashMsgs.remove();
        _flashMsgs = null;
      }

      _createFlashMessagesHtml();
    }

  void _createFlashMessagesHtml() {

    String messagesHtml = "";

    flashMessageService.flashMessages.forEach((msg) {
      messagesHtml +=
      '''
      <div class="alert alert-${msg.type} alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <span class="">${msg.text}</span>
      </div>
      ''';
    });

    String html =
    '''<div id="flash-messages">
        ${messagesHtml}
      </div>
    ''';

    _flashMsgs = new DivElement();
    _flashMsgs.setInnerHtml(html, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.append(_flashMsgs);
  }

  void _onGlobalMessagesChange(blah, blahblah) {
    if (flashMessageService.globalMessages.length > 0) {
      GlobalMessage gm = flashMessageService.globalMessages.first;
      createGlobalMessageFromQueue(gm.text, gm.visibilitySeconds);
    }
  }

  void createGlobalMessageFromQueue(String msg, int displayingSeconds) {
    _createGlobalMessageHtml(msg);
    new Timer(new Duration(seconds: displayingSeconds), _removeGlobalMessageFromQueue);
  }

  void _removeGlobalMessageFromQueue() {
    _removeGlobalMessage();
    if (flashMessageService.globalMessages.length > 0) {
      flashMessageService.globalMessages.removeAt(0);
    }
  }

  Element _createGlobalMessageHtml(String msg, {bool isErrorMsg: false}) {

    // Solo permitimos 1
    if (_globalMsgElement != null) {
      return _globalMsgElement;
    }

    String html =
    '''
    <div class="${isErrorMsg ? "globalMessage" : "epicGlobalMessage"}">${msg}</div>
    ''';

    _globalMsgElement = new DivElement();
    _globalMsgElement.setInnerHtml(html, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.append(_globalMsgElement);
    return _globalMsgElement;
  }

  void _removeGlobalMessage() {
    if (_globalMsgElement != null) {
      _globalMsgElement.remove();
      _globalMsgElement = null;
    }
  }

  void onServerSuccess(Map aMsg) {
    if(_serverGlobalMsgElement != null) {
      _removeGlobalMessage();
      _serverGlobalMsgElement = null;
    }
  }

  void onServerError(Map aMsg) {
    _serverGlobalMsgElement = _createGlobalMessageHtml("Error en la conexión...", isErrorMsg: true);
  }

  Scope _scope;
  Element _rootElement;
  Element _globalMsgElement;
  Element _serverGlobalMsgElement;
  Element _flashMsgs;
}