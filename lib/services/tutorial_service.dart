library tutorial_service;
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/html_utils.dart';
import 'dart:collection';

@Injectable()
class TutorialService {
  TutorialService(this._scrDet, this._profileService);

  void enterAt(String stage) {
    if (showTutorialAt(stage)) {
      modalShow(getTutorialTitle(stage), bodyHtml(stage), modalSize: "90percent");
      tutorialShown(stage);
    }
  }

  String bodyHtml(String stage) {
    return '''
        <div class="panel-body" >
          <div class="tut-title">${getTutorialText(stage)}</div>
          <img class="tut-image" src="${getTutorialImage(stage)}"/>
        </div>
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

  String getTutorialImage(String stage) {
    String imagePath;
    switch (stage) {
      case 'lobby':
        imagePath = "images/tutorial/" +
            (_scrDet.isXsScreen
                ? "welcomeLobbyXs.jpg"
                : "welcomeLobbyDesktop.jpg");
        break;
      case 'enter_contest':
        imagePath = "images/tutorial/" +
            (_scrDet.isXsScreen
                ? "welcomeTeamXs.jpg"
                : "welcomeTeamDesktop.jpg");
        break;
      case "view_contest_entry":
        imagePath = "images/tutorial/" +
            (_scrDet.isXsScreen
                ? "welcomeSuccessXs.jpg"
                : "welcomeSuccessDesktop.jpg");
        break;
    }
    return imagePath;
  }

  bool showTutorialAt(String location) {
    return _profileService.isWelcoming && _tutorialInfo.containsKey(location);
  }

  String gotoTutorialAt(String location) {
    return _tutorialInfo.containsKey(location) ? _tutorialInfo[location] : location;
  }

  void tutorialShown(String location) {
    _tutorialInfo.remove(location);
  }

  HashMap<String, bool> _tutorialInfo = {
    'lobby' : true,
    'enter_contest' : true
  };

  ScreenDetectorService _scrDet;
  ProfileService _profileService;
}