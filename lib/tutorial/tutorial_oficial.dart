library tutorial_oficial;

import 'package:webclient/utils/string_utils.dart';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import 'package:webclient/tutorial/tutorial.dart';

class TutorialOficial extends Tutorial {
  String get PATH => "tutorial/oficial/";

  TutorialOficial() {
    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            enter: {
              'lobby': new InfoHtml(
                  title: () => getLocalizedText("title-lobby"),
                  text: () => getLocalizedText("text-lobby"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                ),
              'enter_contest' : new InfoHtml(
                  title: () => getLocalizedText("title-entercontest"),
                  text: () => getLocalizedText("text-entercontest"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                ),
              'view_contest_entry': new InfoHtml(
                  title: () => getLocalizedText("title-viewcontestentry"),
                  text: () => getLocalizedText("text-viewcontestentry"),
                  image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                )
            },
            serverCalls: {
              "get_active_contests" : (url, postData) => waitCompleter( () => getActiveContests() ),
              "get_active_contest" : (url, postData) => getActiveContest(url),
              "get_contest_info" : (url, postData) => getContestInfo(url)
            }
        )
    };
  }

  Future getActiveContests() {
    var completer = new Completer();
    HttpRequest.getString(PATH + "get_active_contests.json").then((json) {
        completer.complete(JSON.decode(json));
      });
    return completer.future;
  }

  Future getActiveContest(String url) {
    var completer = new Completer();

    HttpRequest.getString(PATH + "get_active_contest.json").then((json) {
        completer.complete(JSON.decode(json));
      });

    return completer.future;
  }

  Future getContestInfo(String url) {
    var completer = new Completer();

    HttpRequest.getString(PATH + "get_contest_info.json").then((json) {
        completer.complete(JSON.decode(json));
      });

    return completer.future;
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorial_oficial");
  }
}