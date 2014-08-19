library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    var slots = new List();

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {
      _contestEntry = value;
      _refreshTeam();
    }

    @NgOneWay("watch")
    set watch(dynamic value) {
      _refreshTeam();
    }

    @NgOneWay("is-opponent")
    set isOpponent(bool value) {
        _isOpponent = value;
        _refreshHeader();
    }

    @NgOneWay("show-close-button")
    set showCloseButton(bool value) {
        _showCloseButton = value;
        _refreshCloseButton();
    }

    @NgCallback('on-close')
    Function onClose;

    @NgOneWay("mode")
    set mode(String value)
    {
      _mode = value;
    }

    List<Map> liveStatistics = [];

    String get userPosition => (_contestEntry != null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft}" : "-";

    dynamic get scrDet => _viewContestCtrl.scrDet;

    FantasyTeamComp(this._viewContestCtrl) {
      liveStatistics.addAll([
          {'name':'Goles encajados', 'points': 0.00},
          {'name':'paradas', 'points':0.00},
          {'name':'Despejes', 'points':0.00},
          {'name':'Pases', 'points':0.00},
          {'name':'Recuperaciones', 'points':0.00},
          {'name':'Faltas cometidas', 'points':0.00},
          {'name':'Tarjetas amarillas', 'points':0.00},
          {'name':'...', 'points':0.00},
          {'name':'....', 'points':0.00},
          {'name':'.....', 'points':0.00}
      ]);
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

      if (_rootElement == null)
        return;

      var header = _rootElement.querySelector(".fantasy-team-header");

      if (header != null) {
          if (_isOpponent)
            header.classes.add("opponent-team-gradient");
          else
            header.classes.remove("opponent-team-gradient");
      }
    }

    void _refreshCloseButton() {

      if (_rootElement == null)
        return;

      var closeButton = _rootElement.querySelector(".close-team");
      var separator = _rootElement.querySelector(".top-separator");

      if (_showCloseButton) {
        closeButton.classes.remove("ng-hide");
        separator.classes.add("ng-hide");
      }
      else {
        closeButton.classes.add("ng-hide");
        separator.classes.remove("ng-hide");
      }
    }

    void _refreshTeam() {
      slots.clear();

      if (_contestEntry != null) {
        for (SoccerPlayer soccerPlayer in _contestEntry.soccers) {
          String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
          String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
          var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
              ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
              : "$shortNameTeamA - <strong>$shortNameTeamB<strong>";

          slots.add({
              "fieldPos": soccerPlayer.fieldPos,
              "fullName": soccerPlayer.name,
              "matchEventName": matchEventName,
              "percentOfUsersThatOwn": _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer),
              "score": (soccerPlayer.team.matchEvent.isStarted) ? soccerPlayer.currentLivePoints : "-"
          });
        }
      }
    }

    void onRow(int id) {
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;
    bool _isOpponent = false;
    bool _showCloseButton = false;

    ContestEntry _contestEntry;
    ViewContestCtrl _viewContestCtrl;
    String _mode;
}
