library flash_messages_service;

import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/utils/string_utils.dart';

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
  static const TYPE_ERROR   = "error";
  
  static FlashMessagesService get instance => _instance;

  List<FlashMessage> flashMessages    = new List<FlashMessage>();
  List<GlobalMessage> globalMessages  = new List<GlobalMessage>();

  FlashMessagesService(ServerService serverService) {
    _instance = this;
    serverService.subscribe("GlobalConnection", onSuccess: onServerSuccess, onError: onServerError);

    /*_flashMessageList.add(new FlashMessage.error("Esto es un erroraco"));
    _flashMessageList.add(new FlashMessage.error("Esto es un erroraco tan largo que no cabe en una sola linea, es probable que los errores sean largos y feos"));
    _flashMessageList.add(new FlashMessage.warning("Esto es un warring"));
    _flashMessageList.add(new FlashMessage.info("Esto es un info"));*/
  }
  

  void onServerSuccess(Map aMsg) {
    //successKey("SUCCESS");
    clearErrorKey(StringUtils.translate('connection-error', 'serverError'));
  }

  void onServerError(Map aMsg) {
    errorKey(StringUtils.translate('connection-error', 'serverError'));
  }
  
  clearContext(String context) {
    flashMessages = flashMessages.where( (m) => m.context != context ).toList();
  }

  warning(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(context, TYPE_WARNING, text);
  info(String text, {context: CONTEXT_GLOBAL})     => _addFlashMessage(context, TYPE_INFO, text);
  success(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(context, TYPE_SUCCESS, text);
  error(String text, {context: CONTEXT_GLOBAL})    => _addFlashMessage(context, TYPE_ERROR, text);

  // this methods are for general errors as server connection
  // the idea is translate them here.
  // TODO:
  warningKey(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(context, TYPE_WARNING, text);
  infoKey(String text, {context: CONTEXT_GLOBAL})     => _addFlashMessage(context, TYPE_INFO, text);
  successKey(String text, {context: CONTEXT_GLOBAL})  => _addFlashMessage(context, TYPE_SUCCESS, text);
  errorKey(String text, {context: CONTEXT_GLOBAL})    => _addFlashMessage(context, TYPE_ERROR, text);

  clearErrorKey(String text, {context: CONTEXT_GLOBAL})    => _removeFlashMessage(context, TYPE_ERROR, text);

  _addFlashMessage(context, type, text) {
    if (flashMessages.where((f) => f.text == text && f.type == type).length > 0) {
      return;
    }
    flashMessages.add(new FlashMessage(context, type, text));
  }
  _removeFlashMessage(context, type, text) {
    Iterable<FlashMessage> a = flashMessages.where((f) => f.text == text && f.type == type);
    if(a.length > 0) flashMessages.remove(a.first);
  }

  addGlobalMessage(String text, int visibilitySeconds) => _addGlobalMessage(new GlobalMessage(text, visibilitySeconds));

  _addGlobalMessage(GlobalMessage message) {
    globalMessages.add(message);
  }
  
  static FlashMessagesService _instance = null;
}