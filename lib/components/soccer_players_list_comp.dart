library soccer_players_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';
import "package:webclient/models/match_event.dart";
import "package:webclient/models/instance_soccer_player.dart";

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/soccer_players_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class SoccerPlayersListComp {

  ScreenDetectorService scrDet;

  List<Map<String, String>> matchesList = [];

  @NgOneWay("contest")
  void set contest(Contest value) {
    _contest = value;

    if (_contest != null) {
      _matchesInvolved = _contest.matchEvents;

      matchesList.add({"id":enterContestCtrl.ALL_MATCHES, "texto":"Todos los partidos"});
      for (MatchEvent match in _matchesInvolved) {
        matchesList.add({"id": match.templateMatchEventId, "texto":match.soccerTeamA.shortName + "-" + match.soccerTeamB.shortName});
      }
    }
  }

  dynamic _optionValue;
  dynamic get optionValue => _optionValue;
  void set optionValue (value) {
    _optionValue = value;
    setFilterMatch();
  }

  dynamic oldOptionValue;

  List<FieldPos> posFilterList = [
    new FieldPos("GOALKEEPER"),
    new FieldPos("DEFENSE"),
    new FieldPos("MIDDLE"),
    new FieldPos("FORWARD")
  ];

  EnterContestCtrl enterContestCtrl;

  SoccerPlayersListComp(RouteProvider routeProvider, this.enterContestCtrl, this._contestService, this.scrDet) {

    optionValue = enterContestCtrl.ALL_MATCHES;
  }

 void setFilterMatch() {
    if (optionValue != oldOptionValue) {
      oldOptionValue = optionValue;
      enterContestCtrl.setMatchFilter(optionValue);
    }
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

  @NgCallback("on-row-click")
  Function onRowClick;

  void onRow(String soccerPlayerId) {
    if (onRowClick != null) {
      onRowClick({"soccerPlayerId":soccerPlayerId});
    }
  }

  ActiveContestsService _contestService;

  Contest _contest;
  List<MatchEvent> _matchesInvolved;
}
