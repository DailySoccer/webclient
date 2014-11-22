library flash_message_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/utils/html_utils.dart';


@Component(selector: 'flash-messages',
           useShadowDom: false,
           exportExpressions: const ["flashMessageService.messages"]
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
    _scope.watch("flashMessageService.messages", _onFlashMessagesChange, canChangeModel: false, collection: true);
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

    flashMessageService.messages.forEach((msg) {
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

  void _createGlobalMessageHtml(String msg) {

    // Solo permitimos 1
    if (_globalMsgElement != null) {
      return;
    }

    String html =
    '''
    <div class="alert-danger" style="padding: 1em; position: fixed; top: 10%; left: 50%; transform: translateX(-50%); z-index:99999;">${msg}</div>
    ''';

    _globalMsgElement = new DivElement();
    _globalMsgElement.setInnerHtml(html, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.append(_globalMsgElement);
  }

  void _removeGlobalMessage() {
    if (_globalMsgElement != null) {
      _globalMsgElement.remove();
      _globalMsgElement = null;
    }
  }

  void onServerSuccess(Map aMsg) {
    _removeGlobalMessage();
  }

  void onServerError(Map aMsg) {
    _createGlobalMessageHtml("Error en la conexión...");
  }

  Scope _scope;
  Element _rootElement;
  Element _globalMsgElement;
  Element _flashMsgs;
}