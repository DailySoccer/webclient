library unusual_utils;
import 'dart:html';
import 'dart:math';
import 'package:webclient/services/screen_detector_service.dart';

class UnusualUtils {

  static String normalize(String txt) {
    String from = "ÃÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛãàáäâèéëêìíïîòóöôùúüûÑñÇç";
    String to   = "AAAAAEEEEIIIIOOOOUUUUaaaaaeeeeiiiioooouuuunncc";
    Map map = {};

    for (int i = 0; i < from.length; i++ ) {
      map[ from[i] ] = to[i];
    }

    String ret = '';
    String c = '';
    for( int i = 0, j = txt.length; i < j; i++ ) {
      c = txt[i];
      ret += map.containsKey(c) ? map[c] : c;
    }

    return ret.toLowerCase();
  }

  static bool isValidEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  static void scrollTo(String selector, {int offset: 0, int duration: 500, bool smooth : false, bool ignoreInDesktop: false, ScreenDetectorService screenDetector: null}) {
       // Por defecto (salvo que se especifique TRUE), el scroll se ignorará en las versiones de Desktop.
       if(ignoreInDesktop && screenDetector.isNotXsScreen) {
         return;
       }

       int targetPosition = querySelector(selector).offsetTop + offset;

       if(!smooth) {
         window.scroll(0, targetPosition);
       }
       else {
         int currentFrame = 0;
         // Total de Frames
         int totalFrames = ( duration / (1000 / 60) ).round();
         // Posicion inicial de donde partimemos
         int basePosition = window.scrollY;

         int currentPosition = window.scrollY;
         // variable puente para para sumar los decimales (El scroll necesita un parametro Int).
         double incremented = 0.0;
          // Distancia total a recorer por el Scroll
         int distanceBetween =  targetPosition - currentPosition;

         void animation(num frame) {
           if ( totalFrames >= currentFrame ) {
             // Movimiento deceleradoacelerado
             incremented = pow((currentFrame/totalFrames), 2) * distanceBetween;
             currentPosition = incremented.toInt() + basePosition;

             window.scrollTo( 0, currentPosition );
             currentFrame++;

             // Cuando este termina el frame (16.66 ms) inmediatamente empezamos el siguiente.
             window.animationFrame.then(animation);
           }
         }

         // Llamamos a la función anidada de animación por primera vez.
         window.animationFrame.then(animation);
       }
     }

}