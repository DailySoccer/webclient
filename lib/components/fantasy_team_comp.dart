library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';


@Component(selector: 'fantasy-team', templateUrl: 'packages/webclient/components/fantasy_team_comp.html', publishAs: 'fantasyTeam', useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    var slots = new List();

    @NgTwoWay("user")
    dynamic get user => _userId;
    set user(dynamic value) {
      _userId = value;
      
      if (_userId != null) {
        if (_isOpponent)  print("opponent: $_userId");
        else              print("mainPlayer: $_userId");
        
        _refreshTeam();
      }
    }    
    
    @NgTwoWay("isOpponent")
    bool get isOpponent => _isOpponent;
    set isOpponent(bool value) {
        _isOpponent = value;
        _refreshHeader();
    }

    @NgTwoWay("showCloseButton")
    bool get showCloseButton => _showCloseButton;
    set showCloseButton(bool value) {
        _showCloseButton = value;
        _refreshCloseButton();
    }

    @NgCallback('onClose') Function onClose;


    FantasyTeamComp(this._liveContestCtrl) {
    }

    // A pesar de que useShadowDom es false, sigue llegando este mensaje y es el primer momento donde podemos hacer un querySelector.
    // Hemos probado attach y el constructor, pero alli parece que todavia no estan creados los hijos. Tiene que ser var y no ShadowRoot
    // pq nos esta llegando un HtmlElement (es logico puesto que useShadowRoot es false)
    void onShadowRoot(var shadowRoot) {
        _rootElement = shadowRoot as HtmlElement;
        _refreshHeader();
        _refreshCloseButton();
    }

    void _refreshHeader() {

        if (_rootElement == null) return;

        var header = _rootElement.querySelector(".fantasy-team-header");

        if (header != null) {
            if (_isOpponent) header.classes.add("opponent-team-gradient"); else header.classes.remove("opponent-team-gradient");
        }
    }

    void _refreshCloseButton() {

        if (_rootElement == null) return;

        var closeButton = _rootElement.querySelector(".close-team");

        if (_showCloseButton) closeButton.classes.remove("ng-hide"); else closeButton.classes.add("ng-hide");
    }
    
    void _refreshTeam() {
      ContestEntry contestEntry = _liveContestCtrl.getContestEntry(_userId);
      print("contestId: ${contestEntry.contestId}");
      
      slots.clear();
      
      // Para el bold: new Element.html("ATM - <b>RMD</b>");
      slots.add({
          "fieldPos": "POR",
          "fullName": "IKER CASILLAS",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "DEF",
          "fullName": "DIEGO LOPEZ",
          "matchEventName": "RMD - VAL",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "DEF",
          "fullName": "JESUS HERNANDEZ",
          "matchEventName": "RMD - ROS",
          "remainingMatchTime": "EMPIEZA 19:00"
      });
      slots.add({
          "fieldPos": "DEF",
          "fullName": "RAPHAEL VARANE",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "DEF",
          "fullName": "PEPE",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "MED",
          "fullName": "SERGIO RAMOS",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "MED",
          "fullName": "NACHO FERNANDEZ",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "EMPIEZA 19:00"
      });
      slots.add({
          "fieldPos": "MED",
          "fullName": "FABIO COENTRAO",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "MED",
          "fullName": "MARCELO",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "DEL",
          "fullName": "ALVARO ARBELOA",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "70 MIN"
      });
      slots.add({
          "fieldPos": "DEL",
          "fullName": "DANIEL CARVAJAL",
          "matchEventName": "ATM - RMD",
          "remainingMatchTime": "EMPIEZA 9:00"
      });
    }

    void onCloseButtonClick() {
        if (onClose != null) onClose();
    }

    HtmlElement _rootElement;
    bool _isOpponent = false;
    bool _showCloseButton = false;
    String _userId = null;
    LiveContestCtrl _liveContestCtrl;
}
