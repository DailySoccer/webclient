library enter_contest_service;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/contest_service.dart';
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';


@Injectable()
class EnterContestService {

  Contest contest;

  bool isSelectingSoccerPlayer = false;

  final List<dynamic> lineupSlots = new List();
  List<dynamic> availableSoccerPlayers = new List();


  EnterContestService(this._contestService) {
    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });
  }
  
  void setup(String contestId) {
    contest = _contestService.getContestById(contestId);
 
    // Al principio, todos disponibles
    initAllSoccerPlayers();
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers); 
  }

  void onSlotSelected(int slotIndex) {

    _selectedLineupPosIndex = slotIndex;

    if (lineupSlots[slotIndex] != null) {
      isSelectingSoccerPlayer = false;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Reseteamos el filtro para volver a mostrarlo entre los disponibles
      setFieldPosFilter(null);
    }
    else {
      isSelectingSoccerPlayer = true;
      setFieldPosFilter(new FieldPos(FieldPos.LINEUP[slotIndex]));
    }
  }

  void onSoccerPlayerSelected(var soccerPlayer) {

    if (isSelectingSoccerPlayer) {
      isSelectingSoccerPlayer = false;
      lineupSlots[_selectedLineupPosIndex] = soccerPlayer;
      setFieldPosFilter(null);
    }
    else {
      bool wasAdded = tryToAddSoccerPlayer(soccerPlayer);

      if (wasAdded)
        availableSoccerPlayers.remove(soccerPlayer);
    }
  }

  void setFieldPosFilter(FieldPos filter) {
    if (filter != null)
      availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"] == filter && !lineupSlots.contains(soccerPlayer)).toList();
    else
      availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();
  }

  // Añade un futbolista a nuestro lineup si hay algun slot libre de su misma fieldPos. Retorna false si no pudo añadir
  bool tryToAddSoccerPlayer(var soccerPlayer) {

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];
    int c = 0;

    for (; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.fieldPos) {
        lineupSlots[c] = soccerPlayer;
        return true;
      }
    }

    return false;
  }

  void _insertSoccerPlayer(MatchEvent matchEvent, SoccerTeam soccerTeam, SoccerPlayer soccerPlayer) {
    _allSoccerPlayers.add(
        {
          "id": "<NoID>",
          "fieldPos": new FieldPos(soccerPlayer.fieldPos),
          "fullName": soccerPlayer.name, 
          "matchEventName": matchEvent.soccerTeamA.shortName + " - " + matchEvent.soccerTeamB.shortName, 
          "remainingMatchTime": "70 MIN",
          "fantasyPoints": 0,
          "matchsPlayed": 23,
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
    
    /*
    _allSoccerPlayers.add({"fieldPos":new FieldPos("GOALKEEPER"), "fullName":"IKER CASILLAS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"DIEGO LOPEZ", "matchEventName": "RMD - VAL", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"JESUS HERNANDEZ", "matchEventName": "RMD - ROS", "remainingMatchTime": "EMPIEZA 19:00"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"RAPHAEL VARANE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("DEFENSE"), "fullName":"PEPE", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"SERGIO RAMOS", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"NACHO FERNANDEZ", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 19:00"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"FABIO COENTRAO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("MIDDLE"), "fullName":"MARCELO", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("FORWARD"), "fullName":"ALVARO ARBELOA", "matchEventName": "ATM - RMD", "remainingMatchTime": "70 MIN"});
    _allSoccerPlayers.add({"fieldPos":new FieldPos("FORWARD"), "fullName":"DANIEL CARVAJAL", "matchEventName": "ATM - RMD", "remainingMatchTime": "EMPIEZA 9:00"});
    */
  }


  var _allSoccerPlayers = new List();
  int _selectedLineupPosIndex = 0;
  ContestService _contestService;
}