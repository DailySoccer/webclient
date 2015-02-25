library welcome_lobby_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
  selector: 'welcome-lobby',
  useShadowDom: false
)
class WelcomeLobbyComp {
  String stage;
  WelcomeLobbyComp(this._rootElement, this._router, this._reouteProvider, this._scrDet) {
    stage = _reouteProvider.route.parent.name;
    composeHtml();
    _screenWidthChangeDetector = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void composeHtml() {

    String html = '''
      <div id="welcomeLobbyRoot">
        <div class="main-box">

          <div class="panel">
      
            <div class="panel-heading">
              <div class="panel-title">SELECT A CONTEST</div>
              <button id="btnCloseCross" type="button" class="close" button-action="CLOSE")">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
            </div>
      
            <div class="panel-body" >
              <div class="tut-title">${getTutorialText(stage)}</div>
              <img class="tut-image" src="${getTutorialImage(stage)}"/>
      
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

  String getTutorialText(String stage) {
    String text;
    switch(stage) {
      case 'lobby':
        text ='You can play in as many tournaments as you want from La Liga, Premier League and Champions League';
      break;
      case 'enter_contest':
        text ='Elige tu fantastica alineación sin pasarte de salary cap';
      break;
    }
    return text;
  }

  String getTutorialImage(String stage) {
    String imagePath;
    switch(stage) {
      case 'lobby':
        imagePath = "images/tutorial/" + (_scrDet.isXsScreen ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg");
      break;
      case 'enter_contest':
        imagePath = "images/tutorial/" + (_scrDet.isXsScreen ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg");
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
    String dest;
    Map params = {};
    var buttonAction =  event.target is SpanElement ? event.target.parent.attributes['button-action'] : event.target.attributes['button-action'];
    switch(buttonAction) {
      case "CLOSE":
        dest = 'lobby';
      break;
    }

    _router.go(dest, params);
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
  var _screenWidthChangeDetector;
}