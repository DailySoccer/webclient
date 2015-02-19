library welcome_lobby_comp;

import 'package:angular/angular.dart';
import 'dart:html';

@Component(
  selector: 'welcome-lobby',
  useShadowDom: false
)
class WelcomeLobbyComp {

  WelcomeLobbyComp(this._rootElement) {
    String html = ''' <div id="welcomeRoot">    
                        <div class="panel" style="font-size:20px;"> Mira capullo! <br> Se juega asín</div>
                      </div>
                  ''';
    _createHTML(html);
  }

  void _composeHtml() {

  }

  void _createHTML(String theHTML) {
    _rootElement.nodes.clear();
    _rootElement.appendHtml(theHTML);
    _rootElement.querySelectorAll("[buttonOnclick]").onClick.listen(_buttonPressed);
  }

  void _buttonPressed(event){
    _router.go('enter_contest', {});
  }

  Element _rootElement;
  Router _router;
}