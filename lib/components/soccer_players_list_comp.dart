library soccer_players_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayersListComp {

  EnterContestCtrl enterContestCtrl;

  SoccerPlayersListComp(this.enterContestCtrl);
  
  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(String abrevName){
   // Listas de las clases y posiciones
   List<String> classList = ['posPOR', 'posDEF', 'posMED', 'posDEL'];
   List<String> posList = ['POR', 'DEF', 'MED', 'DEL'];
   // Mapeamos clase segun posicion   
   Map<String, String> classMap = new Map.fromIterables(posList, classList);
  
   return classMap[abrevName];
  }
}
