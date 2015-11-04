library tutorial;

import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/string_utils.dart';

class InfoHtml {
  Function title;
  Function text;
  Function image;

  String body() => '''
    <div class="tut-title">${text()}</div>
    <img class="tut-image-xs" src="${image(size:'xs')}"/>
    <img class="tut-image" src="${image()}"/>
  ''';

  InfoHtml({this.title: null, this.text: null, this.image: null});
}

class TutorialStep {
  Map<String, InfoHtml> enter;
  Map<String, Function> serverCalls;
  TutorialStep({this.enter: null, this.serverCalls: null});

  bool hasEnter(String path) => enter != null && enter.containsKey(path);
  void removeEnter(String path) { if (hasEnter(path)) enter.remove(path); }
}

class Tutorial {
  static String STEP_BEGIN = "begin";
  static String STEP_END = "end";

  String CurrentStepId = STEP_BEGIN;
  TutorialStep get CurrentStep => tutorialSteps[CurrentStepId];

  bool get isCompleted => CurrentStepId == STEP_END;

  Tutorial();

  Future emptyContent() {
    return new Future.value({});
  }

  Future getContentJson(String fileName) {
    var completer = new Completer();
    HttpRequest.getString(fileName).then((json) {
        completer.complete(JSON.decode(json));
      });
    return completer.future;
  }

  Future waitCompleter(Function callback) {
    // TODO: Cuando estamos en desarrollo y el simulador no está activo, se tarda tiempo en configurar el fakeTime
    if (DateTimeService.isReady) {
      return new Future.value(callback());
    }
    else {
      var completer = new Completer();
      new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
        if (DateTimeService.isReady) {
          completer.complete(callback());
          t.cancel();
        }
      });
      return completer.future;
    }
  }

  HashMap<String, TutorialStep> tutorialSteps;
}