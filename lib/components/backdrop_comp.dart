library backdrop_comp;

import 'dart:html';

class BackdropComp {

  static Element get backdropElement {
    if (_backdropElement == null) {
      _backdropElement = querySelector('#backdropComp');
    }
    return _backdropElement;
  }
  
  BackdropComp();
  
  static void show([Function onHideCallback]) {
    _onHide = onHideCallback;
    backdropElement.classes.add('visible');
    backdropElement.onClick.listen((e) => hide());
  }
  
  static void hide() {
    if (_onHide != null) {
      // prevenir recursividad infinita (onHide llame a hide).
      var aux = _onHide;
      _onHide = null;
      aux();
    }
    
    backdropElement.classes.remove('visible');
  }
  
  static Element _backdropElement = null;
  static Function _onHide = null;
}
