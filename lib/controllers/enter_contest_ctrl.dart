library enter_contest_ctrl;


import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contest_service.dart';
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[enter-contest-ctrl]', 
    publishAs: 'ctrl'
)
class EnterContestCtrl {
  
  int availableSalary = 0;

  ScreenDetectorService scrDet;

  Contest contest;

  bool isSelectingSoccerPlayer = false;
  FieldPos lastUsedPosFilter;

  final List<dynamic> lineupSlots = new List();
  List<dynamic> availableSoccerPlayers = new List();
  
  EnterContestCtrl(RouteProvider routeProvider, this._router, this.scrDet, this._profileService, this._contestService, this._flashMessage) {
    
    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });
    
    setup(routeProvider.route.parameters['contestId']);
  }

  void setup(String contestId) {
    contest = _contestService.getContestById(contestId);

    // Al principio, todos disponibles
    initAllSoccerPlayers();
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);
  }

  void cleanTheFilters() {
    InputElement inputText = document.querySelector("#name-player-filter");
    inputText.value = "";
  }
  
  void onSlotSelected(int slotIndex) {
    
    cleanTheFilters();

    _selectedLineupPosIndex = slotIndex;

    if (lineupSlots[slotIndex] != null) {
      isSelectingSoccerPlayer = false;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Reseteamos el filtro para volver a mostrarlo entre los disponibles
      setFieldPosFilter(null);
    } else {
      isSelectingSoccerPlayer = true;
      setFieldPosFilter(new FieldPos(FieldPos.LINEUP[slotIndex]));
    }
  }

  void onSoccerPlayerSelected(var soccerPlayer) {

    if (isSelectingSoccerPlayer) {
      isSelectingSoccerPlayer = false;
      lineupSlots[_selectedLineupPosIndex] = soccerPlayer;
      setFieldPosFilter(null);
    } else {
      bool wasAdded = tryToAddSoccerPlayer(soccerPlayer);

      if (wasAdded) availableSoccerPlayers.remove(soccerPlayer);
    }
  }

  void setNameFilter(String filter) {
    setFieldPosFilter(lastUsedPosFilter);
    availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fullName"].toUpperCase().contains(filter.toUpperCase())).toList(); 
  }

  void setFieldPosFilter(FieldPos filter) {
    if(lastUsedPosFilter != filter)
      lastUsedPosFilter = filter;
    
    if (filter != null) availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"] == filter && !lineupSlots.contains(soccerPlayer)).toList(); else availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();
  }

  // Añade un futbolista a nuestro lineup si hay algun slot libre de su misma fieldPos. Retorna false si no pudo añadir
  bool tryToAddSoccerPlayer(var soccerPlayer) {

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];
    int c = 0;

    for ( ; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.fieldPos) {
        lineupSlots[c] = soccerPlayer;
        return true;
      }
    }

    return false;
  }

  void _insertSoccerPlayer(MatchEvent matchEvent, SoccerTeam soccerTeam, SoccerPlayer soccerPlayer) {
    _allSoccerPlayers.add({
      "id": soccerPlayer.templateSoccerPlayerId,
      "fieldPos": new FieldPos(soccerPlayer.fieldPos),
      "fullName": soccerPlayer.name,
      "matchEventName": matchEvent.soccerTeamA.shortName + " - " + matchEvent.soccerTeamB.shortName,
      "remainingMatchTime": "70 MIN",
      "fantasyPoints": soccerPlayer.fantasyPoints,
      "playedMatches": soccerPlayer.playedMatches,
      "salary": soccerPlayer.salary
    });
  }

  void initAllSoccerPlayers() {
    List<MatchEvent> matchEvents = _contestService.getMatchEventsForContest(contest);

    for (var matchEvent in matchEvents) {
      for (var player in matchEvent.soccerTeamA.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamA, player);
      }

      for (var player in matchEvent.soccerTeamB.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamB, player);
      }
    }
  }

  void createFantasyTeam() {
    // TODO: Se tendría que redireccionar a la pantalla de hacer "Login"?
    if (!_profileService.isLoggedIn) {
      print("login required");
      _router.go('login', {});
      return;
    }

    print("createFantasyTeam");

    print("user: " + _profileService.user.fullName);
    print("contest: " + contest.name);

    List<String> soccerPlayerIds = new List<String>();
    for (dynamic player in lineupSlots) {
      if (player != null) {
        print(player["fieldPos"].fieldPos + ": " + player["fullName"] + " : " + player["id"]);
        soccerPlayerIds.add(player["id"]);
      }
    }

    // TODO: ¿Donde lo redireccionamos?
    _contestService.addContestEntry(contest.contestId, soccerPlayerIds)
      .then((_) => _router.go('lobby', {}))
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  bool isFantasyTeamValid() {
    for (dynamic player in lineupSlots) {
      if (player == null) {
        return false;
      }
    }
    return true;
  }
  
  void deleteFantasyTeam() {
    int i = 0;
    for ( ; i < lineupSlots.length; ++i) {
      lineupSlots[i] = null;
    }
  }
  
  bool isPlayerSelected() {
    for (dynamic player in lineupSlots) {
      if (player != null) {
        return false;
      }
    }
    return true;
  }
  
  void cancelPlayerSelection() {
    isSelectingSoccerPlayer = false;
  }

  var _allSoccerPlayers = new List();
  int _selectedLineupPosIndex = 0;
  Router _router;
  ContestService _contestService;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
}
