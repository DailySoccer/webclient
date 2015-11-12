library backdrop_comp;

import 'dart:html';
import 'dart:async';

class BackdropComp {

  Stream<BackdropComp> get onClick => _onClick.stream;
  Stream<BackdropComp> get onShow => _onShow.stream;
  Stream<BackdropComp> get onHide => _onHide.stream;

  Element get backdropElement {
    if (_backdropElement == null) {
      _backdropElement = new Element.div();
      _backdropElement.id = "backdropComp";
      _backdropElement.classes.add("backdrop-comp");
      _backdropElement.onClick.listen((e) => _onClick.add(instance));
      querySelector('body').append(_backdropElement);
    }
    return _backdropElement;
  }

  static BackdropComp get instance {
    if (_instance == null) {
      _instance = new BackdropComp();
    }
    return _instance;
  }
  
  BackdropComp();
  
  void show() {
    backdropElement.classes.add('visible');
    backdropElement.onClick.listen((e) => _onClick.add(this));
    _onShow.add(this);
  }
  
  void hide() {
    if (backdropElement.classes.contains('visible')) {
      backdropElement.classes.remove('visible');
      _onHide.add(this);
    }
  }
  
  Element _backdropElement = null;
  static BackdropComp _instance = null;

  StreamController<BackdropComp> _onClick = new StreamController.broadcast();
  StreamController<BackdropComp> _onShow = new StreamController.broadcast();
  StreamController<BackdropComp> _onHide = new StreamController.broadcast();
}
