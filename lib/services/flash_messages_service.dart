library flash_messages_service;

import 'package:angular/angular.dart';

class FlashMessage {
  String context;
  String type;
  String text;

  FlashMessage(this.context, this.type, this.text);
}

@Injectable()
class FlashMessagesService {
  static const CONTEXT_GLOBAL = "GLOBAL";
  static const CONTEXT_VIEW   = "VIEW";

  static const TYPE_SUCCESS = "success";
  static const TYPE_INFO    = "info";
  static const TYPE_WARNING = "warning";
  static const TYPE_ERROR   = "danger";

  var messages = new List<FlashMessage>();

  clearContext(String context) {
    messages = messages.where( (m) => m.context != context ).toList();
  }

  warning(String text, {context: CONTEXT_GLOBAL})  => _addMessage(new FlashMessage(context, TYPE_WARNING, text));
  info(String text, {context: CONTEXT_GLOBAL})     => _addMessage(new FlashMessage(context, TYPE_INFO, text));
  success(String text, {context: CONTEXT_GLOBAL})  => _addMessage(new FlashMessage(context, TYPE_SUCCESS, text));
  error(String text, {context: CONTEXT_GLOBAL})    => _addMessage(new FlashMessage(context, TYPE_ERROR, text));

  _addMessage(FlashMessage message) {
    messages.add(message);
  }
}