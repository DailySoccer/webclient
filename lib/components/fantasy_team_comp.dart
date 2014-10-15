library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/soccer_player.dart";
import 'dart:async';
import 'dart:math';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    List<dynamic> slots = null;

    String get owner => isOpponent? "opponent" : "me";

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {

      if (_contestEntry != value) {
        slots = null;       // Si nos mandan cambiar de ContestEntry, tenemos que resetear los slots
      }

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

    String get userPosition => (_contestEntry != null) ? _contestEntry.contest.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.percentLeft}%" : "-";

    bool get isViewContestEntryMode => _routeProvider.route.name.contains("view_contest_entry");

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

      _contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {

        String shortNameTeamA = instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamA.shortName;
        String shortNameTeamB = instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamB.shortName;

        var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamA.templateSoccerTeamId)?
                             "<strong>$shortNameTeamA</strong> - $shortNameTeamB" :
                             "$shortNameTeamA - <strong>$shortNameTeamB<strong>";
        slots.add({
            "id" : instanceSoccerPlayer.id,
            "fieldPos": instanceSoccerPlayer.fieldPos,
            "fullName": instanceSoccerPlayer.soccerPlayer.name,
            "matchEventName": matchEventName,
            "salary": instanceSoccerPlayer.salary,
            "percentOfUsersThatOwn": _contestEntry.contest.getPercentOfUsersThatOwn(instanceSoccerPlayer.soccerPlayer),
            "score": instanceSoccerPlayer.printableCurrentLivePoints,
            "stats": instanceSoccerPlayer.printableLivePointsPerOptaEvent
        });
      });
    }

    void _refreshSlots() {

      var random = new Random();

      _contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
        SoccerPlayer soccerPlayer = instanceSoccerPlayer.soccerPlayer;

        // Para el score refrescamos solo el texto y lanzamos una animacion (fade-in/out por ejemplo)
        Element scoreElement = _rootElement.querySelector("[data-id='${soccerPlayer.templateSoccerPlayerId}'] .column-score span");

        if (scoreElement != null && scoreElement.innerHtml != instanceSoccerPlayer.printableCurrentLivePoints) {

          // Un pequeño efecto visual: como que nos vienen unas antes que otras
          int startDelay = random.nextInt(4000);

          new Timer(new Duration(milliseconds: startDelay), () {
            scoreElement.innerHtml = instanceSoccerPlayer.printableCurrentLivePoints;

            // Refrescamos el array completo de stats. A medida que lleguen nuevas stats se iran rellenando nuevas rows.
            slots.firstWhere((slot) => slot['id'] == soccerPlayer.templateSoccerPlayerId)["stats"] = instanceSoccerPlayer.printableLivePointsPerOptaEvent;

            scoreElement.classes.add("changed");
            new Timer(new Duration(seconds: 1), () => scoreElement.classes.remove("changed"));
          });
        }
      });
    }

    void editTeam() {
      _router.go('edit_contest', { "contestId": _contestEntry.contest.contestId ,
                                   "contestEntryId": _contestEntry.contestEntryId,
                                   "parent": _routeProvider.parameters["parent"]});
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    HtmlElement _rootElement;

    ContestEntry _contestEntry;

    RouteProvider _routeProvider;
    Router _router;
}
