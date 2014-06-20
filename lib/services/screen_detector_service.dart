library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';


@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;

  ScreenDetectorService(this._scope) {

    // La otra aproximacion, usando dart:js para capturar el evento, fallo (ver historico en git si es necesario)
    new Timer.periodic(new Duration(milliseconds: 500), (Timer timer) {
      MediaQueryList mq = window.matchMedia("(min-width: 768px)");
      isXsScreen = !mq.matches;
    });
  }

  Scope _scope;
}