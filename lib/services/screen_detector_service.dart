library screen_detector_service;

import 'dart:js';
import 'package:angular/angular.dart';


@Injectable()
class ScreenDetectorService {

  bool isXsScreen = false;

  ScreenDetectorService(this._scope) {

    if (context['matchMedia'] != null) {
        final mq = context.callMethod('matchMedia', ['(min-width: 767px)']);
        mq.callMethod('addListener', [onWidthChange]);
        onWidthChange(mq);
      }

    /*
    new Timer.periodic(new Duration(milliseconds: 1000), (Timer timer) {
      //isXsScreen = !isXsScreen;
      print("Hi $isXsScreen");
    });
    */
  }

  void onWidthChange(mq) {
     isXsScreen = !mq['matches'];

    // Si no hacemos esto no se entera del cambio en la variable. Sin embargo, hemos probado a hacer el cambio de variable
    // dentro de un timer y ahi si funciona, no sabemos por que.
    _scope.apply();

  }

  Scope _scope;
}