library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';


@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;
  bool isSmScreen = false;
  bool isDesktop  = false;

  Stream get mediaScreenWidth => mediaScreenWidthChangeController.stream;


  ScreenDetectorService(this._scope) {
    _detectNow(0);
  }

  // La otra aproximacion, usando dart:js para capturar el evento, falló (ver historico en git si es necesario).
  // Tambien estuvo como un timer, pero queda mas bonito detectarlo cada frame
  void _detectNow(num theTime) {

    String message = '';
    if (window.matchMedia("(min-width: 992px)").matches)
    {
      message = 'md-lg';
    }
    else if (window.matchMedia("(min-width: 768px)").matches && !isSmScreen) {
      message = 'sm';
    }
    else if (window.matchMedia("(max-width: 767px)").matches && !isXsScreen){
      message = 'xs';
    }

    if (message != _lastMessage && message != '') {
      mediaScreenWidthChangeController.add(message);
      _lastMessage = message;

      print('-screen_detector_service- screenWidth is ' + message.toUpperCase());

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


  StreamController mediaScreenWidthChangeController = new StreamController.broadcast();
  Scope _scope;
  String _lastMessage;
}