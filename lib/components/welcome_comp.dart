library welcome_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(selector: 'welcome', useShadowDom: false)
class WelcomeComp implements DetachAware {
  String stage;
  Map stage_params;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "welcome");
  }

  WelcomeComp(this._rootElement, this._router, this._reouteProvider,
      this._scrDet, this._profileService) {
    stage = _reouteProvider.route.parent.name;
    stage_params = _reouteProvider.route.parameters;
    composeHtml();
    _screenWidthChangeDetector = _scrDet.mediaScreenWidth
        .listen((String msg) => onScreenWidthChange(msg));
    if (stage == 'view_contest_entry') {
      // _profileService.finishTutorial();
    }
  }

  void composeHtml() {
    String html = '''
      <div id="welcomeRoot">
        <div class="main-box">

          <div class="panel">
      
            <div class="panel-heading">
              <div class="panel-title">${getTutorialTitle()}</div>
              <button id="btnCloseCross" type="button" class="close" button-action="CLOSE")">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
            </div>
      
            <div class="panel-body" >
              <div class="tut-title">${getTutorialText()}</div>
              <img class="tut-image" src="${getTutorialImage()}"/>
      
              <!-- BUTTONS -->
              <div class="input-group user-form-field">
                <div class="new-row">
                  <div class="autocentered-buttons-wrapper">
                     <div class="button-box"><button id="btnClose" button-action="CLOSE" class="ok-button">Got it!</button></div>
                  </div>
                </div>
              </div>
      
            </div>
          </div> 

        </div>
      </div>
    ''';
    createHTML(html);
  }

  String getTutorialTitle() {
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

  String getTutorialText() {
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

  String getTutorialImage() {
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

  void createHTML(String theHTML) {
    _rootElement.nodes.clear();
    _rootElement.setInnerHtml(theHTML, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.querySelectorAll("[button-action]").onClick
        .listen(buttonPressed);
  }

  void buttonPressed(event) {
    _router.go(stage, stage_params);
    if (stage == 'enter_contest') {
      // _profileService.startTutorial();
    }
  }

  void onScreenWidthChange(String msg) {
    composeHtml();
  }

  @override
  void detach() {
    _screenWidthChangeDetector.cancel();
  }

  Element _rootElement;
  Router _router;
  RouteProvider _reouteProvider;
  ScreenDetectorService _scrDet;
  ProfileService _profileService;
  var _screenWidthChangeDetector;
}
