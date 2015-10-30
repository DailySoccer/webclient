library tutorial_service;
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;

@Injectable()
class TutorialService {

  static TutorialService get Instance {
    return _instance;
  }

  static bool get isActivated => _instance != null && _instance._activated;

  TutorialService() {
    _instance = this;

    _serverCalls = {
      "get_active_contests" : (url, postData) {
          return new Future.value(JSON.decode(getActiveContestsJSON));
        }
    };
  }

  void enterAt(String stage) {
    if (showTutorialAt(stage)) {
      modalShow(getTutorialTitle(stage), bodyHtml(stage), type: 'welcome', modalSize: "lg");
      tutorialShown(stage);
    }
  }

  bool isServerCallLocked(String url, {Map postData:null}) {
    return _serverCalls.keys.any((pattern) => url.contains(pattern));
  }

  Future<Map> serverCall(String url, {Map postData:null}) {
    String key = _serverCalls.keys.firstWhere((pattern) => url.contains(pattern), orElse: () => null);
    return key != null ? _serverCalls[key](url, postData) : new Future.value({});
  }

  String bodyHtml(String stage) {
    return '''
      <div class="tut-title">${getTutorialText(stage)}</div>
      <img class="tut-image-xs" src="${getTutorialImage(stage, size:'xs')}"/>
      <img class="tut-image" src="${getTutorialImage(stage)}"/>
    ''';
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "welcome");
  }

  String getTutorialTitle(String stage) {
    String title;
    switch (stage) {
      case 'lobby':
        title = getLocalizedText("tutorialtittlelobby");
        break;
      case 'enter_contest':
        title = getLocalizedText("tutorialtittleentercontest");
        break;
      case 'view_contest_entry':
        title = getLocalizedText("tutorialtittleviewcontestentry");
        break;
    }
    return title;
  }

  String getTutorialText(String stage) {
    String text;
    switch (stage) {
      case 'lobby':
        text = getLocalizedText("tutorialtextlobby");
        break;
      case 'enter_contest':
        text = getLocalizedText("tutorialtextentercontest");
        break;
      case 'view_contest_entry':
        text = getLocalizedText("tutorialtextviewcontestentry");
        break;
    }
    return text;
  }

  String getTutorialImage(String stage, {String size: ''}) {
    String imagePath;
    switch (stage) {
      case 'lobby':
        imagePath = "images/tutorial/" +
            (size == 'xs'
                ? "welcomeLobbyXs.jpg"
                : "welcomeLobbyDesktop.jpg");
        break;
      case 'enter_contest':
        imagePath = "images/tutorial/" +
            (size == 'xs'
                ? "welcomeTeamXs.jpg"
                : "welcomeTeamDesktop.jpg");
        break;
      case "view_contest_entry":
        imagePath = "images/tutorial/" +
            (size == 'xs'
                ? "welcomeSuccessXs.jpg"
                : "welcomeSuccessDesktop.jpg");
        break;
    }
    return imagePath;
  }

  bool showTutorialAt(String location) {
    return isActivated && _tutorialInfo.containsKey(location);
  }

  String gotoTutorialAt(String location) {
    return _tutorialInfo.containsKey(location) ? _tutorialInfo[location] : location;
  }

  void tutorialShown(String location) {
    _tutorialInfo.remove(location);
  }

  HashMap<String, bool> _tutorialInfo = {
    'lobby' : true,
    'enter_contest' : true,
    'view_contest_entry' : true
  };

  Map<String, Function> _serverCalls;

  static String getActiveContestsJSON = '''
    {"contests":[{"templateContestId":"56331ce6d4c6912cf152f1f1","state":"ACTIVE","name":"Tutorial [Oficial]","contestEntries":[],"maxEntries":100,"salaryCap":70000,"entryFee":"AUD 1.00","prizeMultiplier":0.9,"prizeType":"WINNER_TAKES_ALL","startDate":1445625000000,"optaCompetitionId":"23","simulation":false,"specialImage":"","numEntries":0,"_id":"56331d69d4c6912cf152f1f6"},{"templateContestId":"56331d4dd4c6912cf152f1f4","state":"ACTIVE","name":"Tutorial [Entrenamiento]","contestEntries":[],"maxEntries":20,"salaryCap":70000,"entryFee":"JPY 1","prizeMultiplier":10.0,"prizeType":"FIFTY_FIFTY","startDate":1445335200000,"optaCompetitionId":"23","simulation":true,"specialImage":"","numEntries":0,"_id":"56331d69d4c6912cf152f201"}]}
  ''';

  bool _activated = true;

  static TutorialService _instance;
}