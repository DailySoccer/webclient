library pages_tutorial_initial;

import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'pages-tutorial-initial',
  templateUrl: 'packages/webclient/tutorial/pages_tutorial_initial.html',
  useShadowDom: false
)
class PagesTutorialInitial {

  String currentSlide = "tutorialInitialSlide_1";
  bool showTutorial = false;
  
  PagesTutorialInitial(this._profileService) {
    _profileService.onLogin.listen((_) {
      _profileService.triggerEventualAction(ProfileService.PAGES_TUTORIAL_INITIAL, show);
    });
  }

  void nextSlide() {
    switch(currentSlide) {
      case "tutorialInitialSlide_1":
        currentSlide = "tutorialInitialSlide_2";
      break;
      case "tutorialInitialSlide_2":
        currentSlide = "tutorialInitialSlide_3";
      break;
      case "tutorialInitialSlide_3":
        close();
      break;
    }
  }
  
  void previousSlide() {
    switch(currentSlide) {
      case "tutorialInitialSlide_1":

      break;
      case "tutorialInitialSlide_2":
        currentSlide = "tutorialInitialSlide_1";
      break;
      case "tutorialInitialSlide_3":
        currentSlide = "tutorialInitialSlide_2";
      break;
    }
  }

  void close() {
    showTutorial = false;
    _profileService.eventualActionCompleted(ProfileService.PAGES_TUTORIAL_INITIAL);
  }
  void show() {
    showTutorial = true;
  }
  
  ProfileService _profileService;
}
