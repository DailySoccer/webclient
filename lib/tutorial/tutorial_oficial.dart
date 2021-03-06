library tutorial_oficial;

import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:angular/angular.dart';

class TutorialOficial extends Tutorial {
  String get PATH => "tutorial/oficial/";
  String get name => "TUTORIAL_OFICIAL";

  TutorialOficial(Router router, ProfileService profileService) : super(router, profileService) {
    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            triggers: {
              'lobby': () => openModal(
                            title: () => getLocalizedText("title-lobby"),
                            text: () => getLocalizedText("text-lobby"),
                            image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                          ),
              'enter_contest' : () => openModal(
                            title: () => getLocalizedText("title-entercontest"),
                            text: () => getLocalizedText("text-entercontest"),
                            image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                          ),
              'view_contest_entry': () => openModal(
                            title: () => getLocalizedText("title-viewcontestentry"),
                            text: () => getLocalizedText("text-viewcontestentry"),
                            image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                          )
            },
            serverCalls: joinMaps([defaultServerCalls, {
              "get_active_contests" : (url, postData) => waitCompleter( () => getContentJson(PATH + "get_active_contests.json") ),
              "get_active_contest" : (url, postData) => getContentJson(PATH + "get_active_contest.json"),
              "get_contest_info" : (url, postData) => getContentJson(PATH + "get_contest_info.json")
            }])
        )
    };
  }

  void activate() {
    CurrentStepId = Tutorial.STEP_BEGIN;
    changeUser(TutorialPlayer(goldBalance: "AUD 5.00"));
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorial_oficial");
  }
}