library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';


@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;
  bool isSmScreen = false;
  bool isDesktop  = false;

  ScreenDetectorService(this._scope) {
    _detectNow(0);
  }

  // La otra aproximacion, usando dart:js para capturar el evento, falló (ver historico en git si es necesario).
  // Tambien estuvo como un timer, pero queda mas bonito detectarlo cada frame
  void _detectNow(num theTime) {

    if (window.matchMedia("(max-width: 567px)").matches) {
      isXsScreen = true;
      isSmScreen = false;
      isDesktop = false;
    }

    if (window.matchMedia("(min-width: 568px)").matches) {
      isXsScreen = false;
      isSmScreen = true;
      isDesktop = false;
    }

    if (window.matchMedia("(min-width: 768px)").matches){
      isXsScreen = false;
      isSmScreen = false;
      isDesktop = true;
    }

    window.animationFrame.then(_detectNow);
  }

  Scope _scope;
}