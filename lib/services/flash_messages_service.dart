library flash_messages_service;

import 'package:angular/angular.dart';

class FlashMessage {
  String context;
  String type;
  String text;

  DateTime createdAt;

  FlashMessage(this.context, this.type, this.text);
}

@Injectable()
class FlashMessagesService {
  static const MESSAGE_DURATION = 10;

  static const CONTEXT_GLOBAL = "GLOBAL";
  static const CONTEXT_VIEW   = "VIEW";

  static const TYPE_SUCCESS = "success";
  static const TYPE_INFO    = "info";
  static const TYPE_WARNING = "warning";
  static const TYPE_ERROR   = "danger";

  List<FlashMessage> get messages {
    DateTime now = new DateTime.now();

    // Cada x tiempo...
    if (now.difference(_filteredLastTime).inSeconds > 1) {
      _filteredLastTime = now;

      // Comprobamos si existe algún mensaje antiguo...
      // Nota: Lo hacemos en dos pasos para que, de no ser necesario, no se considere que ha habido algún cambio
      bool isOldMsg(FlashMessage m) => (now.difference(m.createdAt).inSeconds >= MESSAGE_DURATION);
      if (_messages.any( (m) => isOldMsg(m) )) {
        _messages = _messages.where( (m) => !isOldMsg(m) ).toList();
      }
    }

    return _messages;
  }


  clearContext(String context) {
    _messages = _messages.where( (m) => m.context != context ).toList();
  }

  warning(String text, {context: CONTEXT_GLOBAL})  => _addMessage(new FlashMessage(context, TYPE_WARNING, text));
  info(String text, {context: CONTEXT_GLOBAL})     => _addMessage(new FlashMessage(context, TYPE_INFO, text));
  success(String text, {context: CONTEXT_GLOBAL})  => _addMessage(new FlashMessage(context, TYPE_SUCCESS, text));
  error(String text, {context: CONTEXT_GLOBAL})    => _addMessage(new FlashMessage(context, TYPE_ERROR, text));

  _addMessage(FlashMessage message) {
    message.createdAt = new DateTime.now();
    _messages.add(message);
  }

  DateTime _filteredLastTime = new DateTime.now();
  var _messages = new List<FlashMessage>();
}