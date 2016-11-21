library flash_messages_service;

import 'package:angular2/core.dart';

class FlashMessage {
  String context;
  String type;
  String text;

  FlashMessage(this.context, this.type, this.text);
}

class GlobalMessage {
  int visibilitySeconds ;
  String text;

  GlobalMessage(this.text, this.visibilitySeconds);
}

@Injectable()
class FlashMessagesService {
  static const CONTEXT_GLOBAL = "GLOBAL";
  static const CONTEXT_VIEW   = "VIEW";

  static const TYPE_SUCCESS = "success";
  static const TYPE_INFO    = "info";
  static const TYPE_WARNING = "warning";
  static const TYPE_ERROR   = "danger";

  List<FlashMessage> flashMessages    = new List<FlashMessage>();
  List<GlobalMessage> globalMessages  = new List<GlobalMessage>();

  clearContext(String context) {
    flashMessages = flashMessages.where( (m) => m.context != context ).toList();
  }

  warning(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(new FlashMessage(context, TYPE_WARNING, text));
  info(String text, {context: CONTEXT_GLOBAL})     => _addFlashMessage(new FlashMessage(context, TYPE_INFO, text));
  success(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(new FlashMessage(context, TYPE_SUCCESS, text));
  error(String text, {context: CONTEXT_GLOBAL})    => _addFlashMessage(new FlashMessage(context, TYPE_ERROR, text));

  _addFlashMessage(FlashMessage message) {
    // flashMessages.add(message);
  }

  addGlobalMessage(String text, int visibilitySeconds) => _addGlobalMessage(new GlobalMessage(text, visibilitySeconds));

  _addGlobalMessage(GlobalMessage message) {
    globalMessages.add(message);
  }
}