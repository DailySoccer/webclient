library tutorial_service;
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/datetime_service.dart';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/tutorial/tutorial_oficial.dart';
import 'package:webclient/tutorial/tutorial_entrenamiento.dart';

@Injectable()
class TutorialService {
  static TutorialService get Instance {
    return _instance;
  }

  static bool get isActivated => _instance != null && _instance._activated;

  Tutorial CurrentTutorial;
  TutorialStep get CurrentStep => CurrentTutorial != null ? CurrentTutorial.CurrentStep : null;

  TutorialService(this._router) {
    _instance = this;

    _tutorials = [
      new TutorialEntrenamiento(),
      new TutorialOficial()
      ];

    CurrentTutorial = _tutorials[0];
  }

  void enterAt(String stage) {
    if (isActivated && CurrentStep.hasEnter(stage)) {
      InfoHtml tutorialInfo = CurrentStep.enter[stage];
      modalShow(tutorialInfo.title(), tutorialInfo.body(), type: 'welcome', modalSize: "lg");
      CurrentStep.removeEnter(stage);
      configureSkipComponent();
      tipAnElement("#activeContestList .contestSlot", "Prueba de una tip");
    }
  }

  void configureSkipComponent() {
    if (isActivated && _skipComp == null) {
      Element mainApp = querySelector('#mainContent');

      _skipComp = new Element.div();
      _skipComp.classes.add("skip-tutorial-button");
      _skipComp.appendText(getLocalizedText("skip-tutorial"));
      _skipComp.onClick.listen((e) => skipTutorial());

      mainApp.append(_skipComp);
    } else if (!isActivated && _skipComp != null) {
      _skipComp.remove();
      _skipComp = null;
    }
  }

  void tipAnElement(String cssSelector, String tipText, {bool hightlight: true, String position: 'top', String tipId: ''}) {
    Timer timer;
    timer = new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
      Element elem = querySelector(cssSelector);
      if (elem == null) return;
      elem.classes.add("tutorial-tipped-element");
      if (hightlight) {
        elem.classes.add("highlighted-tip");
      }

      /*Element tipWrapper = new Element.div();
      tipWrapper.classes.add("tutorial-tip-wrapper");
      ***/
      Element tip = new Element.div();
      tip.classes.addAll(["tutorial-tip", "$position"]);
      if (tipId != '') tip.id = tipId;
      tip.appendText(tipText);
      // tip.attributes['tiped-element'] = "#activeContestList .contests-list-f2p-root .contestSlot";
      tip.onClick.listen((e) {
        elem.classes.remove("tutorial-tipped-element");
        elem.classes.remove("highlighted-tip");
        tip.remove();
      });

      //tipWrapper.append(tip);
      elem.append(tip);

      timer.cancel();
    });

  }

  void skipTutorial() {
    _activated = false;
    configureSkipComponent();

    // Resto de funciones de saltar tutorial
    if (_contentUpdater != null) {
      _contentUpdater();
    }
    else {
      // Si no estamos en una pantalla en la que podamos actualizar el contenido correctamente, navegaremos al lobby
      _router.go('lobby', {});
    }
  }

  void registerContentUpdater(String name, Function contentUpdater) {
    if (isRefreshTimerLocked(name)) {
      _contentUpdater = contentUpdater;
    }
  }

  void cancelContentUpdater(String name) {
    if (isRefreshTimerLocked(name)) {
      _contentUpdater = null;
    }
  }

  bool isRefreshTimerLocked(String name) {
    return (name == RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST ||
        name == RefreshTimersService.SECONDS_TO_REFRESH_LIVE ||
        name == RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS);
  }

  bool isServerCallLocked(String url, {Map postData:null}) {
    return CurrentStep.serverCalls != null && CurrentStep.serverCalls.keys.any((pattern) => url.contains(pattern));
  }

  Future<Map> serverCall(String url, {Map postData:null}) {
    String key = CurrentStep.serverCalls.keys.firstWhere((pattern) => url.contains(pattern), orElse: () => null);
    return key != null ? CurrentStep.serverCalls[key](url, postData) : new Future.value({});
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorial");
  }

  Router _router;

  List<Tutorial> _tutorials;

  bool _activated = true;
  Element _skipComp = null;
  Function _contentUpdater = null;

  static TutorialService _instance;
}
