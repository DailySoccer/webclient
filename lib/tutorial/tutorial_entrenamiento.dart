library tutorial_entrenamiento;

import 'package:webclient/utils/string_utils.dart';
import 'dart:async';
import 'package:webclient/tutorial/tutorial.dart';

class TutorialEntrenamiento extends Tutorial {
  static String STEP_1 = "1";

  String get PATH => "tutorial/entrenamiento/";

  TutorialEntrenamiento() {
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
            serverCalls: joinMaps([defaultServerCalls, {
              "get_active_contests" : (url, postData) => waitCompleter( () => getContentJson(PATH + "get_active_contests.json") ),
              "get_active_contest" : (url, postData) => getContentJson(PATH + "get_active_contest.json"),
              "get_contest_info" : (url, postData) => getContentJson(PATH + "get_contest_info.json"),
              "add_contest_entry": (url, postData) => addContestEntry(postData)
            }])
        ),
        STEP_1: new TutorialStep(
            enter: {
            },
            serverCalls: joinMaps([defaultServerCalls, {
              "get_my_contest_entry": (url, postData) => getContentJson(PATH + "get_active_contest.json"),
              "get_my_active_contest": (url, postData) => getContentJson(PATH + "get_active_contest.json")
            }])
        )
    };
  }

  Future addContestEntry(Map postData) {
    CurrentStepId = STEP_1;
    return emptyContent();
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorial_entrenamiento");
  }
}