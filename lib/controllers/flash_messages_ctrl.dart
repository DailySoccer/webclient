library flash_messages_ctrl;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[flash-messages]',
    publishAs: 'flashCtrl'
)
class FlashMessagesCtrl {

  Scope scope;
  Element element;

  var messages = new List<FlashMessage>();

  FlashMessagesCtrl(this.scope, this.element, this._flashMessageService) {
    messages = _flashMessageService.messages;

    scope.watch("messages", (value, _) {
      messages = value;
    }, context: _flashMessageService);
  }

  void closeMessage(index) {
    messages.removeAt(index);
  }

  FlashMessagesService _flashMessageService;
}
