library welcome_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
  selector: 'welcome',
  useShadowDom: false
)
class WelcomeComp {
  String stage;
  Map stage_params;
  WelcomeComp(this._rootElement, this._router, this._reouteProvider, this._scrDet, this._profileService) {
    stage = _reouteProvider.route.parent.name;
    stage_params = _reouteProvider.route.parameters;
    composeHtml();
    _screenWidthChangeDetector = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
    if (stage == 'view_contest_entry') {
      _profileService.finishTutorial();
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
    switch(stage) {
      case 'lobby':
        title ='SELECT A CONTEST';
      break;
      case 'enter_contest':
        title ='SELECT YOUR LINEUP';
      break;
      case 'view_contest_entry':
        title ='WELCOME TO EPICELEVEN';
      break;
    }
    return title;
  }

  String getTutorialText() {
    String text;
    switch(stage) {
      case 'lobby':
        text ='You can play as many contests as you like for La Liga BBVA, Barclays Premier League and UEFA Champions League.';
      break;
      case 'enter_contest':
        text ='Pick up 11 player within your salary cap.';
      break;
      case 'view_contest_entry':
        text ='Go to “<b>My Contest</b>” to edit your lineups, watch your team’s live performance or review past contests. <br> <br> <p class="subtitle">Remember: you can play as many contests as you like, and select as many lineups as you like.</p>';
      break;
    }
    return text;
  }

  String getTutorialImage() {
    String imagePath;
    switch(stage) {
      case 'lobby':
        imagePath = "images/tutorial/" + (_scrDet.isXsScreen ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg");
      break;
      case 'enter_contest':
        imagePath = "images/tutorial/" + (_scrDet.isXsScreen ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg");
      break;
      case "view_contest_entry":
        imagePath = "images/tutorial/" + (_scrDet.isXsScreen ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg");
      break;
    }
    return imagePath;
  }

  void createHTML(String theHTML) {
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll("[button-action]").onClick.listen(buttonPressed);
  }

  void buttonPressed(event){
    _router.go(stage, stage_params);
    if (stage == 'enter_contest') {
      _profileService.startTutorial();
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
  ProfileService  _profileService;
  var _screenWidthChangeDetector;
}