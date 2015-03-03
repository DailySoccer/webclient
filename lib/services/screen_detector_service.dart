library screen_detector_service;

import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';
import 'package:logging/logging.dart';
import 'package:scroll/scroll.dart';

@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;
  bool isSmScreen = false;
  bool isDesktop  = false;

  bool get isNotXsScreen => !isXsScreen;

  Stream get mediaScreenWidth => mediaScreenWidthChangeController.stream;

  ScreenDetectorService(this._turnZone) {
    // Necesitamos que corra fuera de la zona para que no provoque automaticamente un digest
    _turnZone.runOutsideAngular(() => _detectNow(0));
  }

  // La otra aproximacion, usando dart:js para capturar el evento, falló (ver historico en git si es necesario).
  // Tambien estuvo como un timer, pero queda mas bonito detectarlo cada frame
  void _detectNow(num theTime) {

    String message = '';
    if (window.matchMedia("(min-width: 992px)").matches) {
      message = 'desktop';
    }
    else if (window.matchMedia("(min-width: 768px)").matches && !isSmScreen) {
      message = 'sm';
    }
    else if (window.matchMedia("(max-width: 767px)").matches && !isXsScreen) {
      message = 'xs';
    }

    if (message != _lastMessage && message != '') {
      // Tenemos que volver a la zona de angular para asegurarnos de que hay un auto-digest
      _turnZone.run(() {
        mediaScreenWidthChangeController.add(message);
        _lastMessage = message;

        Logger.root.info('ScreenDetectorService: ScreenWidth is ' + message.toUpperCase());

        switch(message) {
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
          case "desktop":
            isXsScreen = false;
            isSmScreen = false;
            isDesktop = true;
          break;
        }
      });
    }

    // Seguimos detectando sin auto-digest
    window.animationFrame.then(_detectNow);
  }

  void scrollTo(String selector, {int offset: 0, int duration: 500, bool smooth : false, bool ignoreInDesktop: false}) {
    Function easingFunction;
    Easing easing;

    // Por defecto NO se ignora en desktop, es decir, se hace en todas las versiones
    if (ignoreInDesktop && isNotXsScreen) {
      return;
    }

    if(querySelector(selector) == null) {
      return;
    }

   int targetPosition = querySelector(selector).offsetTop;

    if (!smooth) {
      window.scroll(0, targetPosition);
    }
    else {
      easingFunction = Easing.getEasingFunction(easing);

      // Total de Frames
      int totalFrames = ( duration / (1000 / 60) ).round();
      int actualFrame = 0;

      // Posicion inicial de donde partimemos
      num actualPosition = window.scrollY;
      num currentTime = 0;
      num startValue = 0;
      num finalValue = null; // distance value;
      bool directionDown = null;

      if (targetPosition >= actualPosition) {
        finalValue = targetPosition - actualPosition + offset;
        directionDown = true;
      } else {
        finalValue = actualPosition - targetPosition - offset;
        directionDown = false;
      }

      void animation(num elapsedTime) {

        if (actualFrame < totalFrames) {
          currentTime += 1000 / 60;

          num positionInTime = easingFunction(currentTime, startValue, finalValue, duration);
          window.scrollTo(0, ((directionDown) ? (actualPosition + positionInTime) : (actualPosition - positionInTime)).round());
          actualFrame++;

          // Cuando este termina el frame (16.66 ms) inmediatamente empezamos el siguiente.
          window.animationFrame.then(animation);
        }
      }

      // Llamamos a la función anidada de animación por primera vez.
      _turnZone.runOutsideAngular(() => animation(0));
    }
  }

  VmTurnZone _turnZone;
  StreamController mediaScreenWidthChangeController = new StreamController.broadcast();
  String _lastMessage;
}