library tutorial_service;
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';

class TutorialInfo {
  Function title;
  Function text;
  Function image;
  TutorialInfo({this.title: null, this.text: null, this.image: null});
}

class TutorialStep {
  Map<String, TutorialInfo> enter;
  Map<String, Function> serverCalls;
  TutorialStep({this.enter: null, this.serverCalls: null});

  bool hasEnter(String path) => enter != null && enter.containsKey(path);
  void removeEnter(String path) { if (hasEnter(path)) enter.remove(path); }
}

@Injectable()
class TutorialService {
  static String STEP_BEGIN = "begin";
  static String STEP_END = "end";

  static TutorialService get Instance {
    return _instance;
  }

  static bool get isActivated => _instance != null && _instance._activated;

  String StepId = STEP_BEGIN;
  TutorialStep get Step => _tutorialSteps[StepId];

  TutorialService() {
    _instance = this;

    _tutorialSteps = {
      STEP_BEGIN: new TutorialStep(
            enter: {
              'lobby': new TutorialInfo(
                  title: () => getLocalizedText("tutorialtittlelobby"),
                  text: () => getLocalizedText("tutorialtextlobby"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                ),
              'enter_contest' : new TutorialInfo(
                  title: () => getLocalizedText("tutorialtittleentercontest"),
                  text: () => getLocalizedText("tutorialtextentercontest"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                ),
              'view_contest_entry': new TutorialInfo(
                  title: () => getLocalizedText("tutorialtittleviewcontestentry"),
                  text: () => getLocalizedText("tutorialtextviewcontestentry"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                )
            })
    };

    _serverCalls = {
      "get_active_contests" : (url, postData) {
          return new Future.value(JSON.decode(getActiveContestsJSON));
        }
    };
  }

  void enterAt(String stage) {
    if (isActivated && Step.hasEnter(stage)) {
      TutorialInfo tutorialInfo = Step.enter[stage];
      modalShow(tutorialInfo.title(), bodyHtml(tutorialInfo), type: 'welcome', modalSize: "lg");
      Step.removeEnter(stage);
      configureSkipComponent();
    }
  }

  void configureSkipComponent() {
    if (isActivated && _skipComp == null) {
      Element mainApp = querySelector('#mainContent');

      _skipComp = new Element.div();
      _skipComp.classes.add("skip-tutorial-button");
      _skipComp.appendText("Saltar tutorial");
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
  }

  bool isServerCallLocked(String url, {Map postData:null}) {
    return _serverCalls.keys.any((pattern) => url.contains(pattern));
  }

  Future<Map> serverCall(String url, {Map postData:null}) {
    String key = _serverCalls.keys.firstWhere((pattern) => url.contains(pattern), orElse: () => null);
    return key != null ? _serverCalls[key](url, postData) : new Future.value({});
  }

  String bodyHtml(TutorialInfo info) {
    return '''
      <div class="tut-title">${info.text()}</div>
      <img class="tut-image-xs" src="${info.image(size:'xs')}"/>
      <img class="tut-image" src="${info.image()}"/>
    ''';
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "welcome");
  }

  String gotoTutorialAt(String location) {
    return _tutorialInfo.containsKey(location) ? _tutorialInfo[location] : location;
  }

  HashMap<String, bool> _tutorialInfo = {
    'lobby' : true,
    'enter_contest' : true,
    'view_contest_entry' : true
  };

  HashMap<String, TutorialStep> _tutorialSteps;
  Map<String, Function> _serverCalls;

  static String getActiveContestsJSON = '''
    {"contests":[{"templateContestId":"56331ce6d4c6912cf152f1f1","state":"ACTIVE","name":"Tutorial [Oficial]","contestEntries":[],"maxEntries":100,"salaryCap":70000,"entryFee":"AUD 1.00","prizeMultiplier":0.9,"prizeType":"WINNER_TAKES_ALL","startDate":1445625000000,"optaCompetitionId":"23","simulation":false,"specialImage":"","numEntries":0,"_id":"56331d69d4c6912cf152f1f6"},{"templateContestId":"56331d4dd4c6912cf152f1f4","state":"ACTIVE","name":"Tutorial [Entrenamiento]","contestEntries":[],"maxEntries":20,"salaryCap":70000,"entryFee":"JPY 1","prizeMultiplier":10.0,"prizeType":"FIFTY_FIFTY","startDate":1445335200000,"optaCompetitionId":"23","simulation":true,"specialImage":"","numEntries":0,"_id":"56331d69d4c6912cf152f201"}]}
  ''';

  bool _activated = true;
  Element _skipComp = null;

  static TutorialService _instance;
}