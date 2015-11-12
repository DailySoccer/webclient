library tutorial_tip_service;

import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/components/backdrop_comp.dart';

@Injectable()
class ToolTipService {

  static ToolTipService get instance {
    if(_instance == null)
      _instance = new ToolTipService();
    return _instance;
  }

  ToolTipService();

  void tipElement(ToolTip tip, {bool hideOnClick: true}) {
    BackdropComp backdrop = BackdropComp.instance;
    StreamSubscription subscription = null;

    void hideTip([_]) {
      tip.hide();
      if (tip.isHighlight) backdrop.hide();
      if (subscription != null) subscription.cancel();
    };

    if (tip.isHighlight) {
      tip.onShow.listen((_) => backdrop.show());
      if (hideOnClick) subscription = backdrop.onClick.listen(hideTip);
    }

    if (hideOnClick) tip.onClick.listen(hideTip);

    tip.show();
  }

  Future tipMultipleElement(List<ToolTip> tipList, {bool hideAllOnClick: true}) {
    Completer completer = new Completer();
    BackdropComp backdrop = BackdropComp.instance;

    void notifyFirstShow(ToolTip tip) {
      if (!completer.isCompleted) completer.complete(tip);
    }
    void hideAll([_]) {
      tipList.forEach( (tip) => tip.hide() );
      backdrop.hide();
    };

    tipList.forEach( (tip) {

      if (tip.isHighlight) tip.onShow.listen((_) => backdrop.show());

      if (hideAllOnClick) tip.onClick.listen(hideAll);

      tip.onShow.listen(notifyFirstShow);
      tip.show();
    });

    if (hideAllOnClick) backdrop.onClick.listen(hideAll);

    return completer.future;
  }

  static ToolTipService _instance = null;
}

class ToolTip {

  Stream<ToolTip> get onClick => _onClick.stream;
  Stream<ToolTip> get onShow => _onShow.stream;
  Stream<ToolTip> get onHide => _onHide.stream;

  bool get isHighlight => _highlight;
  bool get isShown => _isShown;
  bool get hasDuration => _duration.inMicroseconds > 0;

  ToolTip(String cssSelector,
          {String tipText: null, bool highlight: false,
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


  void show() {
    new Timer(_delay, () => _showAsSoonAsPossible() );
  }

  void hide() {
    if (!_isShown) return;

    _theTippedElem.classes.remove("tutorial-tipped-element");
    if (_highlight) _theTippedElem.classes.remove("highlighted-tip");
    if (_theTip != null) _theTip.remove();
    _isShown = false;
    _onHide.add(this);
  }

  void _showAsSoonAsPossible() {
    Timer timer;
    timer = new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {

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

      _isShown = true;
      _onShow.add(this);
      timer.cancel();

      if (_duration != null && _duration != Duration.ZERO) {
        new Timer(_duration, () => _onClick.add(this));
      }
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
  bool _isShown = false;

  StreamController<ToolTip> _onClick = new StreamController.broadcast();
  StreamController<ToolTip> _onShow = new StreamController.broadcast();
  StreamController<ToolTip> _onHide = new StreamController.broadcast();
}