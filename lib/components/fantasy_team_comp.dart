library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';
import 'dart:async';
import 'dart:math';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    List<dynamic> slots = null;

    String get owner => isOpponent? "opponent" : "me";

    @NgOneWay("parent")
    set parent(ViewContestCtrl value) {
      _viewContestCtrl = value;
    }

    @NgOneWay("goParent")
    void set goParent(String value) {
      _parent = value;
    }

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {
      // Si nos mandan cambiar de ContestEntry, tenemos que resetear los slots
      if (_contestEntry != value)
        slots = null;

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

    String get userPosition => (_contestEntry != null && _viewContestCtrl!=null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft} min." : "-";

    bool get isViewContestEntryMode => _routeProvider.route.name == "view_contest_entry";

    FantasyTeamComp(this._routeProvider, this._router);

    void onShadowRoot(var shadowRoot) {
      _rootElement = shadowRoot as HtmlElement;

      if (slots == null)
        _refreshTeam();
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
            "percentOfUsersThatOwn": (_viewContestCtrl != null) ? _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer) : "",
            "score": soccerPlayer.printableCurrentLivePoints,
            "stats": soccerPlayer.printableLivePointsPerOptaEvent
        });
      });
    }

    void _refreshSlots() {

      var random = new Random();

      _contestEntry.soccers.forEach((soccerPlayer) {

        // Para el score refrescamos solo el texto y lanzamos una animacion (fade-in/out por ejemplo)
        Element scoreElement = _rootElement.querySelector("[data-id='${soccerPlayer.templateSoccerPlayerId}'] .column-score span");

        if (scoreElement != null && scoreElement.innerHtml != soccerPlayer.printableCurrentLivePoints) {

          // Un pequeño efecto visual: como que nos vienen unas antes que otras
          int startDelay = random.nextInt(4000);

          new Timer(new Duration(milliseconds: startDelay), () {
            scoreElement.innerHtml = soccerPlayer.printableCurrentLivePoints;

            // Refrescamos el array completo de stats. A medida que lleguen nuevas stats se iran rellenando nuevas rows.
            slots.firstWhere((slot) => slot['id'] == soccerPlayer.templateSoccerPlayerId)["stats"] = soccerPlayer.printableLivePointsPerOptaEvent;

            scoreElement.classes.add("changed");
            new Timer(new Duration(seconds: 1), () => scoreElement.classes.remove("changed"));
          });
        }
      });
    }

    void editTeam() {
      print(slots);
      _router.go('edit_contest', { "contestId": _contestEntry.contest.contestId , "contestEntryId": _contestEntry.contestEntryId, "parent": _parent});
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;

    ContestEntry _contestEntry;
    ViewContestCtrl _viewContestCtrl;

    String _parent = "";

    RouteProvider _routeProvider;
    Router _router;

}
