library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';


@Injectable()
class ScreenDetectorService {
  StreamController mediaScreenWidthChangeController = new StreamController.broadcast();

  bool isXsScreen = false;
  bool isSmScreen = false;
  bool isDesktop  = false;
  String lastMessage;
  ScreenDetectorService(this._scope) {
    _detectNow(0);
  }

  // La otra aproximacion, usando dart:js para capturar el evento, falló (ver historico en git si es necesario).
  // Tambien estuvo como un timer, pero queda mas bonito detectarlo cada frame
  void _detectNow(num theTime) {

    String message = '';
    if (window.matchMedia("(min-width: 768px)").matches)
    {
      message = 'md-lg';
    }
    else if (window.matchMedia("(min-width: 568px)").matches && !isSmScreen) {
      message = 'sm';
    }
    else if (window.matchMedia("(max-width: 567px)").matches && !isXsScreen){
      message = 'xs';
    }

    if( message != lastMessage && message != '') {
      mediaScreenWidthChangeController.add(message);
      lastMessage = message;

      print('-screen_detector_service- screenWidth = ' + message);

      switch(message){
        case "xs":
          isXsScreen = true;
          isSmScreen = false;
          isDesktop = false;
        break;
        case "sm":
          isXsScreen = false;
          isSmScreen = true;
          isDesktop = false;
        break;
        case "md-lg":
          isXsScreen = false;
          isSmScreen = false;
          isDesktop = true;
        break;
      }
    }

    window.animationFrame.then(_detectNow);
  }

  Stream get mediaScreenWidth => mediaScreenWidthChangeController.stream;

  Scope _scope;
}