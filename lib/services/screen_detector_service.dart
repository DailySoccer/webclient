library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';


@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;

  ScreenDetectorService(this._scope) {
    _detectNow(0);
  }

  // La otra aproximacion, usando dart:js para capturar el evento, falló (ver historico en git si es necesario).
  // Tambien estuvo como un timer, pero queda mas bonito detectarlo cada frame
  void _detectNow(num theTime) {
    MediaQueryList mq = window.matchMedia("(min-width: 768px)");
    isXsScreen = !mq.matches;

    window.animationFrame.then(_detectNow);
  }

  Scope _scope;
}