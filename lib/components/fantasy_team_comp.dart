library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';

@Component(
           selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false
)
class FantasyTeamComp implements ShadowRootAware {

    var slots = new List();

    @NgTwoWay("user")
    dynamic get user => _userId;
    set user(dynamic value) {
      _userId = value;
      if (_userId != null) {
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

    @NgCallback('onClose')
    Function onClose;

    String getUserPosition() => (_contestEntry != null) ? _liveContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String getUserNickname() => (_contestEntry != null) ? _liveContestCtrl.getUserNickname(_contestEntry) : "";
    String getUserScore() => (_contestEntry != null) ? _liveContestCtrl.getUserScore(_contestEntry).toString() : "0";

    FantasyTeamComp(this._scope, this._liveContestCtrl) {
      _scope.watch("updatedDate", (newValue, oldValue) {
        _refreshTeam();
      }, context: _liveContestCtrl);
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

        if (_showCloseButton)
          closeButton.classes.remove("ng-hide");
        else
          closeButton.classes.add("ng-hide");
    }

    void _refreshTeam() {
      _contestEntry = _liveContestCtrl.getContestEntryWithUser(_userId);

      if (_contestEntry == null)
        return;

      slots.clear();

      for (SoccerPlayer soccerPlayer in _contestEntry.soccers) {
        String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
        String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
        // TODO: No funciona el incrustar codigo Html
        /*
        var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
            ? new Element.html("<b>$shortNameTeamA</b> - $shortNameTeamB")
            : new Element.html("$shortNameTeamA - <b>$shortNameTeamB</b>");
        */
        var matchEventName = "$shortNameTeamA - $shortNameTeamB";

        slots.add({
            "fieldPos": new FieldPos(soccerPlayer.fieldPos),
            "fullName": soccerPlayer.name,
            "matchEventName": matchEventName,
            "remainingMatchTime": "70 MIN",
            "score": _liveContestCtrl.getSoccerPlayerScore(soccerPlayer.templateSoccerPlayerId)
        });
      }
    }

    void onCloseButtonClick() {
        if (onClose != null)
          onClose();
    }

    HtmlElement _rootElement;
    bool _isOpponent = false;
    bool _showCloseButton = false;
    String _userId = null;

    Scope _scope;
    ContestEntry _contestEntry;
    LiveContestCtrl _liveContestCtrl;
}
