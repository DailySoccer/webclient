library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:js' as js;
import 'package:webclient/controllers/view_contest_ctrl.dart';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/fantasy_team_comp.html',
           publishAs: 'fantasyTeam',
           useShadowDom: false)
class FantasyTeamComp implements ShadowRootAware {

    var slots = new List();
    String _owner = "";
    String get owner => _owner;

    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {
      _contestEntry = value;
      if(value != null)
        _refreshTeam();
    }

    @NgOneWay("watch")
    set watch(dynamic value) {
      backUpStatistics();
      _refreshTeam();
    }

    @NgOneWay("is-opponent")
    set isOpponent(bool value) {
      _owner = value ? "opponent" : "me";
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

    dynamic soccerPlayerEventsModal;

    String get userPosition => (_contestEntry != null) ? _viewContestCtrl.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname => (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore => (_contestEntry != null) ? _contestEntry.currentLivePoints.toString() : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.timeLeft}" : "-";

    dynamic get scrDet => _viewContestCtrl.scrDet;

    FantasyTeamComp(this._viewContestCtrl);

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
      //backUpStatistics();

      slots.clear();

      if (_contestEntry != null) {
        //TODO: actualizar los datos de la lista de slots, sin recrearla de nuevo. Buscar los jugadores y actualizar buscandolo por ID.

        _contestEntry.soccers.forEach((soccerPlayer) {
          String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
          String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
          var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
              ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
              : "$shortNameTeamA - <strong>$shortNameTeamB<strong>";

          List<Map> soccerPlayerStats = [];

          soccerPlayer.eventLivePoints.forEach((key,value) {
            if (eventKeyToName.containsKey(key)) {
              soccerPlayerStats.add({'name':eventKeyToName[key], 'points':value});
            }
            else {
              soccerPlayerStats.add({'name':"???", 'points':value});
            }
          });

          slots.add({
              "id" : soccerPlayer.templateSoccerPlayerId,
              "fieldPos": soccerPlayer.fieldPos,
              "fullName": soccerPlayer.name,
              "matchEventName": matchEventName,
              "percentOfUsersThatOwn": _viewContestCtrl.getPercentOfUsersThatOwn(soccerPlayer),
              "score": (soccerPlayer.team.matchEvent.isStarted) ? soccerPlayer.currentLivePoints : "-",
              "stats": soccerPlayerStats
          });
        });
      }
    }

    void backUpStatistics() {
      collapsables.clear();
      var coll = document.getElementsByClassName('soccer-player-statistics collapse');
      coll.forEach((Element element) {
        var classes = element.classes.toString();
        var style = element.style;
        var id = element.id;

        Map css = { id : {"classes" : classes.toString(), "height" : style.height} };
        collapsables.addAll(css);
      });
      print("backup de los estilos de los collapsables");
    }

    String restoreStatisticsCss(String id) {
      String retorno = "";
      if(collapsables.isNotEmpty) {
        Map css = collapsables[id];
        if(css != null){
          if (css["classes"] != null) {
            retorno =  css["classes"];
          }
        }
      }
      return retorno;
    }


    void onRow(dynamic soccerPlayerData) {
      soccerPlayerEventsModal = soccerPlayerData["stats"];
      if (scrDet.isDesktop) {
        // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
        var modal = querySelector('#soccerPlayerEventModal_'+owner);
        modal.style.display = "block";
        // Con esto llamamos a funciones de jQuery
        js.context.callMethod(r'$', ['#soccerPlayerEventModal_'+owner]).callMethod('modal');
      }
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

    Map collapsables = {};

    final Map<String, String> eventKeyToName = {
      "PASS_SUCCESSFUL"   : "Pass Successful",
      "PASS_UNSUCCESSFUL" : "Pass Unsuccessfull",
      "TAKE_ON"           : "Take On",
      "FOUL_RECEIVED"     : "Foul Received",
      "TACKLE"            : "Tackle",
      "INTERCEPTION"      : "Interception",
      "SAVE"              : "Save",
      "CLAIM"             : "Claim",
      "CLEARANCE"         : "Clearance",
      "MISS"              : "Miss",
      "POST"              : "Post",
      "ATTEMPT_SAVED"     : "Attempt Saved",
      "YELLOW_CARD"       : "Yellow Card",
      "PUNCH"             : "Punch",
      "DISPOSSESSED"      : "Dispossessed",
      "ERROR"             : "Error",
      "ASSIST"            : "Assist",
      "TACKLE_EFFECTIVE"  : "Tackle Effective",
      "GOAL_SCORED_BY_GOALKEEPER" : "Goal",
      "GOAL_SCORED_BY_DEFENDER"   : "Goal",
      "GOAL_SCORED_BY_MIDFIELDER" : "Goal",
      "GOAL_SCORED_BY_FORWARD"    : "Goal",
      "OWN_GOAL"          : "Own Goal",
      "FOUL_COMMITTED"    : "Foul Committed",
      "SECOND_YELLOW_CARD": "Second Yellow Card",
      "RED_CARD"          : "Red Card",
      "CAUGHT_OFFSIDE"    : "Offside",
      "PENALTY_COMMITTED" : "Penalty Committed",
      "PENALTY_FAILED"    : "Penalty Failed",
      "GOALKEEPER_SAVES_PENALTY"  : "Saves Penalty",
      "CLEAN_SHEET"       : "Clean Sheet",
      "GOAL_CONCEDED"     : "Goal Conceded"
    };

}
