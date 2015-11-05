library tutorial_tip_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/backdrop_comp.dart';

@Injectable()
class TutorialTipService {
  
  static TutorialTipService get instance {
    if(_instance == null)
      _instance = new TutorialTipService();
    return _instance;
  }
  
  TutorialTipService() { }
  
  Future tipElement(TutorialTip tip) {
    Completer completer = new Completer();
    
    var hideTip = () {
      tip.hide();
      completer.complete();
    };
    
    if (tip.isHighlight) {
      tip.onClick.listen((_) {
          BackdropComp.hide();
          //hideTip();
        });
      tip.onShow.listen((_) => BackdropComp.show(hideTip));
    } else {
      tip.onClick.listen( (_) => hideTip() );
    }
    
    tip.show();
    return completer.future;
  }
  
  Future tipMultipleElement(List<TutorialTip> tipList) {
    Completer completer = new Completer();
    
    var hideAll = () {
      tipList.forEach( (tip) => tip.hide() );
      completer.complete();
    };
    
    tipList.forEach( (tip) {
      tip.onClick.listen( (_) {
        BackdropComp.hide();
        //hideAll();
      });
      tip.show();
      tip.onShow.listen((_) => BackdropComp.show(hideAll));
    });
    
    return completer.future;
  }

  static TutorialTipService _instance = null;
}

class TutorialTip {

  StreamController<TutorialTip> _onClick = new StreamController.broadcast();
  Stream<TutorialTip> get onClick => _onClick.stream;
  StreamController<TutorialTip> _onShow = new StreamController.broadcast();
  Stream<TutorialTip> get onShow => _onShow.stream;
  StreamController<TutorialTip> _onHide = new StreamController.broadcast();
  Stream<TutorialTip> get onHide => _onHide.stream;
  
  bool get isHighlight => _highlight;
  
  
  TutorialTip(String cssSelector, {String tipText: null, bool highlight: true, 
              String position: 'top', String tipId: '',
              Duration delay: Duration.ZERO, Duration duration: Duration.ZERO}) {
    _cssSelector = cssSelector;
    _tipText = tipText;
    _highlight = highlight;
    _position = position;
    _tipId = tipId;
    _delay = delay;
    _duration = duration;
  }
  
  
  void show([bool condition()]) {
    new Timer(_delay, () => _showAsSoonAsPossible(condition) );
    
    if (_duration != null && _duration != Duration.ZERO) {
      new Timer(_duration, () => _onClick.add(this) );
    }
  }
  
  void hide() {
    _theTippedElem.classes.remove("tutorial-tipped-element");
    _theTippedElem.classes.remove("highlighted-tip");
    if (_theTip != null) _theTip.remove();
    _onHide.add(this);
  }
  
  void _showAsSoonAsPossible([bool condition()]) {
    Timer timer;
    timer = new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
      
      if (condition != null && !condition()) return;
      _theTippedElem = querySelector(_cssSelector);
      if (_theTippedElem == null) return;
      
      _theTippedElem.classes.add('tutorial-tipped-element');
      if (_highlight) _theTippedElem.classes.add('highlighted-tip');

      if (_tipText != null && _tipText != '') {
        _theTip = new Element.div();
        _theTip.classes.addAll(["tutorial-tip", _position]);
        if (_tipId != '') _theTip.id = _tipId;
        _theTip.appendText(_tipText);
        _theTip.onClick.listen((e) {
          _onClick.add(this);
          e.stopImmediatePropagation();
        });
        
        _theTippedElem.append(_theTip);
      }
      
      _onShow.add(this);
      timer.cancel();
    });
  }
  
  String _cssSelector;
  String _tipText;
  bool _highlight;
  String _position;
  String _tipId;
  Duration _delay;
  Duration _duration;

  Element _theTip = null;
  Element _theTippedElem;
  
}