library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';
import "package:webclient/models/match_event.dart";

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class SoccerPlayersListComp {

  ScreenDetectorService scrDet;

  Contest contest;
  List<MatchEvent> matchesInvolved;
  List<Map<String, String>> matchesList = [];
  dynamic optionValue;
  dynamic oldOptionValue;
  String nameFilter;

  List<FieldPos> posFilterList = [
    new FieldPos("GOALKEEPER"),
    new FieldPos("DEFENSE"),
    new FieldPos("MIDDLE"),
    new FieldPos("FORWARD")
  ];

  EnterContestCtrl enterContestCtrl;

  SoccerPlayersListComp(RouteProvider routeProvider, this.enterContestCtrl, this._contestService, this.scrDet) {

    contest = _contestService.getContestById(routeProvider.route.parameters['contestId']);
    matchesInvolved = contest.templateContest.matchEvents;

    matchesList.add({"id":"-1", "texto":"Todos los partidos"});
    for (MatchEvent match in matchesInvolved) {
      matchesList.add({"id": match.templateMatchEventId, "texto":match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName});
    }
    optionValue = "-1";
  }

 void setFilterMatch() {
    if(optionValue != oldOptionValue) {
      oldOptionValue = optionValue;
      var a = matchesList.where( (match) => match["id"] == optionValue).first;
      enterContestCtrl.setMatchFilter(optionValue, a["texto"]);
    }
 }

 void setFilterSoccerName() {
   enterContestCtrl.setNameFilter(nameFilter);
 }

 void printElement(String element) {
    print(element);
  }

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(String abrevName){
   // Listas de las clases y posiciones
   List<String> classList = ['posPOR', 'posDEF', 'posMED', 'posDEL'];
   List<String> posList = ['POR', 'DEF', 'MED', 'DEL'];
   // Mapeamos clase segun posicion
   Map<String, String> classMap = new Map.fromIterables(posList, classList);

   return classMap[abrevName];
  }

  int showWidth(String playerName) {
    /*var element = document.querySelector(".soccer-player-name");
    var tamanio_span = element.clientWidth;
    var tamanio_name = playerName.length;
    print(tamanio);
    element.text = element.text + "hola";
    print(playerName);
    element.text = element.text + playerName;

    return tamanio_name - 1;*/
    return 19;
  }

  @NgCallback("onRowClick")
  Function onRowClick;

  void onRow(String soccerPlayerId) {
    if (onRowClick != null)
      onRowClick({"soccerPlayerId":soccerPlayerId});
  }

  ActiveContestsService _contestService;
}
