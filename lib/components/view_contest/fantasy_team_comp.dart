library fantasy_team_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/soccer_player.dart";
import 'dart:async';
import 'dart:math';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/instance_soccer_player.dart';

@Component(selector: 'fantasy-team',
           templateUrl: 'packages/webclient/components/view_contest/fantasy_team_comp.html',
           useShadowDom: false)
class FantasyTeamComp implements DetachAware {

    List<dynamic> slots = null;

    String get owner => isOpponent? "opponent" : "me";

    int nameWidth = 105;
  
    @NgOneWay("contest-entry")
    set contestEntry(ContestEntry value) {

      if (_contestEntry != value) {
        // Si nos mandan cambiar de ContestEntry, tenemos que resetear los slots
        _resetSlots();
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

    @NgOneWay("show-changes")
    bool showChanges = false;
    
    @NgOneWay("num-changes")
    int numChanges = 0;
    
    @NgOneWay("changing-soccer-id")
    String changingSoccerId = null;
    
    @NgOneWay("available-salary")
    int availableSalary = 0;

    @NgCallback('on-close')
    Function onClose;

    @NgCallback('on-request-change')
    Function onRequestChange;
    
    int get ordinalChange => (ContestEntry.MAX_CHANGES.toInt() - numChanges) + 1;
    String get changeOrdinalText => getLocalizedText("nthchange", substitutions: {"ORDINAL": ordinalChange}); 

    String get userPosition =>  (_contestEntry != null) ? _contestEntry.contest.getUserPosition(_contestEntry).toString() : "-";
    String get userNickname =>  (_contestEntry != null) ? _contestEntry.user.nickName : "";
    String get userScore =>     (_contestEntry != null) ? StringUtils.parseFantasyPoints(_contestEntry.currentLivePoints) : "0";
    String get remainingTime => (_contestEntry != null) ? "${_contestEntry.percentLeft}%" : "-";
    String get printableAvailableSalary => StringUtils.parseSalary(availableSalary);

    bool get isViewContestEntryMode => _routeProvider.route.name.contains("view_contest_entry");
    bool get isLive => _contestEntry != null ? _contestEntry.contest.isLive : false;
    
    String getLocalizedText(key, {substitutions: null}) {
      return StringUtils.translate(key, "fantasyteam", substitutions);
    }

    String formatCurrency(String amount) {
      return StringUtils.formatCurrency(amount);
    }
    
    FantasyTeamComp(this._routeProvider, this._router, this._rootElement);

    void _refreshTeam() {
      if (_contestEntry == null)
        return;

      if (slots == null) {
        _createSlots();
      }
      else {
        _refreshSlots();
      }
    }

    void _resetSlots() {
      stopTimers();
      slots = null;
    }

    void _createSlots() {

      slots = new List<dynamic>();
      /***** debug ***/
      /*FieldPos.LINEUP.forEach((pos) {
        slots.add(null);
      });*/
      
      _contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {

        String shortNameTeamA = instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamA.shortName;
        String shortNameTeamB = instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamB.shortName;

        var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == instanceSoccerPlayer.soccerTeam.matchEvent.soccerTeamA.templateSoccerTeamId)?
                             "<strong>$shortNameTeamA</strong> - $shortNameTeamB" :
                             "$shortNameTeamA - <strong>$shortNameTeamB<strong>";
        Map player = {
            "id" : instanceSoccerPlayer.id,
            "fieldPos": instanceSoccerPlayer.fieldPos,
            "fullName": instanceSoccerPlayer.soccerPlayer.name,
            "matchEventName": matchEventName,
            "salary": instanceSoccerPlayer.salary,
            "percentOfUsersThatOwn": _contestEntry.contest.getPercentOfUsersThatOwn(instanceSoccerPlayer.soccerPlayer),
            "score": instanceSoccerPlayer.printableCurrentLivePoints,
            "stats": instanceSoccerPlayer.printableLivePointsPerOptaEvent,
            "changeable" : instanceSoccerPlayer.playState == InstanceSoccerPlayer.STATE_NOT_PLAYED 
                           || instanceSoccerPlayer.playState == InstanceSoccerPlayer.STATE_PLAYING
        };

        slots.add(player);
        //addPlayerToFantasyTeam(player);
      });
    }
    /*
    void addPlayerToFantasyTeam(var soccerPlayer, ContestEntry entry) {
      // Buscamos el primer slot libre para la posicion que ocupa el soccer player
      FieldPos theFieldPos = soccerPlayer["fieldPos"];

      for (int c = 0; c < slots.length; ++c) {
        if (slots[c] == null && FieldPos.FORMATIONS[entry.formation][c] == theFieldPos.value) {
          slots[c] = soccerPlayer;
          break;
        }
      }
    }
    */
    /* 
    void addPlayerToFantasyTeam(var soccerPlayer) {
      // Buscamos el primer slot libre para la posicion que ocupa el soccer player
      FieldPos theFieldPos = soccerPlayer["fieldPos"];

      for (int c = 0; c < slots.length; ++c) {
        if (slots[c] == null && FieldPos.LINEUP[c] == theFieldPos.value) {
          slots[c] = soccerPlayer;
          break;
        }
      }
    }
    */


