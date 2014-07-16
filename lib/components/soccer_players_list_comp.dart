library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';
import "package:webclient/models/match_event.dart";

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class SoccerPlayersListComp {
   
  Contest contest;
  List<MatchEvent> matchesInvolved;
  List<Map<String, String>> matchesList = [];
  dynamic optionValue;
  dynamic oldOptionValue;
  String name_filter;

  EnterContestCtrl enterContestCtrl;

  SoccerPlayersListComp(RouteProvider routeProvider, this.enterContestCtrl, this._contestService) {
    
    setup(routeProvider.route.parameters['contestId']);
  }
  
 void setFilterMatch() {
   if(oldOptionValue != optionValue){
      oldOptionValue = optionValue;
      enterContestCtrl.setMatchFilter(optionValue);
   }
 }
 
 void setFilterSoccerName() {
   enterContestCtrl.setNameFilter(name_filter);
 }
  
 void printElement(String element) {
    print(element);
  }
 
  void setup(String contestId) {
    contest = _contestService.getContestById(contestId);
    var tmplateContest  = _contestService.getTemplateContestById(contest.templateContestId);
    matchesInvolved = _contestService.getMatchEventsForTemplateContest(tmplateContest);
    
    matchesList.add({"id":"-1", "texto":"Todos los partidos"});
    for (MatchEvent match in matchesInvolved) {
      matchesList.add({"id": match.matchEventId, "texto":match.soccerTeamA.shortName + " - " + match.soccerTeamB.shortName});
    }
    optionValue = "-1";
    //matchesList.forEach((element) => printElement(element["texto"]));
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
  
  ContestService _contestService;
}
