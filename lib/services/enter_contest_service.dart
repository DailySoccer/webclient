library enter_contest_service;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';


@Injectable()
class EnterContestService {

  Contest contest;

  bool isSelectingSoccerPlayer = false;

  final List<dynamic> lineupSlots = new List();
  List<dynamic> availableSoccerPlayers = new List();


  EnterContestService(this._contestService) {
    //contest = _contestService.getContestById(routeProvider.parameters['contestId']);

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });

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


  void initAllSoccerPlayers() {
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
  }


  var _allSoccerPlayers = new List();
  int _selectedLineupPosIndex = 0;
  ContestService _contestService;
}