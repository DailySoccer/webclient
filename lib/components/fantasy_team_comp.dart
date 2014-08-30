library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    List<dynamic> slots = null;

    String get owner => isOpponent? "opponent" : "me";

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
    bool isOpponent = false;

    @NgOneWay("show-close-button")
    bool showCloseButton = false;

    @NgCallback('on-close')
    Function onClose;

    String get userPosition => (_contestEntry != null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft} min." : "-";

    FantasyTeamComp(this._viewContestCtrl);

    void onShadowRoot(var shadowRoot) {
      _rootElement = shadowRoot as HtmlElement;
    }

    void _refreshTeam() {
      if (_rootElement == null || _contestEntry == null)
        return;

      if (slots == null) {
        _createSlots();
      }
      else {
        _refreshSlots();
      }
    }

    void _createSlots() {

      slots = new List<dynamic>();

      _contestEntry.soccers.forEach((soccerPlayer) {
        String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
        String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
        var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)?
                             "<strong>$shortNameTeamA</strong> - $shortNameTeamB" :
                             "$shortNameTeamA - <strong>$shortNameTeamB<strong>";

        slots.add({
            "id" : soccerPlayer.templateSoccerPlayerId,
            "fieldPos": soccerPlayer.fieldPos,
            "fullName": soccerPlayer.name,
            "matchEventName": matchEventName,
            "percentOfUsersThatOwn": _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer),
            "score": soccerPlayer.printableCurrentLivePoints,
            "stats": soccerPlayer.printableLivePointsPerOptaEvent
        });
      });
    }

    void _refreshSlots() {
      _contestEntry.soccers.forEach((soccerPlayer) {

        // Para el score, refrescamos solo el texto y lanzamos una animacion (rojo fade-in/out por ejemplo)
        Element scoreElement = _rootElement.querySelector("[data-id='${soccerPlayer.templateSoccerPlayerId}'] .column-score");

        if (scoreElement != null)
          scoreElement.innerHtml = soccerPlayer.printableCurrentLivePoints;

        // Refrescamos el array completo de stats. A medida que lleguen nuevas stats se iran rellenando nuevas rows.
        slots.firstWhere((slot) => slot['id'] == soccerPlayer.templateSoccerPlayerId)["stats"] = soccerPlayer.printableLivePointsPerOptaEvent;
      });
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;

    ContestEntry _contestEntry;
    ViewContestCtrl _viewContestCtrl;
}
