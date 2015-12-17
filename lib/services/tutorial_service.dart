library tutorial_service;
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/datetime_service.dart';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/tutorial/tutorial_oficial.dart';
import 'package:webclient/tutorial/tutorial_entrenamiento.dart';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/services/tooltip_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/components/backdrop_comp.dart';

@Injectable()
class TutorialService {
  static TutorialService get Instance {
    return _instance;
  }

  static bool get isActivated => _instance != null && _instance._activated;

  Tutorial CurrentTutorial;
  TutorialStep get CurrentStep => CurrentTutorial != null ? CurrentTutorial.CurrentStep : null;

  TutorialService(this._router, this._profileService, this._ttservice) {
    _instance = this;

    _availables = [
      new TutorialIniciacion(this._router, _profileService),
    ];

    // Incluir los tutoriales que no se hayan terminado
    _tutorials = {};
    _availables.where((tutorial) => !isCompleted(tutorial.name)).forEach((t) => _tutorials[t.name] = t);
  }

  bool isCompleted(String tutorialKey) {
    return window.localStorage.containsKey(tutorialKey);
  }

  void start(String tutorialName) {
    if (_tutorials.containsKey(tutorialName)) {
      _activated = true;
      CurrentTutorial = _tutorials[tutorialName];
      CurrentTutorial.activate();
      querySelector('body').classes.add('tutorial');
      disableElementEvents('main-menu-f2p');
      disableElementEvents('footer');

      _router.go('lobby', {});
    }
  }

  void restart(String tutorialName) {
    if (!_tutorials.containsKey(tutorialName)) {
      Tutorial tutorial = _availables.firstWhere((t) => t.name == tutorialName, orElse: () => null);
      if (tutorial != null) {
        _tutorials[tutorialName] = tutorial;
      }
    }
    start(tutorialName);
  }

  void disableElementEvents(String cssSelector) {
    querySelector(cssSelector).classes.add('disabled-pointer-events');
  }
  void enableElementEvents(String cssSelector) {
    querySelector(cssSelector).classes.remove('disabled-pointer-events');
  }

  void triggerEnter(String trigger, {bool activateIfNeeded: true, Object component: null}) {
    // Si ningún tutorial está activado, comprobamos si existe alguno que quiera responder al path que ha visitado el usuario
    if (!isActivated && activateIfNeeded) {
      CurrentTutorial = _tutorials.values.firstWhere((tutorial) => !tutorial.isCompleted && tutorial.CurrentStep.hasTrigger(trigger), orElse: () => null);
      _activated = CurrentTutorial != null;

      if (CurrentTutorial != null) {
        CurrentTutorial.activate();
        querySelector('body').classes.add('tutorial');
        disableElementEvents('main-menu-f2p');
        disableElementEvents('footer');
      }
    }

    // Si existe un tutorial activado, permitimos que continúe...
    if (isActivated && CurrentStep.hasTrigger(trigger)) {
      CurrentTutorial.triggerEnter(trigger, component: component);
      configureSkipComponent();
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


  void skipTutorial({String routePath: 'home'}) {
    _activated = false;
    configureSkipComponent();

    window.localStorage[CurrentTutorial.name] = CurrentTutorial.CurrentStepId;

    CurrentTutorial.restoreUser();
    CurrentTutorial.skipTutorial();
    enableElementEvents('main-menu-f2p');
    enableElementEvents('footer');

    /*
    // Resto de funciones de saltar tutorial
    if (_contentUpdater != null) {
      _contentUpdater();
    }
    else {
      // Si no estamos en una pantalla en la que podamos actualizar el contenido correctamente, navegaremos al home
      _router.go('home', {});
    }
   */

    modalClose(type: 'welcome');
    _ttservice.clear();
    BackdropComp.instance.hide(forceUpdate: true);
    querySelector('body').classes.remove('tutorial');

    _router.go(routePath, {});
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
  ProfileService _profileService;

  Map<String, Tutorial> _tutorials;

  bool _activated = false;
  Element _skipComp = null;
  Function _contentUpdater = null;
  List<Tutorial> _availables;

  static TutorialService _instance;
  ToolTipService _ttservice;
}
