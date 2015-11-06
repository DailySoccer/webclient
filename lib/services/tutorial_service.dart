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
import 'package:webclient/services/tooltip_service.dart';
import 'package:webclient/services/profile_service.dart';

@Injectable()
class TutorialService {
  static TutorialService get Instance {
    return _instance;
  }

  static bool get isActivated => _instance != null && _instance._activated;

  Tutorial CurrentTutorial;
  TutorialStep get CurrentStep => CurrentTutorial != null ? CurrentTutorial.CurrentStep : null;

  TutorialService(this._router, ProfileService profileService) {
    _instance = this;

    _tutorials = [
      new TutorialEntrenamiento(profileService),
      new TutorialOficial(profileService)
      ];

    CurrentTutorial = _tutorials[0];
  }

  void enterAt(String stage) {
    if (isActivated && CurrentStep.hasEnter(stage)) {
      InfoHtml tutorialInfo = CurrentStep.enter[stage];

      ToolTip firstTip = new ToolTip("#activeContestList .contestSlot",
                                              tipText: "Tip sin highlight",
                                              delay: new Duration(seconds: 1),
                                              highlight: false);

      ToolTip secondTip_1 = new ToolTip("week-calendar .week-calendar", tipText: "Tip dependiente de la primera", delay: new Duration(milliseconds: 200));
      ToolTip secondTip_2 = new ToolTip("#activeContestList .contestSlot", tipText: "Tip simultanea y con retardo", delay: new Duration(seconds: 2), position: "bottom");

      modalShow(tutorialInfo.title(), tutorialInfo.body(), type: 'welcome', modalSize: "lg");
        /*.then( (_) => TutorialTipService.instance.tipElement(firstTip)
        .then( (_) => TutorialTipService.instance.tipMultipleElement([secondTip_1, secondTip_2])) );*/
      ToolTipService.instance.tipElement(firstTip, hideOnClick: true);
      firstTip.onHide.listen((_) => ToolTipService.instance.tipMultipleElement([secondTip_1, secondTip_2], hideAllOnClick: true));

      CurrentStep.removeEnter(stage);
      configureSkipComponent();
      //TutorialTipService.tipAnElement("#activeContestList .contestSlot", "Prueba de una tip");
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