    void _refreshSlots() {

      var random = new Random();

      removeInactiveTimers();

      _contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
        SoccerPlayer soccerPlayer = instanceSoccerPlayer.soccerPlayer;

        // Para el score refrescamos solo el texto y lanzamos una animacion (fade-in/out por ejemplo)
        Element scoreElement = _rootElement.querySelector("[data-id='${soccerPlayer.templateSoccerPlayerId}'] .column-score span");
        Map slot = slots.firstWhere((slot) => 
            slot['id'] == soccerPlayer.templateSoccerPlayerId
            );
        slot["changeable"] = instanceSoccerPlayer.playState == InstanceSoccerPlayer.STATE_NOT_PLAYED 
                             || instanceSoccerPlayer.playState == InstanceSoccerPlayer.STATE_PLAYING;

        if (scoreElement != null && scoreElement.innerHtml != instanceSoccerPlayer.printableCurrentLivePoints) {

          // Un pequeño efecto visual: como que nos vienen unas antes que otras
          int startDelay = random.nextInt(4000);
          
          createTimer(new Duration(milliseconds: startDelay), () {
            scoreElement.innerHtml = instanceSoccerPlayer.printableCurrentLivePoints;

            // Refrescamos el array completo de stats. A medida que lleguen nuevas stats se iran rellenando nuevas rows.
            slot["stats"] = instanceSoccerPlayer.printableLivePointsPerOptaEvent;

            scoreElement.classes.add("changed");
            createTimer(new Duration(seconds: 1), () => scoreElement.classes.remove("changed"));
          });
        }
      });
    }

    void editTeam() {
      _router.go('enter_contest', { "contestId": _contestEntry.contest.contestId ,
                                    "contestEntryId": _contestEntry.contestEntryId,
                                    "parent": _routeProvider.parameters["parent"]});
    }

    void onCloseButtonClick() {
      if (onClose != null)
        onClose();
    }

    @override
    void detach() {
      stopTimers();
    }

    void createTimer(Duration duration, Function callback) {
      _timers.add(new Timer(duration, callback));
    }

    void removeInactiveTimers () {
      _timers.removeWhere((timer) => !timer.isActive);
    }

    void stopTimers() {
      if (_timers.isNotEmpty) {
        _timers.where((timer) => timer.isActive).forEach((timer) => timer.cancel());
        _timers.clear();
      }
    }
    
    bool playerIsChangeable(Map slot) {
      return showChanges && slot['changeable'];
    }
    
    void requestChange(Map slot) {
      InstanceSoccerPlayer player = _contestEntry.instanceSoccerPlayers.firstWhere( (i) => i.id == slot["id"]);
      onRequestChange({'instanceSoccerPlayer': player});
    }

    List<Timer> _timers = new List<Timer>();
    Element _rootElement;
    ContestEntry _contestEntry;

    RouteProvider _routeProvider;
    Router _router;
}
