library tutorial_tip_service;

import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/backdrop_comp.dart';

@Injectable()
class TutorialTipService {

  static void tipAnElement(String cssSelector, String tipText, {bool hightlight: true, String position: 'top', String tipId: ''}) {
    
  }
  
}

class TutorialTip {
  
  TutorialTip(String cssSelector, String tipText, {bool hightlight: true, String position: 'top', String tipId: ''}) {
    _cssSelector = cssSelector;
    _tipText = tipText;
    _hightlight = hightlight;
    _position = position;
    _tipId = tipId;
  }
  
  void waitAndShow(Duration duration, [bool condition()]) {
    
  }

  void showAsSoonAsPossible([bool condition()]) {
    Timer timer;
    timer = new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
      if (condition != null && !condition()) return;
      Element elem = querySelector(_cssSelector);
      if (elem == null) return;
      elem.classes.add('tutorial-tipped-element${_hightlight? " highlighted-tip" : ""}');

      /*Element tipWrapper = new Element.div();
      tipWrapper.classes.add("tutorial-tip-wrapper");
      ***/
      Element tip = new Element.div();
      tip.classes.add("tutorial-tip $_position");
      if (_tipId != '') tip.id = _tipId;
      tip.appendText(_tipText);
      // tip.attributes['tiped-element'] = "#activeContestList .contests-list-f2p-root .contestSlot";
      var removeComponent = ([var e]) {
        elem.classes.remove("tutorial-tipped-element");
        elem.classes.remove("highlighted-tip");
        tip.remove();
      };
      tip.onClick.listen(removeComponent);

      //tipWrapper.append(tip);
      elem.append(tip);
      BackdropComp.show(removeComponent);

      timer.cancel();
    });
  }
  
  String _cssSelector;
  String _tipText;
  bool _hightlight;
  String _position;
  String _tipId;
}