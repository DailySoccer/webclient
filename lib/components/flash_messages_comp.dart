library flash_message_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Component(selector: 'flash-messages',
           templateUrl: 'packages/webclient/components/flash_messages_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class FlashMessageComp {

  List<FlashMessage> get messages => _flashMessageService.messages;

  FlashMessageComp(this._flashMessageService);

  FlashMessagesService _flashMessageService;
}